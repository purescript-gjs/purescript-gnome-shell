"use strict";

let St;
try { St = imports.gi.St; } catch(_) {}

export const unsafe_add_style_class_name = widget => name => () => widget.add_style_class_name(name)
export const unsafe_remove_style_class_name = widget => name => () => widget.remove_style_class_name(name)
export const unsafe_set_style = widget => style => () => widget.set_style(style)
