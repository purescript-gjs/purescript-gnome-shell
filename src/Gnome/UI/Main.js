"use strict";

import * as Main from 'resource:///org/gnome/shell/ui/main.js';

export const notify = msg => details => () => Main.notify(msg, details)

const defaultParams = {
};

export const unsafe_addChrome = actor => () => Main.layoutManager.addChrome(actor, defaultParams);
export const unsafe_addTopChrome = actor => () => Main.layoutManager.addTopChrome(actor, defaultParams);
export const unsafe_removeChrome = actor => () => Main.layoutManager.removeChrome(actor);
