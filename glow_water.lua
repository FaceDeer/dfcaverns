-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("dfcaverns:glow_water_source", {
	description = S("Mese Water"),
	_doc_items_longdesc = dfcaverns.doc.glow_water_desc,
	_doc_items_usagehelp = dfcaverns.doc.glow_water_usage,
	drawtype = "liquid",
	tiles = {
		{
			name = "default_water_source_animated.png",
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
			name = "default_water_source_animated.png",
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
	liquid_alternative_flowing = "dfcaverns:glow_water_flowing",
	liquid_alternative_source = "dfcaverns:glow_water_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	liquid_range = 2,
	light_source = default.LIGHT_MAX,
	post_effect_color = {a = 204, r = 250, g = 250, b = 10},
	groups = {liquid = 3, flammable = 2},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("dfcaverns:glow_water_flowing", {
	description = S("Flowing Mese Water"),
	_doc_items_longdesc = dfcaverns.doc.glow_water_desc,
	_doc_items_usagehelp = dfcaverns.doc.glow_water_usage,
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			name = "default_water_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "default_water_flowing_animated.png",
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
	liquid_alternative_flowing = "dfcaverns:glow_water_flowing",
	liquid_alternative_source = "dfcaverns:glow_water_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	liquid_range = 2,
	light_source = 8,
	post_effect_color = {a = 204, r = 250, g = 250, b = 10},
	groups = {liquid = 3, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_water_defaults(),
})

local random_direction ={
	{x=0,y=0,z=1},
	{x=0,y=0,z=-1},
	{x=0,y=1,z=0},
	{x=0,y=-1,z=0},
	{x=1,y=0,z=0},
	{x=-1,y=0,z=0},
}

local get_node = minetest.get_node
local set_node = minetest.set_node

local spark_spawner = {
	amount = 5,
	time = 0.1,
	minvel = {x=1, y=1, z=1},
	maxvel = {x=-1, y=-1, z=-1},
	minacc = {x=0, y= 2, z=0},
	maxacc = {x=0, y= 2, z=0},
	minexptime = 0.5,
	maxexptime = 1,
	minsize = 1,
	maxsize = 1,
	collisiondetection = true,
	vertical = false,
	texture = "dfcaverns_spark.png",
}

minetest.register_abm({
	label = "dfcaverns glow_water",
	nodenames = {"dfcaverns:glow_water_source"},
	neighbors = {"default:water_source"},
	interval = 2,
	chance = 2,
	catch_up = false,
	action = function(pos,node) -- Do everything possible to optimize this method
		spark_spawner.minpos = vector.add(pos, -0.5)
		spark_spawner.maxpos = vector.add(pos, 0.5)
		minetest.add_particlespawner(spark_spawner)

		local check_pos = vector.add(pos, random_direction[math.random(6)])
		local check_node = get_node(check_pos)
		local check_node_name = check_node.name
		if check_node_name == "default:water_source" then
			set_node(pos, check_node)
			set_node(check_pos, node)
		end
	end
})	

if minetest.get_modpath("bucket") then
	bucket.register_liquid(
		"dfcaverns:glow_water_source",
		"dfcaverns:glow_water_flowing",
		"dfcaverns:glow_water_bucket",
		"dfcaverns_bucket_dwarven_syrup.png",
		S("Glow Water Bucket")
	)
end

if minetest.get_modpath("dynamic_liquid") then
	dynamic_liquid.liquid_abm("dfcaverns:glow_water_source", "dfcaverns:glow_water_flowing", 5)
end