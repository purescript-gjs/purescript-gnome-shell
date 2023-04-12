"use strict";

let PanelMenu;
try { PanelMenu = imports.ui.panelMenu; } catch (_) {}

export const newButton = (alignment) => (name) => (dontCreateMenu) => () =>
  new PanelMenu.Button(alignment, name, dontCreateMenu);

export const addMenuItem = button => item => () => button.menu.addMenuItem(item)
