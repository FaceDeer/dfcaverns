-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")


-------------------------------------------------------------------------
-- Giant mushroom

minetest.register_node("df_primordial_items:mushroom_trunk", {
	description = S("Primordial Mushroom Trunk"),
	_doc_items_longdesc = df_primordial_items.doc.big_mushroom_desc,
	_doc_items_usagehelp = df_primordial_items.doc.big_mushroom_usage,
	tiles = {"dfcaverns_mush_shaft_top.png", "dfcaverns_mush_shaft_top.png", "dfcaverns_mush_shaft_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("df_primordial_items:mushroom_cap", {
	description = S("Primordial Mushroom Cap"),
	_doc_items_longdesc = df_primordial_items.doc.giant_mushroom_desc,
	_doc_items_usagehelp = df_primordial_items.doc.giant_mushroom_usage,
	tiles = {"dfcaverns_mush_cap.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("df_primordial_items:mushroom_gills", {
	description = S("Primordial Mushroom Gills"),
	_doc_items_longdesc = df_primordial_items.doc.gills_desc,
	_doc_items_usagehelp = df_primordial_items.doc.gills_usage,
	tiles = {"dfcaverns_mush_gills.png"},
	inventory_image = "dfcaverns_mush_gills.png",
	wield_image = "dfcaverns_mush_gills.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

minetest.register_node("df_primordial_items:mushroom_gills_glowing", {
	description = S("Glowing Primordial Mushroom Gills"),
	_doc_items_longdesc = df_primordial_items.doc.gills_desc,
	_doc_items_usagehelp = df_primordial_items.doc.gills_usage,
	tiles = {"dfcaverns_mush_gills_glow.png"},
	inventory_image = "dfcaverns_mush_gills_glow.png",
	wield_image = "dfcaverns_mush_gills_glow.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	light_source = 6,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

---------------------------------------------------------------------------------------
-- Glownode and stalk

minetest.register_node("df_primordial_items:glownode", {
	description = S("Primordial Fungal Lantern"),
	_doc_items_longdesc = df_primordial_items.doc.glownode_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glownode_usage,
	drawtype = "glasslike",
	tiles = {"dfcaverns_mush_glownode.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})

minetest.register_node("df_primordial_items:glownode_stalk", {
	description = S("Primordial Fungal Lantern Stalk"),
	_doc_items_longdesc = df_primordial_items.doc.glownode_stalk_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glownode_stalk_usage,
	tiles = {"dfcaverns_mush_stalk_top.png", "dfcaverns_mush_stalk_top.png", "dfcaverns_mush_stalk_side.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

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
	walkable = false,
	light_source = 9,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

minetest.register_node("df_primordial_items:glow_orb_hanging", {
	description = S("Primordial Fungal Orb"),
	_doc_items_longdesc = df_primordial_items.doc.glow_orb_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glow_orb_usage,
	tiles = {"dfcaverns_mush_orb_vert.png"},
	inventory_image = "dfcaverns_mush_orb_vert.png",
	wield_image = "dfcaverns_mush_orb_vert.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	light_source = 6,
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
	walkable = false,
	light_source = 6,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

------------------------------------------------------------------------------------
-- Dirt

minetest.register_node("df_primordial_items:dirt_with_jungle_grass", {
	description = S("Dirt With Primordial Mycelium"),
	tiles = {"dfcaverns_mush_soil.png"},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drops = "default:dirt",
	sounds = default.node_sound_dirt_defaults(),
	light_source = 3,
})
