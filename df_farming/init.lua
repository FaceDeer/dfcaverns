df_farming = {}

local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)

--load companion lua files
dofile(modpath.."/config.lua")
dofile(modpath.."/doc.lua")
dofile(modpath.."/aliases.lua")

dofile(modpath.."/plants.lua") -- general functions
dofile(modpath.."/growth_conditions.lua")
dofile(modpath.."/cave_wheat.lua")
dofile(modpath.."/dimple_cup.lua")
dofile(modpath.."/pig_tail.lua")
dofile(modpath.."/plump_helmet.lua")
dofile(modpath.."/quarry_bush.lua")
dofile(modpath.."/sweet_pod.lua")
dofile(modpath.."/cooking.lua")
