"use strict";

let PopupMenu;
try { PopupMenu = imports.ui.popupMenu; } catch(_) {}

export const newItem = name => () =>
  new PopupMenu.PopupMenuItem(name);

export const connectActivate = item => cb => () => item.connect("activate", cb)
