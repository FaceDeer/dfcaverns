dfcaverns = {}

subterrane.get_param2_data = true

minetest.register_alias_force("mapgen_lava_source", "air")

--grab a shorthand for the filepath of the mod
local modpath = minetest.get_modpath(minetest.get_current_modname())

--load companion lua files
dofile(modpath.."/config.lua")

dofile(modpath.."/ground_cover.lua")
dofile(modpath.."/plants.lua")

-- Trees
dofile(modpath.."/blood_thorn.lua")
dofile(modpath.."/fungiwood.lua")
dofile(modpath.."/tunnel_tube.lua")
dofile(modpath.."/spore_tree.lua")
dofile(modpath.."/black_cap.lua")
dofile(modpath.."/nether_cap.lua")
dofile(modpath.."/goblin_cap.lua")
dofile(modpath.."/tower_cap.lua")


minetest.register_abm({
	label = "dfcaverns:kill_light_sensitive_fungus",
	nodenames = {"group:light_sensitive_fungus"},
	catch_up = true,
	interval = 30,
	chance = 5,
	action = function(pos, node)
		local node_def = minetest.registered_nodes[node.name]
		local dead_node = node_def._dfcaverns_dead_node or "dfcaverns:dead_fungus"
		-- 11 is the value adjacent to a torch		
		if minetest.get_node_light(pos) > node_def.groups.light_sensitive_fungus then
			minetest.set_node(pos, {name=dead_node, param2 = node.param2})
		end
	end
})

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
