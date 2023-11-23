"use strict";

import St from 'gi://St'

export const new_ = () => St.Button.new()
export const new_with_label = label => () => St.Button.new_with_label(label)
