df_mapitems = {}

--grab a shorthand for the filepath of the mod
local modpath = minetest.get_modpath(minetest.get_current_modname())

--load companion lua files
dofile(modpath.."/config.lua")
dofile(modpath.."/doc.lua")
dofile(modpath.."/aliases.lua")

dofile(modpath.."/ground_cover.lua")
dofile(modpath.."/glow_worms.lua")
dofile(modpath.."/flowstone.lua")
dofile(modpath.."/glow_crystals.lua")
dofile(modpath.."/snareweed.lua")
dofile(modpath.."/cave_coral.lua")

dofile(modpath.."/slade.lua")
dofile(modpath.."/underworld_shard.lua")
dofile(modpath.."/glow_pit.lua")
