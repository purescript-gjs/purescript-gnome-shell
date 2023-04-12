{ name = "gnome-shell"
, dependencies = [ "effect", "gjs", "maybe", "nullable", "prelude" ]
, packages =
    https://github.com/purescript/package-sets/releases/download/psc-0.15.7-20230408/packages.dhall
      sha256:eafb4e5bcbc2de6172e9457f321764567b33bc7279bd6952468d0d422aa33948
  with gjs = ../purescript-gjs/spago.dhall as Location
, sources = [ "src/**/*.purs" ]
}
