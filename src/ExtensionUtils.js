"use strict";

export const getCurrentExtension = () => imports.misc.extensionUtils.getCurrentExtension()

export const getPath = (ext) => name => () => ext.dir.get_child(name).get_path()
