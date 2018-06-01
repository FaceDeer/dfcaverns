-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_alias("subterrane:dry_stal_1", "dfcaverns:dry_stal_1")
minetest.register_alias("subterrane:dry_stal_1", "dfcaverns:dry_stal_1")
minetest.register_alias("subterrane:dry_stal_1", "dfcaverns:dry_stal_1")
minetest.register_alias("subterrane:dry_stal_1", "dfcaverns:dry_stal_1")
minetest.register_alias("subterrane:wet_stal_1", "dfcaverns:wet_stal_1")
minetest.register_alias("subterrane:wet_stal_1", "dfcaverns:wet_stal_1")
minetest.register_alias("subterrane:wet_stal_1", "dfcaverns:wet_stal_1")
minetest.register_alias("subterrane:wet_stal_1", "dfcaverns:wet_stal_1")
minetest.register_alias("subterrane:wet_flowstone", "dfcaverns:wet_flowstone")
minetest.register_alias("subterrane:dry_flowstone", "dfcaverns:dry_flowstone")

-----------------------------------------------

dfcaverns.dry_stalagmite_ids = subterrane.register_stalagmite_nodes("dfcaverns:dry_stal", {
	description = S("Dry Dripstone"),
	_doc_items_longdesc = dfcaverns.doc.dripstone_desc,
	_doc_items_usagehelp = dfcaverns.doc.dripstone_usage,
	tiles = {
		"default_stone.png^[brighten",
	},
	groups = {cracky = 3, stone = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dfcaverns:dry_flowstone", {
	description = S("Dry Flowstone"),
	_doc_items_longdesc = dfcaverns.doc.flowstone_desc,
	_doc_items_usagehelp = dfcaverns.doc.flowstone_usage,
	tiles = {"default_stone.png^[brighten"},
	groups = {cracky = 3, stone = 1},
	is_ground_content = true,
	drop = 'default:cobble',
	sounds = default.node_sound_stone_defaults(),
})

-----------------------------------------------

dfcaverns.wet_stalagmite_ids = subterrane.register_stalagmite_nodes("dfcaverns:wet_stal", {
	description = S("Wet Dripstone"),
	_doc_items_longdesc = dfcaverns.doc.dripstone_desc,
	_doc_items_usagehelp = dfcaverns.doc.dripstone_usage,
	tiles = {
		"default_stone.png^[brighten^dfcaverns_dripstone_streaks.png",
	},
	groups = {cracky = 3, stone = 2, subterrane_wet_dripstone = 1},
	sounds = default.node_sound_stone_defaults(),
}, "dfcaverns:dry_stal")


minetest.register_node("dfcaverns:wet_flowstone", {
	description = S("Wet Flowstone"),
	_doc_items_longdesc = dfcaverns.doc.flowstone_desc,
	_doc_items_usagehelp = dfcaverns.doc.flowstone_usage,
	tiles = {"default_stone.png^[brighten^dfcaverns_dripstone_streaks.png"},
	groups = {cracky = 3, stone = 1, subterrane_wet_dripstone = 1},
	is_ground_content = true,
	drop = 'default:cobble',
	sounds = default.node_sound_stone_defaults(),
})

-----------------------------------------------

dfcaverns.icicle_ids = subterrane.register_stalagmite_nodes("dfcaverns:icicle", {
	description = S("Icicle"),
	_doc_items_longdesc = dfcaverns.doc.icicle_desc,
	_doc_items_usagehelp = dfcaverns.doc.icicle_usage,
	tiles = {
		"default_ice.png",
	},
	groups = {cracky = 3, puts_out_fire = 1, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_glass_defaults(),
})

