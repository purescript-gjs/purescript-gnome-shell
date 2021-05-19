module Gnome.Extension where

import Prelude (Unit)
import Effect (Effect)

type Extension a
  = { enable :: Effect a
    , disable :: a -> Effect Unit
    }
