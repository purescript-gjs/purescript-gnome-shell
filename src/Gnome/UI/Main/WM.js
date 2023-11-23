"use strict";

import * as Main from 'resource:///org/gnome/shell/ui/main.js';

export const addKeybinding = name => settings => flags => modes => handler => () =>
  Main.wm.addKeybinding(name, settings, flags, modes, handler)
export const removeKeybinding = name => () => Main.wm.removeKeybinding(name)
