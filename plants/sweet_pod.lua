-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local sweet_pod_grow_time = dfcaverns.config.plant_growth_time * dfcaverns.config.sweet_pod_delay_multiplier / 6

local register_sweet_pod = function(number)
	local name = "dfcaverns:sweet_pod_"..tostring(number)
	local def = {
		description = S("Sweet Pod"),
		_doc_items_longdesc = dfcaverns.doc.sweet_pod_desc,
		_doc_items_usagehelp = dfcaverns.doc.sweet_pod_usage,
		drawtype = "plantlike",
		tiles = {"dfcaverns_sweet_pod_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_sweet_pod_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
		
		on_timer = function(pos, elapsed)
			dfcaverns.grow_underground_plant(pos, name, elapsed)
		end,

		drop = {
			max_items = 2,
			items = {
				{
					items = {'dfcaverns:sweet_pod_seed 2', 'dfcaverns:sweet_pods 2'},
					rarity = 7-number,
				},
				{
					items = {'dfcaverns:sweet_pod_seed', 'dfcaverns:sweet_pods'},
					rarity = 7-number,
				},
				{
					items = {'dfcaverns:sweet_pod_seed'},
					rarity = 7-number,
				},
			},
		},
	}
	
	if number < 6 then
		def._dfcaverns_next_stage = "dfcaverns:sweet_pod_"..tostring(number+1)
		def._dfcaverns_next_stage_time = sweet_pod_grow_time
	end
	
	minetest.register_node(name, def)
end

for i = 1,6 do
	register_sweet_pod(i)
end

dfcaverns.register_seed(
	"sweet_pod_seed",
	S("Sweet Pod Spores"),
	"dfcaverns_sweet_pod_seed.png",
	"dfcaverns:sweet_pod_1",
	sweet_pod_grow_time,
	dfcaverns.doc.sweet_pod_desc,
	dfcaverns.doc.sweet_pod_usage)

minetest.register_craftitem("dfcaverns:sweet_pods", {
	description = S("Sweet Pods"),
	_doc_items_longdesc = dfcaverns.doc.sweet_pod_desc,
	_doc_items_usagehelp = dfcaverns.doc.sweet_pod_usage,
	inventory_image = "dfcaverns_sweet_pods.png",
	stack_max = 99,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:sweet_pods",
	burntime = 4
})

---------------------------------------------
-- Sugar

minetest.register_craftitem("dfcaverns:sugar", {
	description = S("Sweet Pod Sugar"),
	_doc_items_longdesc = dfcaverns.doc.sweet_pod_sugar_desc,
	_doc_items_usagehelp = dfcaverns.doc.sweet_pod_sugar_usage,
	inventory_image = "dfcaverns_sugar.png",
	groups = {dfcaverns_cookable = 1},
})

if minetest.get_modpath("cottages") then
	cottages.handmill_product["dfcaverns:sweet_pods"] = "dfcaverns:sugar";
else
minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "dfcaverns:sugar",
	recipe = "dfcaverns:sweet_pods",
})
end

----------------------------------------------
-- Syrup

if minetest.get_modpath("bucket") then
	minetest.register_node("dfcaverns:dwarven_syrup_source", {
		description = S("Dwarven Syrup Source"),
		_doc_items_longdesc = dfcaverns.doc.sweet_pod_syrup_desc,
		_doc_items_usagehelp = dfcaverns.doc.sweet_pod_syrup_usage,
		drawtype = "liquid",
		tiles = {
			{
				name = "dfcaverns_dwarven_syrup_source_animated.png",
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
			},
		},
		special_tiles = {
			{
				name = "dfcaverns_dwarven_syrup_source_animated.png",
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 2.0,
				},
				backface_culling = false,
			},
		},
		alpha = 204,
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		is_ground_content = false,
		drop = "",
		drowning = 1,
		liquidtype = "source",
		liquid_alternative_flowing = "dfcaverns:dwarven_syrup_flowing",
		liquid_alternative_source = "dfcaverns:dwarven_syrup_source",
		liquid_viscosity = 7,
		liquid_renewable = false,
		liquid_range = 2,
		post_effect_color = {a = 204, r = 179, g = 131, b = 88},
		groups = {liquid = 3, flammable = 2},
		sounds = default.node_sound_water_defaults(),
	})
	
	minetest.register_node("dfcaverns:dwarven_syrup_flowing", {
		description = S("Flowing Dwarven Syrup"),
		_doc_items_longdesc = dfcaverns.doc.sweet_pod_syrup_desc,
		_doc_items_usagehelp = dfcaverns.doc.sweet_pod_syrup_usage,
		drawtype = "flowingliquid",
		tiles = {"dfcaverns_dwarven_syrup.png"},
		special_tiles = {
			{
				name = "dfcaverns_dwarven_syrup_flowing_animated.png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 0.8,
				},
			},
			{
				name = "dfcaverns_dwarven_syrup_flowing_animated.png",
				backface_culling = true,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 0.8,
				},
			},
		},
		alpha = 204,
		paramtype = "light",
		paramtype2 = "flowingliquid",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		is_ground_content = false,
		drop = "",
		drowning = 1,
		liquidtype = "flowing",
		liquid_alternative_flowing = "dfcaverns:dwarven_syrup_flowing",
		liquid_alternative_source = "dfcaverns:dwarven_syrup_source",
		liquid_viscosity = 7,
		liquid_renewable = false,
		liquid_range = 2,
		post_effect_color = {a = 204, r = 179, g = 131, b = 88},
		groups = {liquid = 3, flammable = 2, not_in_creative_inventory = 1},
		sounds = default.node_sound_water_defaults(),
	})

	bucket.register_liquid(
		"dfcaverns:dwarven_syrup_source",
		"dfcaverns:dwarven_syrup_flowing",
		"dfcaverns:dwarven_syrup_bucket",
		"dfcaverns_bucket_dwarven_syrup.png",
		S("Dwarven Syrup Bucket")
	)
	
	if minetest.get_modpath("simplecrafting_lib") then
		simplecrafting_lib.register("cooking", {
			input = {
				["bucket:bucket_empty"] = 1,
				["dfcaverns:sugar"] = 3,
			},
			output = {
				["dfcaverns:dwarven_syrup_bucket"] = 1,
			},
			cooktime = 5.0,
		})
	else
		minetest.register_craft({
			type = "shapeless",
			output = "dfcaverns:dwarven_syrup_bucket",
			recipe = {"bucket:bucket_empty", "dfcaverns:sugar", "dfcaverns:sugar", "dfcaverns:sugar"},
		})
	end
	
	if minetest.get_modpath("dynamic_liquid") then
		dynamic_liquid.liquid_abm("dfcaverns:dwarven_syrup_source", "dfcaverns:dwarven_syrup_flowing", 5)
	end
end