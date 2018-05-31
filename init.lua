dfcaverns = {}

--grab a shorthand for the filepath of the mod
local modpath = minetest.get_modpath(minetest.get_current_modname())

--load companion lua files
dofile(modpath.."/config.lua")
dofile(modpath.."/doc.lua")
dofile(modpath.."/voxelarea_iterator.lua")

dofile(modpath.."/features/ground_cover.lua")
dofile(modpath.."/features/glow_worms.lua")
dofile(modpath.."/features/flowstone_nodes.lua")
dofile(modpath.."/features/glow_crystals.lua")
dofile(modpath.."/features/snareweed.lua")
dofile(modpath.."/features/cave_coral.lua")

-- Farmable Plants
dofile(modpath.."/plants.lua") -- general functions
dofile(modpath.."/plants/cave_wheat.lua")
dofile(modpath.."/plants/dimple_cup.lua")
dofile(modpath.."/plants/pig_tail.lua")
dofile(modpath.."/plants/plump_helmet.lua")
dofile(modpath.."/plants/quarry_bush.lua")
dofile(modpath.."/plants/sweet_pod.lua")
dofile(modpath.."/plants/cooking.lua")

-- Trees
dofile(modpath.."/trees/blood_thorn.lua")
dofile(modpath.."/trees/fungiwood.lua")
dofile(modpath.."/trees/tunnel_tube.lua")
dofile(modpath.."/trees/spore_tree.lua")
dofile(modpath.."/trees/black_cap.lua")
dofile(modpath.."/trees/nether_cap.lua")
dofile(modpath.."/trees/goblin_cap.lua")
dofile(modpath.."/trees/tower_cap.lua")

-- Biomes
dofile(modpath.."/biomes.lua")
dofile(modpath.."/biomes/level1.lua")
dofile(modpath.."/biomes/level2.lua")
dofile(modpath.."/biomes/level3.lua")
dofile(modpath.."/biomes/sunless_sea.lua")
dofile(modpath.."/biomes/lava_sea.lua")
