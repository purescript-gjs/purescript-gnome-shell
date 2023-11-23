"use strict";

import * as Main from 'resource:///org/gnome/shell/ui/main.js';

export const addToStatusArea = role => indicator => () => Main.panel.addToStatusArea(role, indicator)
