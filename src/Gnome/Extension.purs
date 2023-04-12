module Gnome.Extension where

import Prelude (Unit)
import Effect (Effect)

type ExtensionSimple env
  = { extension_enable :: Effect env
    , extension_disable :: env -> Effect Unit
    }

type Extension settings env
  = { extension_init :: Effect settings
    , extension_enable :: settings -> Effect env
    , extension_disable :: env -> Effect Unit
    }
