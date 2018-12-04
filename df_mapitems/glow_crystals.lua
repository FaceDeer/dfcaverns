-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--glowing mese crystal blocks
minetest.register_node("df_mapitems:glow_mese", {
	description = S("Flawless Mese Block"),
	_doc_items_longdesc = df_mapitems.doc.glow_mese_desc,
	_doc_items_usagehelp = df_mapitems.doc.glow_mese_usage,
	tiles = {"dfcaverns_glow_mese.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

minetest.register_craft({
	output = 'default:mese_crystal 12',
	recipe = {
		{'df_mapitems:glow_mese'},
	}
})

if minetest.get_modpath("radiant_damage") and radiant_damage.override_radiant_damage and radiant_damage.config.enable_mese_damage then
	radiant_damage.override_radiant_damage("mese", {emitted_by={["df_mapitems:glow_mese"] = radiant_damage.config.mese_damage*12}})
end


minetest.register_node("df_mapitems:glow_ruby_ore", {
	description = S("Crystal Vein"),
	_doc_items_longdesc = df_mapitems.doc.glow_ruby_ore_desc,
	_doc_items_usagehelp = df_mapitems.doc.glow_ruby_ore_usage,
	tiles = {"dfcaverns_glow_ruby_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_node("df_mapitems:big_crystal", {
	description = S("Giant Crystal"),
	_doc_items_longdesc = df_mapitems.doc.big_crystal_desc,
	_doc_items_usagehelp = df_mapitems.doc.big_crystal_usage,
	drawtype = "mesh",
	mesh = "hex_crystal_big.obj",
	tiles = {
		"dfcaverns_glow_ruby4x.png",
		"dfcaverns_glow_ruby.png",
	},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	light_source = 12,
	groups = {cracky=2, dfcaverns_big_crystal = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 3, 0.5},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 3, 0.5},
	},
})

minetest.register_node("df_mapitems:med_crystal", {
	description = S("Big Crystal"),
	_doc_items_longdesc = df_mapitems.doc.big_crystal_desc,
	_doc_items_usagehelp = df_mapitems.doc.big_crystal_usage,
	drawtype = "mesh",
	mesh = "hex_crystal_med.obj",
	tiles = {
		"dfcaverns_glow_ruby.png",
		"dfcaverns_glow_ruby_quarter.png",
	},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	light_source = 12,
	groups = {cracky=2, dfcaverns_big_crystal = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 1.25, 0.25},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 1.25, 0.25},
	},
})


minetest.register_node("df_mapitems:big_crystal_30", {
	description = S("Giant Crystal"),
	_doc_items_longdesc = df_mapitems.doc.big_crystal_desc,
	_doc_items_usagehelp = df_mapitems.doc.big_crystal_usage,
	drawtype = "mesh",
	mesh = "hex_crystal_30_big.obj",
	tiles = {
		"dfcaverns_glow_ruby4x.png",
		"dfcaverns_glow_ruby.png",
	},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	light_source = 12,
	drop = "df_mapitems:big_crystal",
	groups = {cracky=2, dfcaverns_big_crystal = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.625, 0.5, 0.5, 0.375},
			{-0.5, 0.5, -1.25, 0.5, 1.5, -0.25},
			{-0.5, 1.5, -1.875, 0.5, 2.5, -0.875},
			--The following is a more accurate set of collision boxes that theoretically
			--allows the crystal to be climbed like stairs, but in practice the physics
			--don't seem to work quite right so I'm leaving it "simple" for now.
--			{-0.5, -0.5, -0.625, 0.5, 0.0, 0.375},
--			{-0.5, 0.0, -0.9375, 0.5, 0.5, 0.0625},
--			{-0.5, 0.5, -1.25, 0.5, 1.0, -0.25},
--			{-0.5, 1.0, -1.5625, 0.5, 1.5, -0.5625},
--			{-0.5, 1.5, -1.875, 0.5, 2.0, -0.875},
--			{-0.25, 2.0, -1.625, 0.25, 2.5, -1.125},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.625, 0.5, 0.5, 0.375},
			{-0.5, 0.5, -1.25, 0.5, 1.5, -0.25},
			{-0.5, 1.5, -1.875, 0.5, 2.5, -0.875},
--			{-0.5, -0.5, -0.625, 0.5, 0.0, 0.375},
--			{-0.5, 0.0, -0.9375, 0.5, 0.5, 0.0625},
--			{-0.5, 0.5, -1.25, 0.5, 1.0, -0.25},
--			{-0.5, 1.0, -1.5625, 0.5, 1.5, -0.5625},
--			{-0.5, 1.5, -1.875, 0.5, 2.0, -0.875},
--			{-0.25, 2.0, -1.625, 0.25, 2.5, -1.125},
		},
	},
})

minetest.register_node("df_mapitems:med_crystal_30", {
	description = S("Big Crystal"),
	_doc_items_longdesc = df_mapitems.doc.big_crystal_desc,
	_doc_items_usagehelp = df_mapitems.doc.big_crystal_usage,
	drawtype = "mesh",
	mesh = "hex_crystal_30_med.obj",
	tiles = {
		"dfcaverns_glow_ruby.png",
		"dfcaverns_glow_ruby_quarter.png",
	},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	light_source = 12,
	drop = "df_mapitems:med_crystal",
	groups = {cracky=2, dfcaverns_big_crystal = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.3125, 0.25, 0.0, 0.1875},
			{-0.25, 0.0, -0.625, 0.25, 0.5, -0.125},
			{-0.25, 0.5, -0.9375, 0.25, 1.0, -0.4375},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.3125, 0.25, 0.0, 0.1875},
			{-0.25, 0.0, -0.625, 0.25, 0.5, -0.125},
			{-0.25, 0.5, -0.9375, 0.25, 1.0, -0.4375},
		},
	},
})

minetest.register_node("df_mapitems:big_crystal_30_45", {
	description = S("Giant Crystal"),
	_doc_items_longdesc = df_mapitems.doc.big_crystal_desc,
	_doc_items_usagehelp = df_mapitems.doc.big_crystal_usage,
	drawtype = "mesh",
	mesh = "hex_crystal_30_45_big.obj",
	tiles = {
		"dfcaverns_glow_ruby4x.png",
		"dfcaverns_glow_ruby.png",
	},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	light_source = 12,
	drop = "df_mapitems:big_crystal",
	groups = {cracky=2, dfcaverns_big_crystal = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.625, 0.625, 0.5, 0.375},
			{0.0625, 0.5, -1.0625, 1.0625, 1.5, -0.0625},
			{0.5, 1.5, -1.5, 1.5, 2.5, -0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.625, 0.625, 0.5, 0.375},
			{0.0625, 0.5, -1.0625, 1.0625, 1.5, -0.0625},
			{0.5, 1.5, -1.5, 1.5, 2.5, -0.5},
		},
	},
})


minetest.register_node("df_mapitems:med_crystal_30_45", {
	description = S("Big Crystal"),
	_doc_items_longdesc = df_mapitems.doc.big_crystal_desc,
	_doc_items_usagehelp = df_mapitems.doc.big_crystal_usage,
	drawtype = "mesh",
	mesh = "hex_crystal_30_45_med.obj",
	tiles = {
		"dfcaverns_glow_ruby4x.png",
		"dfcaverns_glow_ruby.png",
	},
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	light_source = 12,
	drop = "df_mapitems:med_crystal",
	groups = {cracky=2, dfcaverns_big_crystal = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.3125, 0.3125, 0.0, 0.1875},
			{0.03125, 0.0, -0.53125, 0.53125, 0.5, -0.03125},
			{0.25, 0.5, -0.75, 0.75, 1.0, -0.25},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.3125, 0.3125, 0.0, 0.1875},
			{0.03125, 0.0, -0.53125, 0.53125, 0.5, -0.03125},
			{0.25, 0.5, -0.75, 0.75, 1.0, -0.25},
		},
	},
})

minetest.register_craft({
	type = "shapeless",
	output = 'df_mapitems:big_crystal_30',
	recipe = {'df_mapitems:big_crystal'},
})
minetest.register_craft({
	type = "shapeless",
	output = 'df_mapitems:big_crystal_30_45',
	recipe = {'df_mapitems:big_crystal_30'},
})
minetest.register_craft({
	type = "shapeless",
	output = 'df_mapitems:big_crystal',
	recipe = {'df_mapitems:big_crystal_30_45'},
})
minetest.register_craft({
	type = "shapeless",
	output = 'df_mapitems:med_crystal_30',
	recipe = {'df_mapitems:med_crystal'},
})
minetest.register_craft({
	type = "shapeless",
	output = 'df_mapitems:med_crystal_30_45',
	recipe = {'df_mapitems:med_crystal_30'},
})
minetest.register_craft({
	type = "shapeless",
	output = 'df_mapitems:med_crystal',
	recipe = {'df_mapitems:med_crystal_30_45'},
})

local c_stone = minetest.get_content_id("default:stone")
local c_air = minetest.get_content_id("air")
local c_big_crystal = minetest.get_content_id("df_mapitems:big_crystal")
local c_med_crystal = minetest.get_content_id("df_mapitems:med_crystal")
local c_big_crystal_30 = minetest.get_content_id("df_mapitems:big_crystal_30")
local c_med_crystal_30 = minetest.get_content_id("df_mapitems:med_crystal_30")
local c_big_crystal_30_45 = minetest.get_content_id("df_mapitems:big_crystal_30_45")
local c_med_crystal_30_45 = minetest.get_content_id("df_mapitems:med_crystal_30_45")
local c_glow_ore = minetest.get_content_id("df_mapitems:glow_ruby_ore")

local place_big_crystal = function(data, data_param2, vi, ceiling)
	local orientation = math.random()
	if orientation < 0.33 then
		if math.random() > 0.5 then
			data[vi] = c_big_crystal
		else
			data[vi] = c_med_crystal
		end
	elseif orientation < 0.66 then
		if math.random() > 0.5 then
			data[vi] = c_big_crystal_30
		else
			data[vi] = c_med_crystal_30
		end
	else
		if math.random() > 0.5 then
			data[vi] = c_big_crystal_30_45
		else
			data[vi] = c_med_crystal_30_45
		end
	end
	if ceiling then
		data_param2[vi] = math.random(20,23)
	else
		data_param2[vi] = math.random(0,3)
	end

end

df_mapitems.place_big_crystal_cluster = function(area, data, data_param2, vi, radius, ceiling)
	local y
	if ceiling then y = -1 else y = 1 end
	local pos = area:position(vi)	
	for li in area:iterp(vector.add(pos, -radius), vector.add(pos, radius)) do
		local adjacent = li + y*area.ystride
		if math.random() > 0.5  and data[li] == c_stone and data[adjacent] == c_air then
			place_big_crystal(data, data_param2, adjacent, ceiling)
			data[li] = c_glow_ore
		end
	end
end
