-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--------------------------------------------------
-- Cave moss

-- cyan/dark cyan

minetest.register_node("dfcaverns:dirt_with_cave_moss", {
	description = S("Dirt With Cave Moss"),
	tiles = {"default_dirt.png^dfcaverns_cave_moss.png", "default_dirt.png", 
		{name = "default_dirt.png^dfcaverns_cave_moss_side.png",
			tileable_vertical = false}},
	drop = "default:dirt",
	is_ground_content = false,
	groups = {crumbly = 3, soil = 1, light_sensitive_fungus = 11},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
	soil = {
		base = "dfcaverns:dirt_with_cave_moss",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	_dfcaverns_dead_node = "default:dirt",
})

minetest.register_abm{
	label = "dfcaverns:cave_moss_spread",
	nodenames = {"default:dirt"},
	neighbors = {"dfcaverns:dirt_with_cave_moss"},
	interval = 30,
	chance = 10,
	catch_up = true,
	action = function(pos)
		local above_def = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name]
		if above_def.buildable_to == true or above_def.walkable == false then
			minetest.swap_node(pos, {name="dfcaverns:dirt_with_cave_moss"})
		end
	end,
}

--------------------------------------------------
-- floor fungus

-- white/yellow

minetest.register_node("dfcaverns:cobble_with_floor_fungus", {
	description = S("Cobblestone With Floor Fungus"),
	tiles = {"default_cobble.png^dfcaverns_floor_fungus.png", "default_cobble.png", "default_cobble.png^dfcaverns_floor_fungus_side.png"},
	drops = "default:cobble",
	is_ground_content = false,
	groups = {cracky = 3, stone = 2, light_sensitive_fungus = 11},
	_dfcaverns_dead_node = "default:cobble",
	sounds = default.node_sound_stone_defaults({
		footstep = {name = "dfcaverns_squish", gain = 0.25},
	}),
})

minetest.register_abm{
	label = "dfcaverns:floor_fungus_spread",
	nodenames = {"default:cobble"},
	neighbors = {"dfcaverns:cobble_with_floor_fungus"},
	interval = 30,
	chance = 10,
	catch_up = true,
	action = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:cobble_with_floor_fungus"})
	end,
}


