-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local displace_x = 0.125
local displace_z = 0.125

minetest.register_node("dfcaverns:plump_helmet_spawn", {
	description = S("Plump Helmet Spawn"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11, plant = 1},
	_dfcaverns_next_stage = "dfcaverns:plump_helmet_1",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625 + displace_x, -0.5, -0.125 + displace_z, 0.125 + displace_x, -0.375, 0.0625 + displace_z},
		}
	},
	on_construct = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:plump_helmet_spawn", param2 = math.random(0,3)})
	end,
})

minetest.register_node("dfcaverns:plump_helmet_1", {
	description = S("Plump Helmet"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:5:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11, plant = 1},
	_dfcaverns_next_stage = "dfcaverns:plump_helmet_2",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625 + displace_x, -0.5, -0.125 + displace_z, 0.125 + displace_x, -0.25, 0.0625 + displace_z},      -- stalk
			{-0.125 + displace_x, -0.4375, -0.1875 + displace_z, 0.1875 + displace_x, -0.3125, 0.125 + displace_z}, -- cap
		}
	},

	on_construct = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:plump_helmet_1", param2 = math.random(0,3)})
	end,
})


minetest.register_node("dfcaverns:plump_helmet_2", {
	description = S("Plump Helmet"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:15:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11, plant = 1},
	_dfcaverns_next_stage = "dfcaverns:plump_helmet_3",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625 + displace_x, -0.5, -0.125 + displace_z, 0.125 + displace_x, 0, 0.0625 + displace_z},  -- stalk
			{-0.125 + displace_x, -0.3125, -0.1875 + displace_z, 0.1875 + displace_x, -0.0625, 0.125 + displace_z},  -- cap
		}
	},

	drop = {
		max_items = 2,
		items = {
			{
				items = {'dfcaverns:plump_helmet_2'},
				rarity = 1,
			},
			{
				items = {'dfcaverns:plump_helmet_spawn'},
				rarity = 4,
			},
		},
	},

	on_construct = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:plump_helmet_2", param2 = math.random(0,3)})
	end,
})

minetest.register_node("dfcaverns:plump_helmet_3", {
	description = S("Plump Helmet"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:35:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11, plant = 1},
	_dfcaverns_next_stage = "dfcaverns:plump_helmet_4",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125 + displace_x, -0.5, -0.1875 + displace_z, 0.1875 + displace_x, 0.25, 0.125 + displace_z}, -- stalk
			{-0.1875 + displace_x, -0.125, -0.25 + displace_z, 0.25 + displace_x, 0.1875, 0.1875 + displace_z}, -- cap
		}
	},
	
	drop = {
		max_items = 2,
		items = {
			{
				items = {'dfcaverns:plump_helmet_3'},
				rarity = 1,
			},
			{
				items = {'dfcaverns:plump_helmet_spawn'},
				rarity = 2,
			},
		},
	},
	
	on_construct = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:plump_helmet_3", param2 = math.random(0,3)})
	end,
})

minetest.register_node("dfcaverns:plump_helmet_4", {
	description = S("Plump Helmet"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:40:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11, plant = 1},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125 + displace_x, -0.5, -0.1875 + displace_z, 0.1875 + displace_x, 0.375, 0.125 + displace_z}, -- stalk
			{-0.25 + displace_x, -0.0625, -0.3125 + displace_z, 0.3125 + displace_x, 0.25, 0.25 + displace_z}, -- cap
			{-0.1875 + displace_x, 0.25, -0.25 + displace_z, 0.25 + displace_x, 0.3125, 0.1875 + displace_z}, -- cap rounding
		}
	},

		drop = {
		max_items = 4,
		items = {
			{
				items = {'dfcaverns:plump_helmet_4'},
				rarity = 1,
			},
			{
				items = {'dfcaverns:plump_helmet_spawn'},
				rarity = 1,
			},
			{
				items = {'dfcaverns:plump_helmet_spawn'},
				rarity = 2,
			},
			{
				items = {'dfcaverns:plump_helmet_spawn'},
				rarity = 2,
			},
		},
	},

	on_construct = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:plump_helmet_4", param2 = math.random(0,3)})
	end,
})

local plump_names = {"dfcaverns:plump_helmet_spawn", "dfcaverns:plump_helmet_1", "dfcaverns:plump_helmet_2", "dfcaverns:plump_helmet_3"}
dfcaverns.register_grow_abm(plump_names, 10, 1)

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_spawn",
	burntime = 1
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_1",
	burntime = 1
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_2",
	burntime = 2
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_3",
	burntime = 3
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_4",
	burntime = 4
})
