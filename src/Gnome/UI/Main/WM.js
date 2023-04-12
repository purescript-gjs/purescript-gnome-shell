"use strict";

let Main;
try { Main = imports.ui.main; } catch (_) {}

export const addKeybinding = name => settings => flags => modes => handler => () =>
  Main.wm.addKeybinding(name, settings, flags, modes, handler)
export const removeKeybinding = name => () => Main.wm.removeKeybinding(name)
