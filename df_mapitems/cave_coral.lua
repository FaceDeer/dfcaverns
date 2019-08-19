-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("df_mapitems:cave_coral_3", {
	description = S("Cave Coral"),
	_doc_items_longdesc = df_mapitems.doc.cave_coral_desc,
	_doc_items_usagehelp = df_mapitems.doc.cave_coral_usage,
	tiles = {"dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral.png"},
	drop = "default:coral_skeleton",
	light_source = 3,
	paramtype2 = "facedir",
	groups = {cracky = 3, dfcaverns_cave_coral = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("df_mapitems:cave_coral_2", {
	description = S("Cave Coral"),
	_doc_items_longdesc = df_mapitems.doc.cave_coral_desc,
	_doc_items_usagehelp = df_mapitems.doc.cave_coral_usage,
	tiles = {"dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral.png"},
	drop = "default:coral_skeleton",
	light_source = 2,
	paramtype2 = "facedir",
	groups = {cracky = 3, dfcaverns_cave_coral = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("df_mapitems:cave_coral_1", {
	description = S("Cave Coral"),
	_doc_items_longdesc = df_mapitems.doc.cave_coral_desc,
	_doc_items_usagehelp = df_mapitems.doc.cave_coral_usage,
	tiles = {"dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral.png"},
	drop = "default:coral_skeleton",
	light_source = 1,
	paramtype2 = "facedir",
	groups = {cracky = 3, dfcaverns_cave_coral = 1},
	sounds = default.node_sound_stone_defaults(),
})

local coral_names = {"df_mapitems:cave_coral_1", "df_mapitems:cave_coral_2", "df_mapitems:cave_coral_3"}
minetest.register_abm{
	label = "df_mapitems:shifting_coral",
	nodenames = {"group:dfcaverns_cave_coral"},
	neighbors = {"default:water_source"},
	interval = 2,
	chance = 10,
	action = function(pos)
		local node = minetest.get_node(pos)
		minetest.swap_node(pos, {name=coral_names[math.random(1,3)], param2=node.param2})
	end,
}
