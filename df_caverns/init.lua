df_caverns = {}

--grab a shorthand for the filepath of the mod
local modpath = minetest.get_modpath(minetest.get_current_modname())

--load companion lua files
dofile(modpath.."/config.lua")

dofile(modpath.."/biomes.lua")
dofile(modpath.."/level1.lua")
dofile(modpath.."/level2.lua")
dofile(modpath.."/level3.lua")
dofile(modpath.."/sunless_sea.lua")
dofile(modpath.."/lava_sea.lua")

dofile(modpath.."/underworld.lua")