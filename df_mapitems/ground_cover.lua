-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--------------------------------------------------
-- Cave moss

-- cyan/dark cyan

minetest.register_node("df_mapitems:dirt_with_cave_moss", {
	description = S("Dirt With Cave Moss"),
	_doc_items_longdesc = df_mapitems.doc.cave_moss_desc,
	_doc_items_usagehelp = df_mapitems.doc.cave_moss_usage,
	tiles = {"default_dirt.png^dfcaverns_cave_moss.png", "default_dirt.png", 
		{name = "default_dirt.png^dfcaverns_cave_moss_side.png",
			tileable_vertical = false}},
	drop = "default:dirt",
	is_ground_content = true,
	light_source = 2,
	groups = {crumbly = 3, soil = 1, light_sensitive_fungus = 8},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
	soil = {
		base = "df_mapitems:dirt_with_cave_moss",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	_dfcaverns_dead_node = "default:dirt",
})

minetest.register_abm{
	label = "df_mapitems:cave_moss_spread",
	nodenames = {"default:dirt"},
	neighbors = {"df_mapitems:dirt_with_cave_moss"},
	interval = 60,
	chance = 15,
	catch_up = true,
	action = function(pos)
		local above_def = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name]
		if above_def and (above_def.buildable_to == true or above_def.walkable == false) then
			minetest.swap_node(pos, {name="df_mapitems:dirt_with_cave_moss"})
		end
	end,
}

--------------------------------------------------
-- floor fungus

-- white/yellow

minetest.register_node("df_mapitems:cobble_with_floor_fungus", {
	description = S("Cobblestone With Floor Fungus"),
	_doc_items_longdesc = df_mapitems.doc.floor_fungus_desc,
	_doc_items_usagehelp = df_mapitems.doc.floor_fungus_usage,
	tiles = {"default_cobble.png^dfcaverns_floor_fungus.png"},
	drops = "default:cobble",
	is_ground_content = true,
	groups = {cracky = 3, stone = 2, slippery = 1, light_sensitive_fungus = 8},
	_dfcaverns_dead_node = "default:cobble",
	sounds = default.node_sound_stone_defaults({
		footstep = {name = "dfcaverns_squish", gain = 0.25},
	}),
})

minetest.register_node("df_mapitems:cobble_with_floor_fungus_fine", {
	description = S("Cobblestone With Floor Fungus"),
	_doc_items_longdesc = df_mapitems.doc.floor_fungus_desc,
	_doc_items_usagehelp = df_mapitems.doc.floor_fungus_usage,
	tiles = {"default_cobble.png^dfcaverns_floor_fungus_fine.png"},
	drops = "default:cobble",
	is_ground_content = true,
	groups = {cracky = 3, stone = 2, slippery = 1, light_sensitive_fungus = 8},
	_dfcaverns_dead_node = "default:cobble",
	sounds = default.node_sound_stone_defaults({
		footstep = {name = "dfcaverns_squish", gain = 0.25},
	}),
})

minetest.register_abm{
	label = "df_mapitems:floor_fungus_spread",
	nodenames = {"default:cobble"},
	neighbors = {"df_mapitems:cobble_with_floor_fungus"},
	interval = 60,
	chance = 5,
	catch_up = true,
	action = function(pos)
		minetest.swap_node(pos, {name="df_mapitems:cobble_with_floor_fungus_fine"})
	end,
}
minetest.register_abm{
	label = "df_mapitems:floor_fungus_thickening",
	nodenames = {"default:cobble_with_floor_fungus_fine"},
	interval = 59,
	chance = 30,
	catch_up = true,
	action = function(pos)
		minetest.swap_node(pos, {name="df_mapitems:cobble_with_floor_fungus"})
	end,
}

------------------------------------------------------
-- Hoar moss

minetest.register_node("df_mapitems:ice_with_hoar_moss", {
	description = S("Ice With Hoar Moss"),
	_doc_items_longdesc = df_mapitems.doc.hoar_moss_desc,
	_doc_items_usagehelp = df_mapitems.doc.hoar_moss_usage,
	tiles = {"default_ice.png^dfcaverns_hoar_moss.png"},
	drops = "default:ice",
	paramtype = "light",
	light_source = 2,
	groups = {cracky = 3, puts_out_fire = 1, cools_lava = 1, slippery = 2, light_sensitive_fungus = 8},
	sounds = default.node_sound_glass_defaults(),
	_dfcaverns_dead_node = "default:ice",
})