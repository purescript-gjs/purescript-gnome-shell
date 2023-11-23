"use strict";

import * as PanelMenu from 'resource:///org/gnome/shell/ui/panelMenu.js';

export const newButton = (alignment) => (name) => (dontCreateMenu) => () =>
  new PanelMenu.Button(alignment, name, dontCreateMenu);

export const addMenuItem = button => item => () => button.menu.addMenuItem(item)
