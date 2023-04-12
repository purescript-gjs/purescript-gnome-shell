"use strict";

let Main;
try { Main = imports.ui.main; } catch (_) {}

export const addToStatusArea = role => indicator => () => Main.panel.addToStatusArea(role, indicator)
