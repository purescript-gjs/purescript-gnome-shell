"use strict";

let St;
try { St = imports.gi.St; } catch(_) {}

export const new_ = () => St.BoxLayout.new()

export const set_vertical = box => b => () => box.set_vertical(b)
