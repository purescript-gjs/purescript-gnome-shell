"use strict";

import St from 'gi://St'

export const new_ = () => St.BoxLayout.new()

export const set_vertical = box => b => () => box.set_vertical(b)
