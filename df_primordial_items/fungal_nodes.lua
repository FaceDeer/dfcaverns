-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-----------------------------------------------------------------------------------------------
-- Plants

-- Grass

minetest.register_node("df_primordial_items:fungal_grass_1", {
	description = S("Primordial Fungal Grass"),
	_doc_items_longdesc = df_primordial_items.doc.fungal_grass_desc,
	_doc_items_usagehelp = df_primordial_items.doc.fungal_grass_usage,
	tiles = {"dfcaverns_mush_grass_01.png"},
	inventory_image = "dfcaverns_mush_grass_01.png",
	wield_image = "dfcaverns_mush_grass_01.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

minetest.register_node("df_primordial_items:fungal_grass_2", {
	description = S("Primordial Jungle Grass"),
	_doc_items_longdesc = df_primordial_items.doc.fungal_grass_desc,
	_doc_items_usagehelp = df_primordial_items.doc.fungal_grass_usage,
	tiles = {"dfcaverns_mush_grass_02.png"},
	inventory_image = "dfcaverns_mush_grass_02.png",
	wield_image = "dfcaverns_mush_grass_02.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	place_param2 = 3,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

-- Glowing

minetest.register_node("df_primordial_items:glow_orb", {
	description = S("Primordial Fungal Orb"),
	_doc_items_longdesc = df_primordial_items.doc.glow_orb_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glow_orb_usage,
	tiles = {"dfcaverns_mush_orb.png"},
	inventory_image = "dfcaverns_mush_orb.png",
	wield_image = "dfcaverns_mush_orb.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	light_source = 9,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

minetest.register_node("df_primordial_items:glow_orb_stalks", {
	description = S("Primordial Fungal Orb"),
	_doc_items_longdesc = df_primordial_items.doc.glow_orb_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glow_orb_usage,
	tiles = {"dfcaverns_mush_stalks.png"},
	inventory_image = "dfcaverns_mush_stalks.png",
	wield_image = "dfcaverns_mush_stalks.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	light_source = 6,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

minetest.register_node("df_primordial_items:glow_pods", {
	description = S("Primordial Fungal Pod"),
	_doc_items_longdesc = df_primordial_items.doc.glow_pod_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glow_pod_usage,
	tiles = {"dfcaverns_mush_pods.png"},
	inventory_image = "dfcaverns_mush_pods.png",
	wield_image = "dfcaverns_mush_pods.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	light_source = 6,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

------------------------------------------------------------------------------------
-- Dirt

minetest.register_node("df_primordial_items:dirt_with_mycelium", {
	description = S("Dirt With Primordial Mycelium"),
	tiles = {"dfcaverns_mush_soil.png"},
	groups = {crumbly = 3, soil = 1},
	drops = "default:dirt",
	sounds = default.node_sound_dirt_defaults(),
	light_source = 3,
})
