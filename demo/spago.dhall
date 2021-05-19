{ name = (./extension.dhall).name
, dependencies = [ "console", "effect", "psci-support", "gjs", "gnome-shell" ]
, packages =
    https://github.com/purescript/package-sets/releases/download/psc-0.14.0-20210402/packages.dhall sha256:0cfaa5de499bd629f5263daff3261144d9d348d38a451b7938a6f52054c3a086
  with gjs = ../../purescript-gjs/spago.dhall as Location
  with gnome-shell = ../spago.dhall as Location
, sources = [ "src/**/*.purs" ]
}
