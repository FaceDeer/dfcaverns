local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local oil_desc
local oil_usage

if minetest.get_modpath("doc") then
	oil_desc = S("Liquid hydrocarbons formed from the detritus of long dead plants and animals processed by heat and pressure deep within the earth.")
	oil_usage = S("Buckets of oil can be used as fuel.")
end

dofile(MP.."/gas.lua")

minetest.register_node("oil:oil_source", {
	description = S("Oil"),
	_doc_items_longdesc = oil_desc,
	_doc_items_usagehelp = oil_usage,
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
	groups = {liquid = 3},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("oil:oil_flowing", {
	description = S("Flowing Oil"),
	_doc_items_longdesc = oil_desc,
	_doc_items_usagehelp = oil_usage,
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
	groups = {liquid = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_craft({
	type = "fuel",
	recipe = "oil:oil_source",
	burntime = 370, -- same as coalblock
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
	
	minetest.register_craft({
		type = "fuel",
		recipe = "bucket:oil_bucket",
		burntime = 370, -- same as coalblock
		replacements = {{"bucket:oil_bucket", "bucket:bucket_empty"}},
	})
end