"use strict";

let St;
try { St = imports.gi.St; } catch(_) {}

export const new = () => St.Button.new()
export const new_with_label = label => () => St.Button.new_with_label(label)
