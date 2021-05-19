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
