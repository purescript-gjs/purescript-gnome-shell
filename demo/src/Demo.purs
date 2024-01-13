module Demo where

import Prelude
import Effect (Effect)
import Gnome.Extension (Extension)
import GJS as GJS

type Env = Unit

extension :: Extension Unit Env
extension = { extension_init, extension_enable, extension_disable}
  where
  extension_init _ = do
    GJS.log "init called"
    pure unit

  extension_enable _settings = do
    GJS.log "enable called"
    pure unit

  extension_disable _env = do
    GJS.log "disable called"
    pure unit

main :: Effect Unit
main = pure unit
