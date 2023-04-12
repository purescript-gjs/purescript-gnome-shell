"use strict";

let St;
try { St = imports.gi.St; } catch(_) {}

export const new = () => St.Bin.new()

export const unsafe_set_child = bin => child => () => bin.set_child(child)
