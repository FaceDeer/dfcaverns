-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--------------------------------------------------
-- Cave moss

-- cyan/dark cyan

minetest.register_node("dfcaverns:cobble_cave_moss", {
	description = S("Cobblestone With Cave Moss"),
	tiles = {"default_cobble.png^dfcaverns_cave_moss.png", "default_cobble.png", "default_cobble.png^dfcaverns_cave_moss_side.png"},
	drop = "default:cobble",
	is_ground_content = false,
	groups = {cracky = 3, stone = 2, light_sensitive_fungus = 11},
	_dfcaverns_dead_node = "default:cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm{
	label = "dfcaverns:cave_moss_spread",
	nodenames = {"default:cobble"},
	neighbors = {"dfcaverns:cobble_cave_moss"},
	interval = 30,
	chance = 10,
	catch_up = true,
	action = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:cobble_cave_moss"})
	end,
}

--------------------------------------------------
-- floor fungus

-- white/yellow

minetest.register_node("dfcaverns:cobble_floor_fungus", {
	description = S("Cobblestone With Floor Fungus"),
	tiles = {"default_cobble.png^dfcaverns_floor_fungus.png", "default_cobble.png", "default_cobble.png^dfcaverns_floor_fungus_side.png"},
	drops = "default:cobble",
	is_ground_content = false,
	groups = {cracky = 3, stone = 2, light_sensitive_fungus = 11},
	_dfcaverns_dead_node = "default:cobble",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_abm{
	label = "dfcaverns:floor_fungus_spread",
	nodenames = {"default:cobble"},
	neighbors = {"dfcaverns:cobble_floor_fungus"},
	interval = 30,
	chance = 10,
	catch_up = true,
	action = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:cobble_floor_fungus"})
	end,
}

--------------------------------------------------
-- Generic decorations (not DF canon)

minetest.register_node("dfcaverns:cavern_fungi", {
	description = S("Cavern Fungi"),
	drawtype = "plantlike",
	tiles = {"dfcaverns_fungi.png"},
	inventory_image = "dfcaverns_fungi.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {flammable=4, oddly_breakable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
	},
})


