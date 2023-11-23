"use strict";

import * as ExtensionUtils from 'resource:///org/gnome/shell/misc/extensionUtils.js';

export const getCurrentExtension = () => ExtensionUtils.getCurrentExtension()

export const getPath = (ext) => name => () => ext.dir.get_child(name).get_path()
