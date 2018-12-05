--df_trees.spawn_tunnel_tube_vm(vi, area, data, param2_data)
--df_trees.spawn_spore_tree_vm(vi, data, area)
--df_trees.spawn_nether_cap_vm(vi, area, data)
--df_trees.spawn_goblin_cap_vm(vi, area, data)
--df_trees.spawn_blood_thorn_vm(vi, area, data, data_param2)

local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_cobble = minetest.get_content_id("default:cobble")
local c_mossycobble = minetest.get_content_id("default:mossycobble")
local c_dirt = minetest.get_content_id("default:dirt")
local c_stone_with_coal = minetest.get_content_id("default:stone_with_coal")

local c_dirt_moss = minetest.get_content_id("df_mapitems:dirt_with_cave_moss")
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

local subsea_level = (df_caverns.config.level1_min - df_caverns.config.level2_min) * 0.3 + df_caverns.config.level2_min
local flooded_biomes = df_caverns.config.flooded_biomes

-- name = "dfcaverns_level2_black_cap_biome",
-- name = "dfcaverns_level2_dry_biome",
-- name = "dfcaverns_level2_flooded_biome",
-- name = "dfcaverns_level2_fungiwood_biome",
-- name = "dfcaverns_level2_goblin_cap_biome",
-- name = "dfcaverns_level2_spore_tree_biome",
-- name = "dfcaverns_level2_tower_cap_biome",
-- name = "dfcaverns_level2_tunnel_tube_biome",

-- Used for making lines of dripstone
local np_cracks = {
	offset = 0,
	scale = 1,
	spread = {x = 20, y = 20, z = 20},
	seed = 5717,
	octaves = 3,
	persist = 0.63,
	lacunarity = 2.0,
}

local Set = function(list)
	local set = {}
    for _, l in ipairs(list) do set[l] = true end
	return set
end
local dry_biomes = Set{"dfcaverns_level2_dry_biome", "dfcaverns_level2_black_cap_biome"}

local decorate_level_2 = function(minp, maxp, seed, vm, node_arrays, area, data)
	local biomemap = minetest.get_mapgen_object("biomemap")
	local data_param2 = df_caverns.data_param2
	vm:get_param2_data(data_param2)
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, np_cracks)
	
	---------------------------------------------------------
	-- Cavern floors
	
	for _, vi in pairs(node_arrays.cavern_floor_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		local abs_cracks = math.abs(nvals_cracks[index2d])
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		
		if biome_name == "dfcaverns_level2_tower_cap_biome" then
			df_caverns.tower_cap_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level2_fungiwood_biome" then
			df_caverns.fungiwood_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level2_flooded_biome" then
			df_caverns.flooded_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level2_dry_biome" then
			df_caverns.dry_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level2_black_cap_biome" then
			df_caverns.black_cap_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level2_goblin_cap_biome" then
			df_caverns.goblin_cap_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)			
		elseif biome_name == "dfcaverns_level2_spore_tree_biome" then
			df_caverns.spore_tree_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)			
		elseif biome_name == "dfcaverns_level2_tunnel_tube_biome" then
			df_caverns.tunnel_tube_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		end
	end

	--------------------------------------
	-- Cavern ceilings
	
	for _, vi in pairs(node_arrays.cavern_ceiling_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		local abs_cracks = math.abs(nvals_cracks[index2d])
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		
		local biome_name
		if biome then
			biome_name = biome.name
		end

				
		if biome_name == "dfcaverns_level2_tower_cap_biome" or
			biome_name == "dfcaverns_level2_fungiwood_biome" or
			biome_name == "dfcaverns_level2_goblin_cap_biome" or
			biome_name == "dfcaverns_level2_spore_tree_biome" or
			biome_name == "dfcaverns_level2_tunnel_tube_biome" then
			
			df_caverns.glow_worm_cavern_ceiling(abs_cracks, vert_rand, vi, area, data, data_param2)
		
		elseif biome_name == "dfcaverns_level2_black_cap_biome" then
			if abs_cracks < 0.1 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
			end	
			if math.random() < 0.25 then
				data[vi] = c_stone_with_coal
			end

		elseif biome_name == "dfcaverns_level2_flooded_biome" then
			if abs_cracks < 0.1 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
			end

		elseif biome_name == "dfcaverns_level2_dry_biome" then
			if abs_cracks < 0.1 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
			end
			
			local y = area:position(vi).y
			local y_proportional = (y - df_caverns.config.level1_min) / (df_caverns.config.level2_min - df_caverns.config.level1_min)
			minetest.debug(y_proportional)
			
			if abs_cracks * y_proportional > 0.3 and math.random() < 0.005 * y_proportional then
				df_mapitems.place_big_crystal_cluster(area, data, data_param2, vi, math.random(0,1), true)
			end
			
		end
	end
	
	----------------------------------------------
	-- Tunnel floors
	
	for _, vi in pairs(node_arrays.tunnel_floor_nodes) do
		df_caverns.basic_tunnel_floor(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level2_flooded_biome", dry_biomes)
	end
	
	------------------------------------------------------
	-- Tunnel ceiling
	
	for _, vi in pairs(node_arrays.tunnel_ceiling_nodes) do
		df_caverns.basic_tunnel_ceiling(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level2_flooded_biome", dry_biomes)
	end
	
	------------------------------------------------------
	-- Warren ceiling

	for _, vi in pairs(node_arrays.warren_ceiling_nodes) do
		df_caverns.basic_tunnel_ceiling(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level2_flooded_biome", dry_biomes)
	end

	----------------------------------------------
	-- Warren floors
	
	for _, vi in pairs(node_arrays.warren_floor_nodes) do
		df_caverns.basic_tunnel_floor(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level2_flooded_biome", dry_biomes)
	end
	
	----------------------------------------------
	-- Column material override for dry biome
	
	for _, vi in pairs(node_arrays.column_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		if biome and (biome.name == "dfcaverns_level2_dry_biome" or biome.name == "dfcaverns_level2_black_cap_biome") then
			data[vi] = c_dry_flowstone
		end
	end

	vm:set_param2_data(data_param2)
end



subterrane.register_layer({
	y_max = df_caverns.config.level1_min,
	y_min = df_caverns.config.level2_min,
	cave_threshold = df_caverns.config.cavern_threshold,
	perlin_cave = perlin_cave,
	perlin_wave = perlin_wave,
	solidify_lava = true,
	columns = {
		maximum_radius = 15,
		minimum_radius = 4,
		node = c_wet_flowstone,
		weight = 0.25,
		maximum_count = 50,
		minimum_count = 5,
	},
	decorate = decorate_level_2,
})


-------------------------------------------------------------------------------------------

minetest.register_biome({
	name = "dfcaverns_level2_flooded_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 50,
	humidity_point = 90,
})

minetest.register_biome({
	name = "dfcaverns_level2_tower_cap_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 0,
	humidity_point = 40,
})

minetest.register_biome({
	name = "dfcaverns_level2_fungiwood_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 100,
	humidity_point = 60,
})

minetest.register_biome({
	name = "dfcaverns_level2_goblin_cap_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 20,
	humidity_point = 60,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_goblin_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_spore_tree_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 60,
	humidity_point = 60,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_spore_tree_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_tunnel_tube_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 80,
	humidity_point = 40,
	_subterrane_ceiling_decor = level_2_moist_ceiling,
	_subterrane_floor_decor = level_2_tunnel_tube_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_black_cap_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 50,
	humidity_point = 20,
	_subterrane_ceiling_decor = level_2_black_cap_ceiling,
	_subterrane_floor_decor = level_2_black_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_column_node = c_dry_flowstone,
	_subterrane_cave_floor_decor = level_2_cave_floor,
	_subterrane_cave_ceiling_decor = level_2_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level2_dry_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 50,
	humidity_point = 15,
})

