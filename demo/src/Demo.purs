module Demo where

import Prelude
import Effect (Effect)
import Gnome.Extension (Extension)
import GJS as GJS

type Env = Unit

extension :: Extension Unit Env
extension = { init, enable, disable}
  where
  init = do
    GJS.log "init called"
    pure unit

  enable _settings = do
    GJS.log "enable called"
    pure unit

  disable env = do
    GJS.log "disable called"
    pure unit

main :: Effect Unit
main = pure unit
