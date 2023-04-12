# TODO: replace dependency by a known location
PGS := "~/src/github.com/purescript-gjs/purescript-gnome-shell/package.dhall"

NAME := $(shell sh -c 'echo "($(PGS)).uid ./extension.dhall" | env PGS=$(PGS) dhall text')
MAIN := $(shell sh -c 'echo "($(PGS)).main ./extension.dhall" | env PGS=$(PGS) dhall text')

.PHONY: dist
dist: dist-meta dist-schemas dist-extension

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
	env PGS=$(PGS) spago bundle-module -m $(MAIN) --to $(NAME)/extension.js
	sed -e '/^export {/,/^};/d' -i $(NAME)/extension.js
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
