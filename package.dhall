let Prelude =
      https://prelude.dhall-lang.org/v17.0.0/package.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e

let Extension =
      { Type =
          { name : Text
          , domain : Text
          , description : Text
          , version : Natural
          , url : Text
          , options : Optional (List Prelude.XML.Type)
          }
      , default = { options = None (List Prelude.XML.Type), version = 1 }
      }

let option =
      \(name : Text) ->
      \(type : Text) ->
      \(default : Text) ->
        Prelude.XML.element
          { name = "key"
          , attributes = toMap { name, type }
          , content =
            [ Prelude.XML.element
                { name = "default"
                , attributes = Prelude.XML.emptyAttributes
                , content = [ Prelude.XML.text default ]
                }
            ]
          }

let intOption =
      \(name : Text) ->
      \(default : Natural) ->
        option name "i" (Natural/show default)

let floatOption =
      \(name : Text) ->
      \(default : Double) ->
        option name "d" (Double/show default)

let keyOption =
      \(name : Text) ->
      \(key : Text) ->
        option name "as" "<![CDATA[['${key}']]]>"

let toSchema =
      \(extension : Extension.Type) ->
        let content =
              merge
                { Some = \(content : List Prelude.XML.Type) -> content
                , None = [] : List Prelude.XML.Type
                }
                extension.options

        in  Prelude.XML.element
              { name = "schema"
              , attributes = toMap
                  { id = "org.gnome.shell.extensions.${extension.name}"
                  , path = "/org/gnome/shell/extensions/${extension.name}/"
                  }
              , content
              }

let renderSchema =
      \(extension : Extension.Type) ->
            ''
            <?xml version="1.0" encoding="UTF-8"?>
            ''
        ++  Prelude.XML.render
              ( Prelude.XML.element
                  { name = "schemalist"
                  , attributes = Prelude.XML.emptyAttributes
                  , content = [ toSchema extension ]
                  }
              )

let Makefile =
      \(withoutSchema : Bool) ->
        let dist-schemas = if withoutSchema then "" else "dist-schemas "

        in  ''
            # TODO: replace dependency by a known location
            PGS := "../package.dhall"

            NAME := $(shell sh -c 'echo "($(PGS)).uid ./extension.dhall" | env PGS=$(PGS) dhall text')
            MAIN := $(shell sh -c 'echo "($(PGS)).main ./extension.dhall" | env PGS=$(PGS) dhall text')

            .PHONY: dist
            dist: dist-meta ${dist-schemas}dist-extension

            .PHONY: dist-meta
            dist-meta:
            	mkdir -p $(NAME)
            	echo "($(PGS)).metadata ./extension.dhall" | env PGS=$(PGS) dhall-to-json --output $(NAME)/metadata.json

            .PHONY: dist-schemas
            dist-schemas:
            	mkdir -p $(NAME)/schemas
            	echo "($(PGS)).renderSchema ./extension.dhall" | env PGS=$(PGS) dhall text --output $(NAME)/schemas/autochill.gschema.xml
            	glib-compile-schemas $(NAME)/schemas/

            .PHONY: dist-extension
            dist-extension:
            	env PGS=$(PGS) spago bundle-app -m $(MAIN) --to $(NAME)/extension.js
            	echo "($(PGS)).boot ./extension.dhall" | env PGS=$(PGS) dhall text >> $(NAME)/extension.js

            .PHONY: install
            install:
            	mkdir -p ~/.local/share/gnome-shell/extensions/
            	ln -s $(PWD)/$(NAME)/ ~/.local/share/gnome-shell/extensions/$(NAME)

            .PHONY: test
            test:
            	dbus-run-session -- gnome-shell --nested --wayland

            .PHONE: update
            update:
            	echo "($(PGS)).render ./extension.dhall" | env PGS=$(PGS) dhall to-directory-tree --output .
            ''

let render =
      \(extension : Extension.Type) ->
        { `.gitattributes` =
            ''
            /${extension.name}@${extension.domain}/ linguist-generated=true
            ''
        , Makefile =
            Makefile
              (Prelude.Optional.null (List Prelude.XML.Type) extension.options)
        }

let uid =
      \(extension : Extension.Type) -> "${extension.name}@${extension.domain}"

let main = \(extension : Extension.Type) -> extension.name

let boot =
      \(extension : Extension.Type) ->
        let env = "${extension.name}Env"

        let module = "PS[\"${main extension}\"]"

        let extension = "${module}[\"extension\"]"

        in  ''

            // necessary footer to transform a spago build into a valid gnome extension
            let ${env} = null;
            function init() {}
            function enable() { ${env} = ${extension}.enable(); }
            function disable() { ${extension}.disable(${env})(); }
            ''

let metadata =
      \(extension : Extension.Type) ->
        { uuid = "${extension.name}@${extension.domain}"
        , name = extension.name
        , description = extension.description
        , version = extension.version
        , shell-version = [ "40.0" ]
        , url = extension.url
        }

in  { Extension
    , render
    , uid
    , main
    , boot
    , metadata
    , renderSchema
    , intOption
    , floatOption
    , keyOption
    }
