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
	groups = {flammable=4, oddly_breakable_by_hand=1, plant = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:dead_fungus",
	burntime = 2
})

local register_seed = function(name, description, image, stage_one)
	local def = {
		description = description,
		tiles = {image},
		inventory_image = image,
		drawtype = "signlike",
		paramtype2 = "wallmounted",
		groups = {flammable=4, oddly_breakable_by_hand=1},
		_dfcaverns_next_stage = stage_one,
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
	}
	
	minetest.register_node("dfcaverns:"..name, def)
	minetest.register_craft({
		type = "fuel",
		recipe = "dfcaverns:"..name,
		burntime = 1
	})
end

local register_grow_abm = function(names, interval, chance)
	minetest.register_abm({
		nodenames = names,
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			local node_def = minetest.registered_nodes[node.name]
			local next_stage = node_def._dfcaverns_next_stage
			if next_stage then
				local next_def = minetest.registered_nodes[next_stage]
				pos.y = pos.y+1
				minetest.swap_node(pos, {name=next_stage, param2 = next_def.place_param2 or node.param2})
			end
		end
	})
end
--------------------------------------------------
-- Cave wheat

-- stalks. White

local wheat_names = {}

local register_cave_wheat = function(number)
	local def = {
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
		drop = {
			max_items = 1,
			items = {
				{
					items = {'dfcaverns:cave_wheat_seed 2', 'dfcaverns:cave_wheat'},
					rarity = 9-number,
				},
				{
					items = {'dfcaverns:cave_wheat_seed 1', 'dfcaverns:cave_wheat'},
					rarity = 9-number,
				},
				{
					items = {'dfcaverns:cave_wheat_seed'},
					rarity = 9-number,
				},
			},
		},
	}
	
	if number < 8 then
		def._dfcaverns_next_stage = "dfcaverns:cave_wheat_"..tostring(number+1)
		table.insert(wheat_names, "dfcaverns:cave_wheat_"..tostring(number))
	end

	minetest.register_node("dfcaverns:cave_wheat_"..tostring(number), def)
end

for i = 1,8 do
	register_cave_wheat(i)
end

register_seed("cave_wheat_seed", S("Cave Wheat Seed"), "dfcaverns_cave_wheat_seed.png", "dfcaverns:cave_wheat_1")
table.insert(wheat_names, "dfcaverns:cave_wheat_seed")

register_grow_abm(wheat_names, 10, 1)

minetest.register_craftitem("dfcaverns:cave_wheat", {
	description = S("Cave Wheat"),
	inventory_image = "dfcaverns_cave_wheat.png",
	stack_max = 99,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:cave_wheat",
	burntime = 2
})

--------------------------------------------------
-- Dimple cup

-- royal blue

local dimple_names = {}

local register_dimple_cup = function(number)
	local def = {
		description = S("Dimple Cup"),
		drawtype = "plantlike",
		tiles = {"dfcaverns_dimple_cup_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_dimple_cup_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
	}
	
	if number < 4 then
		def._dfcaverns_next_stage = "dfcaverns:dimple_cup_"..tostring(number+1)
		table.insert(dimple_names, "dfcaverns:dimple_cup_"..tostring(number))
	end
	
	minetest.register_node("dfcaverns:dimple_cup_"..tostring(number), def)
end

for i = 1,4 do
	register_dimple_cup(i)
end

register_seed("dimple_cup_seed", S("Dimple Cup Spores"), "dfcaverns_dimple_cup_seed.png", "dfcaverns:dimple_cup_1")
table.insert(dimple_names, "dfcaverns:dimple_cup_seed")

register_grow_abm(dimple_names, 10, 1)

--------------------------------------------------
-- Pig tail

-- Twisting stalks. Gray

local pig_tail_names = {}

local register_pig_tail = function(number)
	local def = {
		description = S("Pig Tail"),
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 3,
		tiles = {"dfcaverns_pig_tail_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_pig_tail_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
	}
	
	if number < 8 then
		def._dfcaverns_next_stage = "dfcaverns:pig_tail_"..tostring(number+1)
		table.insert(pig_tail_names, "dfcaverns:pig_tail_"..tostring(number))
	end
	
	minetest.register_node("dfcaverns:pig_tail_"..tostring(number), def)
end

for i = 1,8 do
	register_pig_tail(i)
end

register_seed("pig_tail_seed", S("Pig Tail Spore"), "dfcaverns_pig_tail_seed.png", "dfcaverns:pig_tail_1")
table.insert(pig_tail_names, "dfcaverns:pig_tail_seed")

register_grow_abm(pig_tail_names, 10, 1)

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
	on_construct = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:plump_helmet_4", param2 = math.random(0,3)})
	end,
})

local plump_names = {"dfcaverns:plump_helmet_spawn", "dfcaverns:plump_helmet_1", "dfcaverns:plump_helmet_2", "dfcaverns:plump_helmet_3"}
register_grow_abm(plump_names, 10, 1)

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_spawn",
	burntime = 1
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_1",
	burntime = 2
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_2",
	burntime = 3
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_3",
	burntime = 4
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:plump_helmet_4",
	burntime = 5
})

--------------------------------------------------
-- Quarry Bush

-- Gray leaves
-- Produces rock nuts

local quarry_names = {}

local register_quarry_bush = function(number)
	local def = {
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
	}

	if number < 5 then
		def._dfcaverns_next_stage = "dfcaverns:quarry_bush_"..tostring(number+1)
		table.insert(quarry_names, "dfcaverns:quarry_bush_"..tostring(number))
	end

	minetest.register_node("dfcaverns:quarry_bush_"..tostring(number), def)
end

for i = 1,5 do
	register_quarry_bush(i)
end

register_seed("quarry_bush_seed", S("Rock Nuts"), "dfcaverns_rock_nuts.png", "dfcaverns:quarry_bush_1")
table.insert(quarry_names, "dfcaverns:quarry_bush_seed")

register_grow_abm(quarry_names, 10, 1)

minetest.register_craftitem("dfcaverns:quarry_bush_leaves", {
	description = S("Quarry Bush Leaves"),
	inventory_image = "dfcaverns_quarry_bush_leaves.png",
	stack_max = 99,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:quarry_bush_leaves",
	burntime = 4
})


--------------------------------------------------
-- Sweet Pod

-- Round shape, red

local sweet_names = {}

local register_sweet_pod = function(number)
	local def = {
		description = S("Sweet Pod"),
		drawtype = "plantlike",
		tiles = {"dfcaverns_sweet_pod_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_sweet_pod_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
	}
	
	if number < 6 then
		def._dfcaverns_next_stage = "dfcaverns:sweet_pod_"..tostring(number+1)
		table.insert(sweet_names, "dfcaverns:sweet_pod_"..tostring(number))
	end
	
	minetest.register_node("dfcaverns:sweet_pod_"..tostring(number), def)
end

for i = 1,6 do
	register_sweet_pod(i)
end

register_seed("sweet_pod_seed", S("Sweet Pod Spores"), "dfcaverns_sweet_pod_seed.png", "dfcaverns:sweet_pod_1")
table.insert(sweet_names, "dfcaverns:sweet_pod_seed")

register_grow_abm(sweet_names, 10, 1)
