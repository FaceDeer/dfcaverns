local S = df_mapitems.S


local function soil_type_spread(label, node_to_spread, target_node)
	minetest.register_abm{
		label = label,
		nodenames = {target_node},
		neighbors = {node_to_spread},
		interval = 60,
		chance = 15,
		catch_up = true,
		action = function(pos)
			local above_def = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name]
			if above_def and (above_def.buildable_to == true or above_def.walkable == false) then
				minetest.swap_node(pos, {name=node_to_spread})
			end
		end,
	}
end


--------------------------------------------------
-- Cave moss

-- cyan/dark cyan

minetest.register_node("df_mapitems:dirt_with_cave_moss", {
	description = S("Dirt with Cave Moss"),
	_doc_items_longdesc = df_mapitems.doc.cave_moss_desc,
	_doc_items_usagehelp = df_mapitems.doc.cave_moss_usage,
	tiles = {"default_dirt.png^dfcaverns_cave_moss.png", "default_dirt.png", 
		{name = "default_dirt.png^(dfcaverns_cave_moss.png^[mask:dfcaverns_ground_cover_side_mask.png)",
			tileable_vertical = false}},
	drop = "default:dirt",
	is_ground_content = false,
	light_source = 2,
	paramtype = "light",
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

soil_type_spread("df_mapitems:cave_moss_spread", "df_mapitems:dirt_with_cave_moss", "default:dirt")

---------------------------------------------------------------
-- Sand scum

minetest.register_node("df_mapitems:sand_scum", {
	description = S("Sand Scum"),
	_doc_items_longdesc = df_mapitems.doc.sand_scum_desc,
	_doc_items_usagehelp = df_mapitems.doc.sand_scum_usage,
	tiles = {"dfcaverns_ground_cover_sand_scum.png", "default_sand.png", 
		{name = "default_sand.png^(dfcaverns_ground_cover_sand_scum.png^[mask:dfcaverns_ground_cover_side_mask.png)",
			tileable_vertical = false}},
	drop = "default:sand",
	is_ground_content = false,
	light_source = 2,
	paramtype = "light",
	groups = {crumbly = 3, soil = 1, light_sensitive_fungus = 8},
	sounds = default.node_sound_sand_defaults({
		footstep = {name = "dfcaverns_squish", gain = 0.25},
	}),
	_dfcaverns_dead_node = "default:sand",
})

soil_type_spread("df_mapitems:sand_scum_spread", "df_mapitems:sand_scum", "default:sand")

---------------------------------------------------------------
-- Pebble fungus

minetest.register_node("df_mapitems:dirt_with_pebble_fungus", {
	description = S("Dirt with Pebble Fungus"),
	_doc_items_longdesc = df_mapitems.doc.pebble_fungus_desc,
	_doc_items_usagehelp = df_mapitems.doc.pebble_fungus_usage,
	tiles = {"dfcaverns_ground_cover_pebble_fungus.png", "default_dirt.png", 
		{name = "default_dirt.png^(dfcaverns_ground_cover_pebble_fungus.png^[mask:dfcaverns_ground_cover_side_mask.png)",
			tileable_vertical = false}},
	drop = "default:dirt",
	is_ground_content = false,
	light_source = 2,
	paramtype = "light",
	groups = {crumbly = 3, soil = 1, light_sensitive_fungus = 8},
	sounds = default.node_sound_dirt_defaults(),
	soil = {
		base = "df_mapitems:dirt_with_pebble_fungus",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	_dfcaverns_dead_node = "default:dirt",
})

soil_type_spread("df_mapitems:pebble_fungus_spread", "df_mapitems:dirt_with_pebble_fungus", "default:dirt")

---------------------------------------------------------------
-- Stillworm

minetest.register_node("df_mapitems:dirt_with_stillworm", {
	description = S("Dirt with Stillworm"),
	_doc_items_longdesc = df_mapitems.doc.stillworm_desc,
	_doc_items_usagehelp = df_mapitems.doc.stillworm_usage,
	tiles = {"default_dirt.png^dfcaverns_ground_cover_stillworm.png", "default_dirt.png", 
		{name = "default_dirt.png^(dfcaverns_ground_cover_stillworm.png^[mask:dfcaverns_ground_cover_side_mask.png)",
			tileable_vertical = false}},
	drop = "default:dirt",
	is_ground_content = false,
	light_source = 2,
	paramtype = "light",
	groups = {crumbly = 3, soil = 1, light_sensitive_fungus = 8},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
	soil = {
		base = "df_mapitems:dirt_with_stillworm",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	_dfcaverns_dead_node = "default:dirt",
})

soil_type_spread("df_mapitems:stillworm_spread", "df_mapitems:dirt_with_stillworm", "default:dirt")

---------------------------------------------------------------
-- Spongestone / Rock rot

minetest.register_node("df_mapitems:spongestone", {
	description = S("Spongestone"),
	_doc_items_longdesc = df_mapitems.doc.sponge_stone_desc,
	_doc_items_usagehelp = df_mapitems.doc.sponge_stone_usage,
	tiles = {"dfcaverns_ground_cover_sponge_stone.png"},
	is_ground_content = false,
	paramtype = "light",
	groups = {crumbly = 3, soil = 1, light_sensitive_fungus = 8},
	sounds = default.node_sound_dirt_defaults(),
	soil = {
		base = "df_mapitems:spongestone",
		dry = "farming:soil",
		wet = "farming:soil_wet"
	},
	_dfcaverns_dead_node = "default:dirt",
})

minetest.register_node("df_mapitems:rock_rot", {
	description = S("Rock Rot"),
	_doc_items_longdesc = df_mapitems.doc.rock_rot_desc,
	_doc_items_usagehelp = df_mapitems.doc.rock_rot_usage,
	tiles = {"default_stone.png^dfcaverns_ground_cover_rock_rot.png", "default_stone.png", 
		{name = "default_stone.png^(dfcaverns_ground_cover_rock_rot.png^[mask:dfcaverns_ground_cover_side_mask.png)",
			tileable_vertical = false}},
	drop = "default:cobble",
	is_ground_content = false,
	light_source = 2,
	paramtype = "light",
	groups = {crumbly = 3, soil = 1, light_sensitive_fungus = 8},
	sounds = default.node_sound_dirt_defaults(),
	_dfcaverns_dead_node = "default:stone",
})

soil_type_spread("df_mapitems:rock_rot_spread", "df_mapitems:rock_rot", "default:stone")
soil_type_spread("df_mapitems:spongestone_spread", "df_mapitems:spongestone", "default:rock_rot")

--------------------------------------------------
-- floor fungus

-- white/yellow

minetest.register_node("df_mapitems:cobble_with_floor_fungus", {
	description = S("Cobblestone with Floor Fungus"),
	_doc_items_longdesc = df_mapitems.doc.floor_fungus_desc,
	_doc_items_usagehelp = df_mapitems.doc.floor_fungus_usage,
	tiles = {"default_cobble.png^dfcaverns_floor_fungus.png"},
	drops = "default:cobble",
	is_ground_content = false,
	paramtype = "light",
	groups = {cracky = 3, stone = 2, slippery = 1, light_sensitive_fungus = 8},
	_dfcaverns_dead_node = "default:cobble",
	sounds = default.node_sound_stone_defaults({
		footstep = {name = "dfcaverns_squish", gain = 0.25},
	}),
})

minetest.register_node("df_mapitems:cobble_with_floor_fungus_fine", {
	description = S("Cobblestone with Floor Fungus"),
	_doc_items_longdesc = df_mapitems.doc.floor_fungus_desc,
	_doc_items_usagehelp = df_mapitems.doc.floor_fungus_usage,
	tiles = {"default_cobble.png^dfcaverns_floor_fungus_fine.png"},
	drops = "default:cobble",
	is_ground_content = false,
	paramtype = "light",
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
	chance = 10,
	catch_up = true,
	action = function(pos)
		minetest.swap_node(pos, {name="df_mapitems:cobble_with_floor_fungus_fine"})
	end,
}
minetest.register_abm{
	label = "df_mapitems:floor_fungus_thickening",
	nodenames = {"default:cobble_with_floor_fungus_fine"},
	interval = 59,
	chance = 10,
	catch_up = true,
	action = function(pos)
		minetest.swap_node(pos, {name="df_mapitems:cobble_with_floor_fungus"})
	end,
}

------------------------------------------------------
-- Hoar moss

minetest.register_node("df_mapitems:ice_with_hoar_moss", {
	description = S("Ice with Hoar Moss"),
	_doc_items_longdesc = df_mapitems.doc.hoar_moss_desc,
	_doc_items_usagehelp = df_mapitems.doc.hoar_moss_usage,
	tiles = {"default_ice.png^dfcaverns_hoar_moss.png"},
	drops = "default:ice",
	paramtype = "light",
	light_source = 2,
	is_ground_content = false,
	groups = {cracky = 3, puts_out_fire = 1, cools_lava = 1, slippery = 2, light_sensitive_fungus = 8},
	sounds = default.node_sound_glass_defaults(),
	_dfcaverns_dead_node = "default:ice",
})


----------------------------------------------------------------
-- Footprint-capable nodes

if minetest.get_modpath("footprints") then
	local HARDPACK_PROBABILITY = tonumber(minetest.settings:get("footprints_hardpack_probability")) or 0.9 -- Chance walked dirt/grass is worn and compacted to footprints:trail.
	local HARDPACK_COUNT = tonumber(minetest.settings:get("footprints_hardpack_count")) or 10 -- Number of times the above chance needs to be passed for soil to compact.

	footprints.register_trample_node("df_mapitems:dirt_with_cave_moss", {
		trampled_node_def_override = {description = S("Dirt with Cave Moss and Footprint"),},
		hard_pack_node_name = "footprints:trail",
		footprint_opacity = 128,
		hard_pack_probability = HARDPACK_PROBABILITY,
		hard_pack_count = HARDPACK_COUNT,
	})

	footprints.register_trample_node("df_mapitems:sand_scum", {
		trampled_node_def_override = {description = S("Sand Scum with Footprint"),},
		hard_pack_node_name = "default:sand",
		footprint_opacity = 128,
		hard_pack_probability = HARDPACK_PROBABILITY,
		hard_pack_count = HARDPACK_COUNT * 0.5,
	})

	footprints.register_trample_node("df_mapitems:spongestone", {
		trampled_node_def_override = {description = S("Spongestone with Footprint"),},
		hard_pack_node_name = "footprints:trail",
		footprint_opacity = 128,
		hard_pack_probability = HARDPACK_PROBABILITY,
		hard_pack_count = HARDPACK_COUNT * 2,
	})

	footprints.register_trample_node("df_mapitems:dirt_with_pebble_fungus", {
		trampled_node_def_override = {description = S("Dirt with Pebble Fungus and Footprint"),},
		hard_pack_node_name = "footprints:trail",
		footprint_opacity = 128,
		hard_pack_probability = HARDPACK_PROBABILITY,
		hard_pack_count = HARDPACK_COUNT,
	})

	footprints.register_trample_node("df_mapitems:dirt_with_stillworm", {
		trampled_node_def_override = {description = S("Dirt with Stillworm and Footprint"),},
		hard_pack_node_name = "footprints:trail",
		footprint_opacity = 192,
		hard_pack_probability = HARDPACK_PROBABILITY,
		hard_pack_count = HARDPACK_COUNT,
	})
end
