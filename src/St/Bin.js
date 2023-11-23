"use strict";

import St from 'gi://St'

export const new_ = () => St.Bin.new()

export const unsafe_set_child = bin => child => () => bin.set_child(child)
