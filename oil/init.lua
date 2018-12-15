local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("oil:oil_source", {
	description = S("Oil"),
	drawtype = "liquid",
	tiles = {
		{
			name = "oil_oil_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name = "oil_oil_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
	alpha = 255,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	sunlight_propagates = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_range = 3,
	liquid_renewable = false,
	liquid_alternative_flowing = "oil:oil_flowing",
	liquid_alternative_source = "oil:oil_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 250, r = 0, g = 0, b = 0},
	groups = {liquid = 3, flammable = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("oil:oil_flowing", {
	description = S("Flowing Oil"),
	drawtype = "flowingliquid",
	tiles = {"oil_oil.png"},
	special_tiles = {
		{
			name = "oil_oil_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 4.0,
			},
		},
		{
			name = "oil_oil_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 4.0,
			},
		},
	},
	alpha = 255,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	sunlight_propagates = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_range = 3,
	liquid_renewable = false,
	liquid_alternative_flowing = "oil:oil_flowing",
	liquid_alternative_source = "oil:oil_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 250, r = 0, g = 0, b = 0},
	groups = {liquid = 3, flammable = 1, not_in_creative_inventory = 1},
	sounds = default.node_sound_water_defaults(),
})


if minetest.get_modpath("dynamic_liquid") then
	dynamic_liquid.liquid_abm("default:water_source", "oil:oil_source", 1)
	dynamic_liquid.liquid_abm("oil:oil_source", "oil:oil_flowing", 2)
end

if minetest.get_modpath("bucket") then
	bucket.register_liquid(
		"oil:oil_source",
		"oil:oil_flowing",
		"oil:oil_bucket",
		"oil_bucket.png",
		S("Oil Bucket")
	)
end