"use strict";

import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';
import * as BoxPointer from 'resource:///org/gnome/shell/ui/boxpointer.js';

export const newButton = (alignment) => (name) => (dontCreateMenu) => () =>
  new PanelMenu.Button(alignment, name, dontCreateMenu);

export const addMenuItem = button => item => () => button.menu.addMenuItem(item)

export const toggle = button => () => button.menu.toggle()

export const removeAll = button => () => button.menu.removeAll()

export const open = button => () => button.menu.open(BoxPointer.PopupAnimation.FULL);

export const close = button => () => button.menu.close(BoxPointer.PopupAnimation.FULL);
