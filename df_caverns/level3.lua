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
local c_sand = minetest.get_content_id("default:desert_sand")
local c_stone_with_coal = minetest.get_content_id("default:stone_with_coal")

local c_silver_sand = minetest.get_content_id("default:silver_sand")
local c_snow = minetest.get_content_id("default:snow")
local c_ice = minetest.get_content_id("default:ice")

local c_dirt_moss = minetest.get_content_id("df_mapitems:dirt_with_cave_moss")
local c_cobble_fungus_fine = minetest.get_content_id("df_mapitems:cobble_with_floor_fungus_fine")

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

local subsea_level = (df_caverns.config.level2_min - df_caverns.config.level3_min) * 0.3 + df_caverns.config.level3_min
local flooded_biomes = df_caverns.config.flooded_biomes

-- name = "dfcaverns_level3_black_cap_biome",
-- name = "dfcaverns_level3_dry_biome",
-- name = "dfcaverns_level3_flooded_biome",
-- name = "dfcaverns_level3_goblin_cap_biome",
-- name = "dfcaverns_level3_spore_tree_biome",
-- name = "dfcaverns_level3_tunnel_tube_biome",
-- name = "dfcaverns_level3_blood_thorn_biome",
-- name = "dfcaverns_level3_nether_cap_biome",



local Set = function(list)
	local set = {}
    for _, l in ipairs(list) do set[l] = true end
	return set
end
local dry_biomes = Set{"dfcaverns_level3_dry_biome", "dfcaverns_level3_black_cap_biome", "dfcaverns_level3_blood_thorn_biome"}

local decorate_level_3 = function(minp, maxp, seed, vm, node_arrays, area, data)
	local biomemap = minetest.get_mapgen_object("biomemap")
	local data_param2 = df_caverns.data_param2
	vm:get_param2_data(data_param2)
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, df_caverns.np_cracks)
	
	---------------------------------------------------------
	-- Cavern floors
	
	for _, vi in pairs(node_arrays.cavern_floor_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		local cracks = nvals_cracks[index2d]
		local abs_cracks = math.abs(cracks)
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		
		local biome_name
		if biome then
			biome_name = biome.name
		end
	
		if biome_name == "dfcaverns_level3_flooded_biome" then
			df_caverns.flooded_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level3_dry_biome" then
		
			if abs_cracks < 0.075 then
				df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
			elseif abs_cracks > 0.3 and math.random() < 0.005 then
				df_mapitems.place_big_crystal_cluster(area, data, data_param2, vi+area.ystride,  math.random(0,2), false)
			end
			
		elseif biome_name == "dfcaverns_level3_black_cap_biome" then
			df_caverns.black_cap_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level3_goblin_cap_biome" then
			df_caverns.goblin_cap_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)			
		elseif biome_name == "dfcaverns_level3_spore_tree_biome" then
			df_caverns.spore_tree_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)			
		elseif biome_name == "dfcaverns_level3_tunnel_tube_biome" then
			df_caverns.tunnel_tube_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level3_blood_thorn_biome" then
			df_caverns.blood_thorn_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)		
		elseif biome_name == "dfcaverns_level3_nether_cap_biome" then
			df_caverns.nether_cap_cavern_floor(cracks, abs_cracks, vert_rand, vi, area, data, data_param2)
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
				
		if biome_name == "dfcaverns_level3_goblin_cap_biome" or
			biome_name == "dfcaverns_level3_spore_tree_biome" or
			biome_name == "dfcaverns_level3_tunnel_tube_biome" then
			
			df_caverns.glow_worm_cavern_ceiling(abs_cracks, vert_rand, vi, area, data, data_param2)
		
		elseif biome_name == "dfcaverns_level3_black_cap_biome" then
			if abs_cracks < 0.1 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
			end	
			if math.random() < 0.25 then
				data[vi] = c_stone_with_coal
			end

		elseif biome_name == "dfcaverns_level3_flooded_biome" then
			if abs_cracks < 0.1 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
			end

		elseif biome_name == "dfcaverns_level3_dry_biome" then
			if abs_cracks < 0.1 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
			end
			if abs_cracks > 0.3 and math.random() < 0.005 then
				df_mapitems.place_big_crystal_cluster(area, data, data_param2, vi, math.random(0,3), true)
			end

		elseif biome_name == "dfcaverns_level3_blood_thorn_biome" then
			if abs_cracks < 0.075 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
			end	

		elseif biome_name == "dfcaverns_level3_nether_cap_biome" then
			local ystride = area.ystride
			if abs_cracks < 0.1 then
				if vert_rand < 0.01 then
					subterrane.big_stalactite(vi-ystride, area, data, 6, 15, c_ice, c_ice, c_ice)
				else
					local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
					local height = math.floor(abs_cracks * 50)
					if vert_rand > 0.5 then
						subterrane.stalactite(vi-ystride, area, data, data_param2, param2, height, df_mapitems.icicle_ids)
					else
						subterrane.stalactite(vi-ystride, area, data, data_param2, param2, height*0.5, df_mapitems.dry_stalagmite_ids)
					end
				end
			end
		end
	end
	
	----------------------------------------------
	-- Tunnel floors
	
	for _, vi in pairs(node_arrays.tunnel_floor_nodes) do
		df_caverns.basic_tunnel_floor(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level3_flooded_biome", dry_biomes)
	end
	
	------------------------------------------------------
	-- Tunnel ceiling
	
	for _, vi in pairs(node_arrays.tunnel_ceiling_nodes) do
		df_caverns.basic_tunnel_ceiling(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level3_flooded_biome", dry_biomes)
	end
	
	------------------------------------------------------
	-- Warren ceiling

	for _, vi in pairs(node_arrays.warren_ceiling_nodes) do
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		if biome_name ==  "dfcaverns_level3_nether_cap_biome" then
			local cracks = nvals_cracks[index2d]
			local abs_cracks = math.abs(cracks)
			local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
			local ystride = area.ystride
			if abs_cracks < 0.15 then
				if vert_rand < 0.004 then
					subterrane.big_stalactite(vi-ystride, area, data, 6, 15, c_ice, c_ice, c_ice)
				else
					local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
					local height = abs_cracks * 50
					if vert_rand > 0.5 then
						subterrane.stalactite(vi-ystride, area, data, data_param2, param2, math.floor(height), df_mapitems.icicle_ids)
					else
						subterrane.stalactite(vi-ystride, area, data, data_param2, param2, math.floor(height*0.5), df_mapitems.dry_stalagmite_ids)
					end
				end
			end
		else
			df_caverns.basic_tunnel_ceiling(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level3_flooded_biome", dry_biomes)
		end
	end

	----------------------------------------------
	-- Warren floors
	
	for _, vi in pairs(node_arrays.warren_floor_nodes) do
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		if biome_name ==  "dfcaverns_level3_nether_cap_biome" then
			local cracks = nvals_cracks[index2d]
			local abs_cracks = math.abs(cracks)
			local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
			local ystride = area.ystride
			if abs_cracks < 0.15 then
				if vert_rand < 0.004 then
					subterrane.big_stalagmite(vi+ystride, area, data, 6, 15, c_ice, c_ice, c_ice)
				else
					local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
					local height =abs_cracks * 50
					if vert_rand > 0.5 then
						subterrane.stalagmite(vi+ystride, area, data, data_param2, param2, math.floor(height), df_mapitems.icicle_ids)
					else
						subterrane.stalagmite(vi+ystride, area, data, data_param2, param2, math.floor(height*0.5), df_mapitems.dry_stalagmite_ids)
					end
				end
			elseif cracks > 0.4 then
				data[vi + ystride] = c_ice
				if cracks > 0.6 then
					data[vi + 2*ystride] = c_ice
				end
			end
		else
			df_caverns.basic_tunnel_floor(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level3_flooded_biome", dry_biomes)
		end
	end
	
	----------------------------------------------
	-- Column material override for dry biome
	
	for _, vi in pairs(node_arrays.column_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		if biome and (biome.name == "dfcaverns_level3_dry_biome" or biome.name == "dfcaverns_level3_black_cap_biome") then
			data[vi] = c_dry_flowstone
		elseif biome and biome.name == "dfcaverns_level3_nether_cap_biome" then
			data[vi] = c_ice
		end
	end

	vm:set_param2_data(data_param2)
end

-- Layer 3
subterrane.register_layer({
	y_max = df_caverns.config.level2_min,
	y_min = df_caverns.config.level3_min,
	cave_threshold = df_caverns.config.cavern_threshold,
	perlin_cave = df_caverns.perlin_cave,
	perlin_wave = df_caverns.perlin_wave,
	solidify_lava = true,
	columns = {
		maximum_radius = 20,
		minimum_radius = 5,
		node = c_wet_flowstone,
		weight = 0.25,
		maximum_count = 50,
		minimum_count = 10,
	},
	decorate = decorate_level_3,
})


-------------------------------------------------------------------------------------------

minetest.register_biome({
	name = "dfcaverns_level3_flooded_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 50,
	humidity_point = 90,
})

minetest.register_biome({
	name = "dfcaverns_level3_blood_thorn_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 10,
	humidity_point = 30,
})

minetest.register_biome({
	name = "dfcaverns_level3_nether_cap_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 90,
	humidity_point = 50,
})

minetest.register_biome({
	name = "dfcaverns_level3_goblin_cap_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 20,
	humidity_point = 60,
})

minetest.register_biome({
	name = "dfcaverns_level3_spore_tree_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 60,
	humidity_point = 60,
})

minetest.register_biome({
	name = "dfcaverns_level3_tunnel_tube_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 60,
	humidity_point = 40,
})

minetest.register_biome({
	name = "dfcaverns_level3_black_cap_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 50,
	humidity_point = 15,
})

minetest.register_biome({
	name = "dfcaverns_level3_dry_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 50,
	humidity_point = 10,
})
