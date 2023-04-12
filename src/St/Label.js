"use strict";

let St;
try { St = imports.gi.St; } catch(_) {}

export const new = txt => () => St.Label.new(txt)
export const set_text = label => txt => () => label.set_text(txt)
