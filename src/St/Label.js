"use strict";

let St;
try { St = imports.gi.St; } catch(_) {}

exports.new = txt => () => St.Label.new(txt)
exports.set_text = label => txt => () => label.set_text(txt)
