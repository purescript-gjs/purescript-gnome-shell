"use strict";

import St from 'gi://St'

export const new_ = () => St.Icon.new()
export const set_gicon = icon => gicon => () => icon.set_gicon(gicon)
