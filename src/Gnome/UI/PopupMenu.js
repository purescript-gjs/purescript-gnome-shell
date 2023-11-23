"use strict";

import * as PopupMenu from 'resource:///org/gnome/shell/ui/popupMenu.js';

export const newItem = name => () =>
  new PopupMenu.PopupMenuItem(name);

export const connectActivate = item => cb => () => item.connect("activate", cb)
