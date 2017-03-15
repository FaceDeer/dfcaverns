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



local register_seed = function(name, description, image)
	minetest.register_node("dfcaverns:"..name, {
		description = description,
		tiles = {image},
		inventory_image = image,
		drawtype = "signlike",
		groups = {flammable=4, oddly_breakable_by_hand=1},
		paramtype = "light",
		paramtype2 = "wallmounted",
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
	})
end

--------------------------------------------------
-- Cave wheat

-- stalks. White

--farming.register_plant("dfcaverns:cave_wheat", {
--	description = "Cave wheat seed",
--	paramtype2 = "meshoptions",
--	inventory_image = "dfcaverns_cave_wheat_seed.png",
--	steps = 8,
--	minlight = 0,
--	maxlight = 8,
--	fertility = {"grassland", "desert"},
--	groups = {flammable = 4},
--	place_param2 = 3,
--})


local register_cave_wheat = function(number)
	minetest.register_node("dfcaverns:cave_wheat_"..tostring(number), {
		description = S("Cave Wheat"),
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 3,
		tiles = {"dfcaverns_cave_wheat_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_cave_wheat_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
	})
end

for i = 1,8 do
	register_cave_wheat(i)
end

register_seed("cave_wheat_seed", S("Cave Wheat Seed"), "dfcaverns_cave_wheat_seed.png")

minetest.register_craftitem("dfcaverns:cave_wheat", {
	description = S("Cave Wheat"),
	inventory_image = "dfcaverns_cave_wheat.png",
	stack_max = 99,
})

--------------------------------------------------
-- Dimple cup

-- royal blue

local register_dimple_cup = function(number)
	minetest.register_node("dfcaverns:dimple_cups_"..tostring(number), {
		description = S("Dimple Cups"),
		drawtype = "plantlike",
		tiles = {"dfcaverns_dimple_cups_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_dimple_cups_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
	})
end

for i = 1,4 do
	register_dimple_cup(i)
end

register_seed("dimple_cup_seed", S("Dimple Cup Spores"), "dfcaverns_dimple_cups_seed.png")


--------------------------------------------------
-- Pig tail

-- Twisting stalks. Gray

local register_pig_tail = function(number)
	minetest.register_node("dfcaverns:pig_tails_"..tostring(number), {
		description = S("Pig Tails"),
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 3,
		tiles = {"dfcaverns_pigtails_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_pigtails_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
	})
end

for i = 1,8 do
	register_pig_tail(i)
end

register_seed("pig_tail_seed", S("Pig Tail Spore"), "dfcaverns_pigtail_seed.png")

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
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
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
	description = S("Plump Helmet"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:5:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
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
	description = S("Plump Helmet"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:15:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
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
	description = S("Plump Helmet"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:35:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
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
	description = S("Plump Helmet"),
	tiles = {
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png",
		"dfcaverns_plump_helmet_cap.png^[lowpart:40:dfcaverns_plump_helmet_stem.png",
	},
	groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
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

local register_quarry_bush = function(number)
	minetest.register_node("dfcaverns:quarry_bush_"..tostring(number), {
		description = S("Quarry Bush"),
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 4,
		tiles = {"dfcaverns_quarry_bush_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_quarry_bush_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
	})
end

for i = 1,5 do
	register_quarry_bush(i)
end

register_seed("quarry_bush_seed", S("Rock Nuts"), "dfcaverns_rock_nuts.png")

minetest.register_craftitem("dfcaverns:quarry_bush_leaves", {
	description = S("Quarry Bush Leaves"),
	inventory_image = "dfcaverns_quarry_bush_leaves.png",
	stack_max = 99,
})


--------------------------------------------------
-- Sweet Pod

-- Round shape, red

local register_sweet_pod = function(number)
	minetest.register_node("dfcaverns:sweet_pods_"..tostring(number), {
		description = S("Sweet Pods"),
		drawtype = "plantlike",
		tiles = {"dfcaverns_sweet_pods_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_sweet_pods_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
	})
end

for i = 1,6 do
	register_sweet_pod(i)
end

register_seed("sweet_pod_seed", S("Sweet Pod Spores"), "dfcaverns_sweet_pod_seed.png")
