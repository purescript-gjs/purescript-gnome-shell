"use strict";

let St;
try { St = imports.gi.St; } catch(_) {}

export const new_ = () => St.Icon.new()
export const set_gicon = icon => gicon => () => icon.set_gicon(gicon)
