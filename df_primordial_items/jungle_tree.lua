-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Leaves
minetest.register_node("df_primordial_items:jungle_leaves", {
	description = S("Primordial Jungle Tree Leaves"),
	_doc_items_longdesc = df_primordial_items.doc.leaves_desc,
	_doc_items_usagehelp = df_primordial_items.doc.leaves_usage,
	drawtype = "plantlike",
	walkable = false,
	waving = 2,
	tiles = {"dfcaverns_jungle_leaves_01.png"},
	inventory_image = "dfcaverns_jungle_leaves_01.png",
	wield_image = "dfcaverns_jungle_leaves_01.png",
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

minetest.register_node("df_primordial_items:jungle_leaves_glowing", {
	description = S("Phosphorescent Primordial Jungle Tree Leaves"),
	_doc_items_longdesc = df_primordial_items.doc.glowing_leaves_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glowing_leaves_usage,
	drawtype = "plantlike",
	walkable = false,
	waving = 2,
	tiles = {"dfcaverns_jungle_leaves_02.png"},
	inventory_image = "dfcaverns_jungle_leaves_02.png",
	wield_image = "dfcaverns_jungle_leaves_02.png",
	paramtype = "light",
	is_ground_content = false,
	light_source = 4,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

-- Trunk

minetest.register_node("df_primordial_items:jungle_tree", {
	description = S("Primordial Jungle Tree"),
	_doc_items_longdesc = df_primordial_items.doc.tree_desc,
	_doc_items_usagehelp = df_primordial_items.doc.tree_usage,
	tiles = {"dfcaverns_jungle_wood_02.png", "dfcaverns_jungle_wood_02.png", "dfcaverns_jungle_wood_01.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("df_primordial_items:jungle_tree_mossy", {
	description = S("Mossy Primordial Jungle Tree"),
	_doc_items_longdesc = df_primordial_items.doc.tree_desc,
	_doc_items_usagehelp = df_primordial_items.doc.tree_usage,
	tiles = {"dfcaverns_jungle_wood_02.png", "dfcaverns_jungle_wood_02.png", "dfcaverns_jungle_wood_03.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("df_primordial_items:jungle_tree_glowing", {
	description = S("Phosphorescent Primordial Jungle Tree"),
	_doc_items_longdesc = df_primordial_items.doc.tree_glowing_desc,
	_doc_items_usagehelp = df_primordial_items.doc.tree_glowing_usage,
	tiles = {"dfcaverns_jungle_wood_02.png", "dfcaverns_jungle_wood_02.png", "dfcaverns_jungle_wood_04.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	light_source = 4,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})
