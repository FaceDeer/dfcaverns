-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--glowing mese crystal blocks
minetest.register_node("dfcaverns:glow_mese", {
	description = S("Flawless Mese Block"),
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
		{'dfcaverns:glow_mese'},
	}
})

minetest.register_node("dfcaverns:glow_ruby_ore", {
	description = S("Crystal Vein"),
	tiles = {"dfcaverns_glow_ruby_ore.png"},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
})


minetest.register_node("dfcaverns:big_crystal", {
	description = S("Giant Crystal"),
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
	walkable = false,
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

minetest.register_node("dfcaverns:med_crystal", {
	description = S("Big Crystal"),
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
	walkable = false,
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


minetest.register_node("dfcaverns:big_crystal_30", {
	description = S("Giant Crystal"),
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
	walkable = false,
	light_source = 12,
	drop = "dfcaverns:big_crystal",
	groups = {cracky=2, dfcaverns_big_crystal = 1},
	sounds = default.node_sound_glass_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.625, 0.5, 0.5, 0.375},
			{-0.5, 0.5, -1.25, 0.5, 1.5, -0.25},
			{-0.5, 1.5, -1.875, 0.5, 2.5, -0.875},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.625, 0.5, 0.5, 0.375},
			{-0.5, 0.5, -1.25, 0.5, 1.5, -0.25},
			{-0.5, 1.5, -1.875, 0.5, 2.5, -0.875},
		},
	},
})

minetest.register_node("dfcaverns:med_crystal_30", {
	description = S("Big Crystal"),
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
	walkable = false,
	light_source = 12,
	drop = "dfcaverns:med_crystal",
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

minetest.register_node("dfcaverns:big_crystal_30_45", {
	description = S("Giant Crystal"),
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
	walkable = false,
	light_source = 12,
	drop = "dfcaverns:big_crystal",
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


minetest.register_node("dfcaverns:med_crystal_30_45", {
	description = S("Big Crystal"),
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
	walkable = false,
	light_source = 12,
	drop = "dfcaverns:med_crystal",
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

local c_stone = minetest.get_content_id("default:stone")
local c_air = minetest.get_content_id("air")
local c_big_crystal = minetest.get_content_id("dfcaverns:big_crystal")
local c_med_crystal = minetest.get_content_id("dfcaverns:med_crystal")
local c_big_crystal_30 = minetest.get_content_id("dfcaverns:big_crystal_30")
local c_med_crystal_30 = minetest.get_content_id("dfcaverns:med_crystal_30")
local c_big_crystal_30_45 = minetest.get_content_id("dfcaverns:big_crystal_30_45")
local c_med_crystal_30_45 = minetest.get_content_id("dfcaverns:med_crystal_30_45")
local c_glow_ore = minetest.get_content_id("dfcaverns:glow_ruby_ore")

local place_big_crystal = function(data, data_param2, i, ceiling)
	orientation = math.random()
	if orientation < 0.33 then
		if math.random() > 0.5 then
			data[i] = c_big_crystal
		else
			data[i] = c_med_crystal
		end
	elseif orientation < 0.66 then
		if math.random() > 0.5 then
			data[i] = c_big_crystal_30
		else
			data[i] = c_med_crystal_30
		end
	else
		if math.random() > 0.5 then
			data[i] = c_big_crystal_30_45
		else
			data[i] = c_med_crystal_30_45
		end
	end
	if ceiling then
		data_param2[i] = math.random(20,23)
	else
		data_param2[i] = math.random(0,3)
	end

end

dfcaverns.place_big_crystal_cluster = function(area, data, data_param2, i, radius, ceiling)
	local y
	if ceiling then y = -1 else y = 1 end
	local pos = area:position(i)	
	for li in area:iterp(vector.add(pos, -radius), vector.add(pos, radius)) do
		local adjacent = li + y*area.ystride
		if math.random() > 0.5  and data[li] == c_stone and data[adjacent] == c_air then
			place_big_crystal(data, data_param2, adjacent, ceiling)
			data[li] = c_glow_ore
		end
	end
end
