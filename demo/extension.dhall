(env:PGS).Extension::{
, name = "demo"
, module = "Demo"
, domain = "purescript-gjs.github.io"
, description = "a demo extension"
, settings = Some [ (env:PGS).intSetting "int-setting" 42 ]
, url = "https://github.com/purescript-gjs"
}
