module St.BoxLayout where

import Prelude (Unit)
import Effect (Effect)
import GObject (class GObject)
import St (class Widget)
import Clutter.Actor (class Actor)

foreign import data BoxLayout :: Type

instance obj :: GObject BoxLayout
instance widget :: Widget BoxLayout
instance actor :: Actor BoxLayout

foreign import new_ :: Effect BoxLayout

new :: Effect BoxLayout
new = new_

foreign import set_vertical :: BoxLayout -> Boolean -> Effect Unit
