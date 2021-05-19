module Demo where

import Prelude
import Effect (Effect)
import Gnome.Extension (Extension)
import GJS as GJS

type Env = Unit

extension :: Extension Env
extension = { enable, disable}
  where
  enable = do
    GJS.log "enable called"
    pure unit

  disable env = do
    GJS.log "disable called"
    pure unit
