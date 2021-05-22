module Gnome.UI.Main.Panel where

import Prelude (Unit)
import Effect (Effect)
import Gnome.UI.PanelMenu as Gnome.UI.PanelMenu

foreign import addToStatusArea :: String -> Gnome.UI.PanelMenu.Button -> Effect Unit
