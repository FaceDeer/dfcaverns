-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--------------------------------------------------
-- Cave moss

-- cyan/dark cyan

minetest.register_node("dfcaverns:dirt_with_cave_moss", {
	description = S("Dirt With Cave Moss"),
	_doc_items_longdesc = dfcaverns.doc.cave_moss_desc,
	_doc_items_usagehelp = dfcaverns.doc.cave_moss_usage,
	tiles = {"default_dirt.png^dfcaverns_cave_moss.png", "default_dirt.png", 
		{name = "default_dirt.png^dfcaverns_cave_moss_side.png",
			tileable_vertical = false}},
	drop = "default:dirt",
	is_ground_content = true,
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
	interval = 60,
	chance = 15,
	catch_up = true,
	action = function(pos)
		local above_def = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name]
		if above_def and (above_def.buildable_to == true or above_def.walkable == false) then
			minetest.swap_node(pos, {name="dfcaverns:dirt_with_cave_moss"})
		end
	end,
}

--------------------------------------------------
-- floor fungus

-- white/yellow

minetest.register_node("dfcaverns:cobble_with_floor_fungus", {
	description = S("Cobblestone With Floor Fungus"),
	_doc_items_longdesc = dfcaverns.doc.floor_fungus_desc,
	_doc_items_usagehelp = dfcaverns.doc.floor_fungus_usage,
	tiles = {"default_cobble.png^dfcaverns_floor_fungus.png", "default_cobble.png", "default_cobble.png^dfcaverns_floor_fungus_side.png"},
	drops = "default:cobble",
	is_ground_content = true,
	groups = {cracky = 3, stone = 2, slippery = 1, light_sensitive_fungus = 11},
	_dfcaverns_dead_node = "default:cobble",
	sounds = default.node_sound_stone_defaults({
		footstep = {name = "dfcaverns_squish", gain = 0.25},
	}),
})

minetest.register_abm{
	label = "dfcaverns:floor_fungus_spread",
	nodenames = {"default:cobble"},
	neighbors = {"dfcaverns:cobble_with_floor_fungus"},
	interval = 60,
	chance = 30,
	catch_up = true,
	action = function(pos)
		minetest.swap_node(pos, {name="dfcaverns:cobble_with_floor_fungus"})
	end,
}


