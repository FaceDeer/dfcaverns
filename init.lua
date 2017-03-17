dfcaverns = {}

subterrane.get_param2_data = true

minetest.register_alias_force("mapgen_lava_source", "air")

--grab a shorthand for the filepath of the mod
local modpath = minetest.get_modpath(minetest.get_current_modname())

--load companion lua files
dofile(modpath.."/config.lua")

dofile(modpath.."/ground_cover.lua")
dofile(modpath.."/glow_worms.lua")

-- Plants
dofile(modpath.."/plants.lua") -- general functions
dofile(modpath.."/plants/cave_wheat.lua")
dofile(modpath.."/plants/dimple_cup.lua")
dofile(modpath.."/plants/pig_tail.lua")
dofile(modpath.."/plants/plump_helmet.lua")
dofile(modpath.."/plants/quarry_bush.lua")
dofile(modpath.."/plants/sweet_pod.lua")

-- Trees
dofile(modpath.."/trees/blood_thorn.lua")
dofile(modpath.."/trees/fungiwood.lua")
dofile(modpath.."/trees/tunnel_tube.lua")
dofile(modpath.."/trees/spore_tree.lua")
dofile(modpath.."/trees/black_cap.lua")
dofile(modpath.."/trees/nether_cap.lua")
dofile(modpath.."/trees/goblin_cap.lua")
dofile(modpath.."/trees/tower_cap.lua")

dofile(modpath.."/biomes.lua")

minetest.register_ore({
	ore_type = "vein",
	ore = "default:lava_source",
	wherein = {
		"default:stone",
		"default:desert_stone",
		"default:sandstone",
		"default:sand",
		"default:desert_sand",
		"default:silver_sand",
		"default:gravel",
		"default:stone_with_coal",
		"default:stone_with_iron",
		"default:stone_with_copper",
		"default:stone_with_gold",
		"default:stone_with_diamond",
		"default:dirt",
		"default:dirt_with_grass",
		"default:dirt_with_dry_grass",
		"default:dirt_with_snow",
		"default:cobble",
		"default:mossycobble",
	},
	column_height_min = 2,
	column_height_max = 6,
	height_min = -31000,
	height_max = 31000,
	noise_threshold = 0.9,
	noise_params = {
		offset = 0,
		scale = 3,
		spread = {x=400, y=800, z=400},
		seed = 25391,
		octaves = 4,
		persist = 0.5,
		flags = "eased",
	},
	random_factor = 0,
})
