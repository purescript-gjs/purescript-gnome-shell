let Extension =
      { Type =
          { name : Text
          , domain : Text
          , description : Text
          , version : Natural
          , url : Text
          }
      , default = {=}
      }

let render =
      \(extension : Extension.Type) ->
        { `.gitattributes` =
            "/${extension.name}@${extension.domain}/ linguist-generated=true"
        , Makefile =
            ''
            # TODO: replace dependency by a known location
            PGS := "../package.dhall"

            NAME := $(shell sh -c 'echo "($(PGS)).uid ./extension.dhall" | dhall text')
            MAIN := $(shell sh -c 'echo "($(PGS)).main ./extension.dhall" | dhall text')

            .PHONY: install
            install:
            	mkdir -p ~/.local/share/gnome-shell/extensions/
            	ln -s $(PWD)/$(NAME)/ ~/.local/share/gnome-shell/extensions/$(NAME)

            .PHONY: dist
            dist: dist-meta dist-extension

            .PHONY: dist-meta
            dist-meta:
            	mkdir -p $(NAME)
            	echo "($(PGS)).metadata ./extension.dhall" | dhall-to-json --output $(NAME)/metadata.json

            .PHONY: dist-extension
            dist-extension:
            	spago bundle-module -m $(MAIN) --to $(NAME)/extension.js
            	sed -e 's/^module.exports.*//' -i $(NAME)/extension.js
            	echo "($(PGS)).boot ./extension.dhall" | dhall text >> $(NAME)/extension.js

            .PHONY: test
            test:
            	dbus-run-session -- gnome-shell --nested --wayland

            .PHONE: update
            update:
            	echo "($(PGS)).render ./extension.dhall" | dhall to-directory-tree --output .
            ''
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

in  { Extension, render, uid, main, boot, metadata }
