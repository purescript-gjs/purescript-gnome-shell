let Prelude =
      https://prelude.dhall-lang.org/v17.0.0/package.dhall sha256:10db3c919c25e9046833df897a8ffe2701dc390fa0893d958c3430524be5a43e

let Extension =
      let _Type =
            { name : Text
            , module : Text
            , domain : Text
            , description : Text
            , version : Double
            , url : Text
            , settings : Optional (List Prelude.XML.Type)
            }

      let hasSettings =
            \(extension : _Type) ->
              Prelude.Bool.not
                ( Prelude.Optional.null
                    (List Prelude.XML.Type)
                    extension.settings
                )

      in  { Type = _Type
          , default = { settings = None (List Prelude.XML.Type), version = 0.1 }
          , hasSettings
          }

let setting =
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

let intSetting =
      \(name : Text) ->
      \(default : Natural) ->
        setting name "i" (Natural/show default)

let floatSetting =
      \(name : Text) ->
      \(default : Double) ->
        setting name "d" (Double/show default)

let keySetting =
      \(name : Text) ->
      \(key : Text) ->
        setting name "as" "<![CDATA[['${key}']]]>"

let toSchema =
      \(extension : Extension.Type) ->
        let content =
              merge
                { Some = \(content : List Prelude.XML.Type) -> content
                , None = [] : List Prelude.XML.Type
                }
                extension.settings

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
      \(withSettings : Bool) ->
        let dist-schemas = if withSettings then "dist-schemas " else ""

        in  ''
            # TODO: replace dependency by a known location
            PGS := "~/src/github.com/purescript-gjs/purescript-gnome-shell/package.dhall"

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
        , Makefile = Makefile (Extension.hasSettings extension)
        }

let uid =
      \(extension : Extension.Type) -> "${extension.name}@${extension.domain}"

let main = \(extension : Extension.Type) -> extension.module

let boot =
      \(extension : Extension.Type) ->
        let env = "${extension.module}Env"

        let settings = "${extension.module}Settings"

        let module = "PS[\"${main extension}\"][\"extension\"]"

        let base =
              ''

              // necessary footer to transform a spago build into a valid gnome extension
              let ${env} = null;
              ''

        let simple =
              ''
              function init() {}
              function enable() { ${env} = ${module}.enable(); }
              function disable() { ${module}.disable(${env})(); }
              ''

        let setting =
              ''
              let ${settings} = null;
              function init() { ${settings} = ${module}.init(); }
              function enable() { ${env} = ${module}.enable(${settings})(); }
              function disable() { ${module}.disable(${env})(); }
              ''

        in  if    Extension.hasSettings extension
            then  base ++ setting
            else  base ++ simple

let metadata =
      \(extension : Extension.Type) ->
        { uuid = "${extension.name}@${extension.domain}"
        , name = extension.name
        , description = extension.description
        , version = extension.version
        , shell-version = [ "40.0", "41" ]
        , url = extension.url
        }

in  { Extension
    , render
    , uid
    , main
    , boot
    , metadata
    , renderSchema
    , intSetting
    , floatSetting
    , keySetting
    }
