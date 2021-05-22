module Gnome.Extension where

import Prelude (Unit)
import Effect (Effect)

type ExtensionSimple env
  = { enable :: Effect env
    , disable :: env -> Effect Unit
    }

type Extension settings env
  = { init :: Effect settings
    , enable :: settings -> Effect env
    , disable :: env -> Effect Unit
    }
