-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-----------------------------------------------------------------------
-- Plants


minetest.register_node("dfcaverns:dead_fungus", {
	description = S("Dead Fungus"),
	drawtype = "plantlike",
	tiles = {"dfcaverns_dead_fungus.png"},
	inventory_image = "dfcaverns_dead_fungus.png",
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


--------------------------------------------------
-- Cave wheat

-- stalks. White

farming.register_plant("dfcaverns:cave_wheat", {
	description = "Cave wheat seed",
	paramtype2 = "meshoptions",
	inventory_image = "dfcaverns_cave_wheat_seed.png",
	steps = 8,
	minlight = 0,
	maxlight = 8,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
	place_param2 = 3,
})

--------------------------------------------------
-- Dimple cup

-- royal blue

--------------------------------------------------
-- Pig tail

-- Twisting stalks. Gray

--------------------------------------------------
-- Plump helmet

-- Purple, rounded tops


local displace_x = 0.125
local displace_z = 0.125

minetest.register_node("dfcaverns:plump_helmet_spawn", {
	description = S("Plump Helmet Spawn"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625 + displace_x, -0.5, -0.125 + displace_z, 0.125 + displace_x, -0.375, 0.0625 + displace_z},
		}
	}
})


minetest.register_node("dfcaverns:plump_helmet_1", {
	description = S("Plump Helmet 1"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:5:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625 + displace_x, -0.5, -0.125 + displace_z, 0.125 + displace_x, -0.25, 0.0625 + displace_z},      -- stalk
			{-0.125 + displace_x, -0.4375, -0.1875 + displace_z, 0.1875 + displace_x, -0.3125, 0.125 + displace_z}, -- cap
		}
	}
})


minetest.register_node("dfcaverns:plump_helmet_2", {
	description = S("Plump Helmet 2"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:15:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625 + displace_x, -0.5, -0.125 + displace_z, 0.125 + displace_x, 0, 0.0625 + displace_z},  -- stalk
			{-0.125 + displace_x, -0.3125, -0.1875 + displace_z, 0.1875 + displace_x, -0.0625, 0.125 + displace_z},  -- cap
		}
	}
})

minetest.register_node("dfcaverns:plump_helmet_3", {
	description = S("Plump Helmet 3"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:35:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125 + displace_x, -0.5, -0.1875 + displace_z, 0.1875 + displace_x, 0.25, 0.125 + displace_z}, -- stalk
			{-0.1875 + displace_x, -0.125, -0.25 + displace_z, 0.25 + displace_x, 0.1875, 0.1875 + displace_z}, -- cap
		}
	}
})

minetest.register_node("dfcaverns:plump_helmet_4", {
	description = S("Plump Helmet 4"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:40:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125 + displace_x, -0.5, -0.1875 + displace_z, 0.1875 + displace_x, 0.375, 0.125 + displace_z}, -- stalk
			{-0.25 + displace_x, -0.0625, -0.3125 + displace_z, 0.3125 + displace_x, 0.25, 0.25 + displace_z}, -- cap
			{-0.1875 + displace_x, 0.25, -0.25 + displace_z, 0.25 + displace_x, 0.3125, 0.1875 + displace_z}, -- cap rounding
		}
	}
})





--------------------------------------------------
-- Quarry Bush

-- Gray leaves
-- Produces rock nuts

--------------------------------------------------
-- Sweet Pod

-- Round shape, red
