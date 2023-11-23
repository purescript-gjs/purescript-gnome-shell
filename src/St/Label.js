"use strict";

import St from 'gi://St'

export const new_ = txt => () => St.Label.new(txt)
export const set_text = label => txt => () => label.set_text(txt)
