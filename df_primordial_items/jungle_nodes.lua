-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

----------------------------------------------------
-- Ferns

minetest.register_node("df_primordial_items:fern_1", {
	description = S("Primordial Fern"),
	_doc_items_longdesc = df_primordial_items.doc.fern_desc,
	_doc_items_usagehelp = df_primordial_items.doc.fern_usage,
	tiles = {"dfcaverns_jungle_fern_01.png"},
	inventory_image = "dfcaverns_jungle_fern_01.png",
	wield_image = "dfcaverns_jungle_fern_01.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	visual_scale = 1.69,
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

minetest.register_node("df_primordial_items:fern_2", {
	description = S("Primordial Fern"),
	_doc_items_longdesc = df_primordial_items.doc.fern_desc,
	_doc_items_usagehelp = df_primordial_items.doc.fern_usage,
	tiles = {"dfcaverns_jungle_fern_02.png"},
	visual_scale = 1.69,
	inventory_image = "dfcaverns_jungle_fern_02.png",
	wield_image = "dfcaverns_jungle_fern_02.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

---------------------------------------------------------
-- Glowing plants

minetest.register_node("df_primordial_items:glow_plant_1", {
	description = S("Primordial Flower"),
	_doc_items_longdesc = df_primordial_items.doc.glow_plant_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glow_plant_usage,
	tiles = {"dfcaverns_jungle_flower_01.png"},
	inventory_image = "dfcaverns_jungle_flower_01.png",
	wield_image = "dfcaverns_jungle_flower_01.png",
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

minetest.register_node("df_primordial_items:glow_plant_2", {
	description = S("Primordial Jungle Pod"),
	_doc_items_longdesc = df_primordial_items.doc.glow_plant_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glow_plant_usage,
	tiles = {"dfcaverns_jungle_glow_plant_01.png"},
	inventory_image = "dfcaverns_jungle_glow_plant_01.png",
	wield_image = "dfcaverns_jungle_glow_plant_01.png",
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

minetest.register_node("df_primordial_items:glow_plant_3", {
	description = S("Primordial Jungle Pod"),
	_doc_items_longdesc = df_primordial_items.doc.glow_plant_desc,
	_doc_items_usagehelp = df_primordial_items.doc.glow_plant_usage,
	tiles = {"dfcaverns_jungle_glow_plant_02.png"},
	inventory_image = "dfcaverns_jungle_glow_plant_02.png",
	wield_image = "dfcaverns_jungle_glow_plant_02.png",
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


-------------------------------------------------------------------
-- Grass

minetest.register_node("df_primordial_items:jungle_grass_1", {
	description = S("Primordial Jungle Grass"),
	_doc_items_longdesc = df_primordial_items.doc.grass_desc,
	_doc_items_usagehelp = df_primordial_items.doc.grass_usage,
	tiles = {"dfcaverns_jungle_grass_01.png"},
	inventory_image = "dfcaverns_jungle_grass_01.png",
	wield_image = "dfcaverns_jungle_grass_01.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

minetest.register_node("df_primordial_items:jungle_grass_2", {
	description = S("Primordial Jungle Grass"),
	_doc_items_longdesc = df_primordial_items.doc.grass_desc,
	_doc_items_usagehelp = df_primordial_items.doc.grass_usage,
	tiles = {"dfcaverns_jungle_grass_02.png"},
	inventory_image = "dfcaverns_jungle_grass_02.png",
	wield_image = "dfcaverns_jungle_grass_02.png",
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

minetest.register_node("df_primordial_items:jungle_grass_3", {
	description = S("Primordial Jungle Grass"),
	_doc_items_longdesc = df_primordial_items.doc.grass_desc,
	_doc_items_usagehelp = df_primordial_items.doc.grass_usage,
	tiles = {"dfcaverns_jungle_grass_03.png"},
	inventory_image = "dfcaverns_jungle_grass_03.png",
	wield_image = "dfcaverns_jungle_grass_03.png",
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


-----------------------------------------------------------------------------------------
-- Ivy

minetest.register_node("df_primordial_items:jungle_ivy", {
	description = S("Primordial Jungle Ivy"),
	_doc_items_longdesc = df_primordial_items.doc.ivy_desc,
	_doc_items_usagehelp = df_primordial_items.doc.ivy_usage,
	tiles = {"dfcaverns_jungle_ivy_01.png"},
	inventory_image = "dfcaverns_jungle_ivy_01.png",
	wield_image = "dfcaverns_jungle_ivy_01.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	drawtype = "signlike",
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
})

-------------------------------------------------------------------------------------
-- Small jungle mushrooms

minetest.register_node("df_primordial_items:jungle_mushroom_1", {
	description = S("Primordial Jungle Mushroom"),
	_doc_items_longdesc = df_primordial_items.doc.small_mushroom_desc,
	_doc_items_usagehelp = df_primordial_items.doc.small_mushroom_usage,
	tiles = {"dfcaverns_jungle_mushroom_01.png"},
	inventory_image = "dfcaverns_jungle_mushroom_01.png",
	wield_image = "dfcaverns_jungle_mushroom_01.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

minetest.register_node("df_primordial_items:jungle_mushroom_2", {
	description = S("Primordial Jungle Mushroom"),
	_doc_items_longdesc = df_primordial_items.doc.small_mushroom_desc,
	_doc_items_usagehelp = df_primordial_items.doc.small_mushroom_usage,
	tiles = {"dfcaverns_jungle_mushroom_02.png"},
	inventory_image = "dfcaverns_jungle_mushroom_02.png",
	wield_image = "dfcaverns_jungle_mushroom_02.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	buildable_to = true,
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
})

----------------------------------------------------------------------------------------
-- Dirt

minetest.register_node("df_primordial_items:dirt_with_jungle_grass", {
	description = S("Dirt With Primordial Jungle Grass"),
	tiles = {"dfcaverns_jungle_plant_grass_node_01.png"},
	groups = {crumbly = 3, soil = 1, spreading_dirt_type = 1},
	drops = "default:dirt",
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_node("df_primordial_items:plant_matter", {
	description = S("Primordial Plant Matter"),
	_doc_items_longdesc = df_primordial_items.doc.plant_matter_desc,
	_doc_items_usagehelp = df_primordial_items.doc.plant_matter_usage,
	tiles = {"dfcaverns_jungle_plant_matter_01.png"},
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_node("df_primordial_items:packed_roots", {
	description = S("Packed Primordial Jungle Roots"),
	_doc_items_longdesc = df_primordial_items.doc.packed_roots_desc,
	_doc_items_usagehelp = df_primordial_items.doc.packed_roots_usage,
	tiles = {"dfcaverns_jungle_plant_packed_roots_01.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

----------------------------------------------------------------------------------------
-- Roots

minetest.register_node("df_primordial_items:jungle_roots_1", {
	description = S("Primordial Jungle Roots"),
	_doc_items_longdesc = df_primordial_items.doc.roots_desc,
	_doc_items_usagehelp = df_primordial_items.doc.roots_usage,
	tiles = {"dfcaverns_jungle_root_01.png"},
	inventory_image = "dfcaverns_jungle_root_01.png",
	wield_image = "dfcaverns_jungle_root_01.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	paramtype2 = "wallmounted",
	drawtype = "signlike",
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
})

minetest.register_node("df_primordial_items:jungle_roots_2", {
	description = S("Primordial Jungle Root"),
	_doc_items_longdesc = df_primordial_items.doc.roots_desc,
	_doc_items_usagehelp = df_primordial_items.doc.roots_usage,
	tiles = {"dfcaverns_jungle_root_02.png"},
	inventory_image = "dfcaverns_jungle_root_02.png",
	wield_image = "dfcaverns_jungle_root_02.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
})

--------------------------------------------------------------------------------
-- Thorns

minetest.register_node("df_primordial_items:jungle_thorns", {
	description = S("Primordial Jungle Thorns"),
	_doc_items_longdesc = df_primordial_items.doc.thorn_desc,
	_doc_items_usagehelp = df_primordial_items.doc.thorn_usage,
	tiles = {"dfcaverns_jungle_thorns_01.png"},
	visual_scale = 1.41,
	inventory_image = "dfcaverns_jungle_thorns_01.png",
	wield_image = "dfcaverns_jungle_thorns_01.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	place_param2 = 3,
	sounds = default.node_sound_leaves_defaults(),
	use_texture_alpha = true,
	sunlight_propagates = true,
	damage_per_second = 1,
})