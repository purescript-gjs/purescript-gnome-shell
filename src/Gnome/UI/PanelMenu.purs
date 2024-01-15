module Gnome.UI.PanelMenu where

import Effect (Effect)
import Prelude (Unit)
import Gnome.UI.PopupMenu (PopupMenuItem)
import GObject (class GObject)
import Gtk4 (class Widget)
import Clutter.Actor (class Actor)

foreign import data Button :: Type

instance obj :: GObject Button
instance widget :: Widget Button
instance actor :: Actor Button

foreign import newButton :: Number -> String -> Boolean -> Effect Button

foreign import addMenuItem :: Button -> PopupMenuItem -> Effect Unit

foreign import toggle :: Button -> Effect Unit

foreign import removeAll :: Button -> Effect Unit

foreign import open :: Button -> Effect Unit

foreign import close :: Button -> Effect Unit
