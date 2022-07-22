df_trees = {}

local modname = minetest.get_current_modname()
df_trees.S = minetest.get_translator(modname)
local modpath = minetest.get_modpath(modname)

--load companion lua files
dofile(modpath.."/config.lua")
dofile(modpath.."/dependencies.lua")
dofile(modpath.."/doc.lua")
dofile(modpath.."/aliases.lua")

local S = df_trees.S

dofile(modpath.."/blood_thorn.lua")
dofile(modpath.."/fungiwood.lua")
dofile(modpath.."/tunnel_tube.lua")
dofile(modpath.."/spore_tree.lua")
dofile(modpath.."/black_cap.lua")
dofile(modpath.."/nether_cap.lua")
dofile(modpath.."/goblin_cap.lua")
dofile(modpath.."/tower_cap.lua")

dofile(modpath.."/torchspine.lua")
dofile(modpath.."/spindlestem.lua")

