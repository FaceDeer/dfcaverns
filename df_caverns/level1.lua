local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_cobble = minetest.get_content_id("default:cobble")
local c_mossycobble = minetest.get_content_id("default:mossycobble")
local c_dirt = minetest.get_content_id("default:dirt")
local c_gravel = minetest.get_content_id("default:gravel")

local c_dirt_moss = minetest.get_content_id("df_mapitems:dirt_with_cave_moss")
local c_cobble_fungus_fine = minetest.get_content_id("df_mapitems:cobble_with_floor_fungus_fine")
local c_cobble_fungus = minetest.get_content_id("df_mapitems:cobble_with_floor_fungus")

local c_wet_flowstone = minetest.get_content_id("df_mapitems:wet_flowstone")
local c_dry_flowstone = minetest.get_content_id("df_mapitems:dry_flowstone")

local c_sweet_pod = minetest.get_content_id("df_farming:sweet_pod_6") -- param2 = 0
local c_quarry_bush = minetest.get_content_id("df_farming:quarry_bush_5") -- param2 = 4
local c_plump_helmet = minetest.get_content_id("df_farming:plump_helmet_4") -- param2 = 0-3
local c_pig_tail = minetest.get_content_id("df_farming:pig_tail_8") -- param2 = 3
local c_dimple_cup = minetest.get_content_id("df_farming:dimple_cup_4") -- param2 = 0
local c_cave_wheat = minetest.get_content_id("df_farming:cave_wheat_8") -- param2 = 3
local c_dead_fungus = minetest.get_content_id("df_farming:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("df_farming:cavern_fungi") -- param2 = 0

--local subsea_level = (df_caverns.config.ymax - df_caverns.config.level1_min) * 0.3 + df_caverns.config.level1_min


-- name = "dfcaverns_level1_dry_biome",
-- name = "dfcaverns_level1_flooded_biome",
-- name = "dfcaverns_level1_fungiwood_biome",
-- name = "dfcaverns_level1_fungiwood_flooded_biome",
-- name = "dfcaverns_level1_tower_cap_biome",
-- name = "dfcaverns_level1_tower_cap_flooded_biome",

--local c_mese = minetest.get_content_id("default:mese")

local Set = function(list)
	local set = {}
    for _, l in ipairs(list) do set[l] = true end
	return set
end

local dry_biomes = {"dfcaverns_level1_dry_biome"}

local decorate_level_1 = function(minp, maxp, seed, vm, node_arrays, area, data)
	local biomemap = minetest.get_mapgen_object("biomemap")
	local data_param2 = df_caverns.data_param2
	vm:get_param2_data(data_param2)
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, df_caverns.np_cracks)
	
	---------------------------------------------------------
	-- Cavern floors
	
	for _, vi in pairs(node_arrays.cavern_floor_nodes) do
		local biome, cracks, vert_rand = df_caverns.get_decoration_node_data(minp, maxp, area, vi, biomemap, nvals_cracks)
		local abs_cracks = math.abs(cracks)
		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		
		if biome_name == "dfcaverns_level1_tower_cap_biome" or
			biome_name == "dfcaverns_level1_tower_cap_flooded_biome" then

			df_caverns.tower_cap_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
			
		elseif biome_name == "dfcaverns_level1_fungiwood_biome" or
			biome_name == "dfcaverns_level1_fungiwood_flooded_biome" then

			df_caverns.fungiwood_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
	
		elseif biome_name == "dfcaverns_level1_flooded_biome" then

			df_caverns.flooded_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
			
		elseif biome_name == "dfcaverns_level1_dry_biome" then
			df_caverns.dry_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		end		
	end

	--------------------------------------
	-- Cavern ceilings
	
	for _, vi in pairs(node_arrays.cavern_ceiling_nodes) do
		local biome, cracks, vert_rand = df_caverns.get_decoration_node_data(minp, maxp, area, vi, biomemap, nvals_cracks)
		local abs_cracks = math.abs(cracks)
		
		local biome_name
		if biome then
			biome_name = biome.name
		end

		if biome_name == "dfcaverns_level1_tower_cap_biome" or
			biome_name == "dfcaverns_level1_tower_cap_flooded_biome" or
			biome_name == "dfcaverns_level1_fungiwood_biome" or
			biome_name == "dfcaverns_level1_fungiwood_flooded_biome" then
			
			df_caverns.glow_worm_cavern_ceiling(abs_cracks, vert_rand, vi, area, data, data_param2)
			
		elseif biome_name == "dfcaverns_level1_flooded_biome" then
			if abs_cracks < 0.1 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
			end

		elseif biome_name == "dfcaverns_level1_dry_biome" then
			if abs_cracks < 0.075 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
			end	
		end
	end
	
	----------------------------------------------
	-- Tunnel floors
	
	for _, vi in pairs(node_arrays.tunnel_floor_nodes) do
		df_caverns.basic_tunnel_floor(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level1_flooded_biome", dry_biomes)
	end
	
	------------------------------------------------------
	-- Tunnel ceiling
	
	for _, vi in pairs(node_arrays.tunnel_ceiling_nodes) do
		df_caverns.basic_tunnel_ceiling(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level1_flooded_biome", dry_biomes)
	end
	
	------------------------------------------------------
	-- Warren ceiling

	for _, vi in pairs(node_arrays.warren_ceiling_nodes) do
		df_caverns.basic_tunnel_ceiling(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level1_flooded_biome", dry_biomes)
	end

	----------------------------------------------
	-- Warren floors
	
	for _, vi in pairs(node_arrays.warren_floor_nodes) do
		df_caverns.basic_tunnel_floor(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level1_flooded_biome", dry_biomes)
	end
	
	----------------------------------------------
	-- Column material override for dry biome
	
	for _, vi in pairs(node_arrays.column_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		if biome and biome.name == "dfcaverns_level1_dry_biome" then
			data[vi] = c_dry_flowstone
		end
	end

	vm:set_param2_data(data_param2)
end

-------------------------------------------------------------------------------------------

minetest.register_biome({
	name = "dfcaverns_level1_flooded_biome",
	y_min = df_caverns.config.level1_min,
	y_max = df_caverns.config.ymax,
	heat_point = 50,
	humidity_point = 100,
})

minetest.register_biome({
	name = "dfcaverns_level1_tower_cap_biome",
	y_min = df_caverns.config.level1_min,
	y_max = df_caverns.config.ymax,
	heat_point = 30,
	humidity_point = 40,
})

minetest.register_biome({
	name = "dfcaverns_level1_fungiwood_biome",
	y_min = df_caverns.config.level1_min,
	y_max = df_caverns.config.ymax,
	heat_point = 70,
	humidity_point = 40,
})

minetest.register_biome({
	name = "dfcaverns_level1_tower_cap_flooded_biome",
	y_min = df_caverns.config.level1_min,
	y_max = df_caverns.config.ymax,
	heat_point = 20,
	humidity_point = 80,
})

minetest.register_biome({
	name = "dfcaverns_level1_fungiwood_flooded_biome",
	y_min = df_caverns.config.level1_min,
	y_max = df_caverns.config.ymax,
	heat_point = 80,
	humidity_point = 80,
})

minetest.register_biome({
	name = "dfcaverns_level1_dry_biome",
	y_min = df_caverns.config.level1_min,
	y_max = df_caverns.config.ymax,
	heat_point = 50,
	humidity_point = 0,
})

local perlin_cave = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale, y=df_caverns.config.vertical_cavern_scale, z=df_caverns.config.horizontal_cavern_scale},
	seed = -400000000089,
	octaves = 3,
	persist = 0.67
}

local perlin_wave = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale * 2, y=df_caverns.config.vertical_cavern_scale, z=df_caverns.config.horizontal_cavern_scale * 2}, -- squashed 2:1
	seed = 59033,
	octaves = 6,
	persist = 0.63
}

subterrane.register_layer({
	y_max = df_caverns.config.ymax,
	y_min = df_caverns.config.level1_min,
	cave_threshold = df_caverns.config.cavern_threshold,
	perlin_cave = perlin_cave,
	perlin_wave = perlin_wave,
	solidify_lava = true,
	columns = {
		maximum_radius = 10,
		minimum_radius = 4,
		node = c_wet_flowstone,
		weight = 0.25,
		maximum_count = 50,
		minimum_count = 0,
	},
	decorate = decorate_level_1,
})