local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_dirt = minetest.get_content_id("default:dirt")
local c_dirt_moss = minetest.get_content_id("df_mapitems:dirt_with_cave_moss")

local c_wet_flowstone = minetest.get_content_id("df_mapitems:wet_flowstone")
local c_dry_flowstone = minetest.get_content_id("df_mapitems:dry_flowstone")

local tower_cap_shrublist
local fungiwood_shrublist

if minetest.get_modpath("df_farming") then
	tower_cap_shrublist = {
		df_farming.spawn_plump_helmet_vm,
		df_farming.spawn_plump_helmet_vm,
		df_farming.spawn_dead_fungus_vm,
		df_farming.spawn_cavern_fungi_vm,
	}
	fungiwood_shrublist = {
		df_farming.spawn_plump_helmet_vm,
		df_farming.spawn_cave_wheat_vm,
		df_farming.spawn_cave_wheat_vm,
		df_farming.spawn_dead_fungus_vm,
		df_farming.spawn_cavern_fungi_vm,
	}
end

local subsea_level = df_caverns.config.level1_min - (df_caverns.config.level1_min - df_caverns.config.ymax) * 0.33
local flooding_threshold = math.min(df_caverns.config.tunnel_flooding_threshold, df_caverns.config.cavern_threshold)

local get_biome = function(heat, humidity)
	if humidity < 23 then -- about 20% of locations fall below this threshold
		return "barren"
	elseif heat < 50 then
		return "towercap"
	else
		return "fungiwood"
	end
end

local tower_cap_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air and data[vi-ystride] ~= c_water then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end

		if math.random() < 0.1 then
			df_caverns.place_shrub(vi+ystride, area, data, data_param2, tower_cap_shrublist)
		elseif math.random() < 0.01 and abs_cracks > 0.25 then
			df_trees.spawn_tower_cap_vm(vi+ystride, area, data)
		end
	end
end

local fungiwood_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air and data[vi-ystride] ~= c_water then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end
		if math.random() < 0.1 then
			df_caverns.place_shrub(vi+ystride, area, data, data_param2, fungiwood_shrublist)
		elseif math.random() < 0.03 and abs_cracks > 0.35 then
			df_trees.spawn_fungiwood_vm(vi+ystride, area, data)
		end
	end
end

local decorate_level_1 = function(minp, maxp, seed, vm, node_arrays, area, data)
	math.randomseed(minp.x + minp.y*2^8 + minp.z*2^16 + seed) -- make decorations consistent between runs

	local heatmap = minetest.get_mapgen_object("heatmap")
	local humiditymap = minetest.get_mapgen_object("humiditymap")
	local data_param2 = df_caverns.data_param2
	vm:get_param2_data(data_param2)
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, df_caverns.np_cracks)
	local nvals_cave = node_arrays.nvals_cave
	local cave_area = node_arrays.cave_area
	
	-- Partly fill flooded caverns and warrens
	if minp.y <= subsea_level then
		for vi in area:iterp(minp, maxp) do
			if data[vi] == c_air and area:get_y(vi) <= subsea_level and nvals_cave[cave_area:transform(area, vi)] < -flooding_threshold then
				data[vi] = c_water
			end
		end
	end

	---------------------------------------------------------
	-- Cavern floors
	
	for _, vi in ipairs(node_arrays.cavern_floor_nodes) do
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome_name = get_biome(heatmap[index2d], humiditymap[index2d])
		local abs_cracks = math.abs(nvals_cracks[index2d])
		local flooded_caverns = nvals_cave[cave_area:transform(area, vi)] < 0 -- this indicates if we're in the "flooded" set of caves or not.
				
		if minp.y < subsea_level and area:get_y(vi) < subsea_level and flooded_caverns then
			-- underwater floor
			df_caverns.flooded_cavern_floor(abs_cracks, vert_rand, vi, area, data)
		elseif biome_name == "towercap" then
			tower_cap_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "fungiwood"  then
			fungiwood_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "barren" then
			if flooded_caverns then
				df_caverns.wet_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
			else
				df_caverns.dry_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
			end
		end		
	end

	--------------------------------------
	-- Cavern ceilings
	
	for _, vi in ipairs(node_arrays.cavern_ceiling_nodes) do
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome_name = get_biome(heatmap[index2d], humiditymap[index2d])
		local abs_cracks = math.abs(nvals_cracks[index2d])
		local flooded_caverns = nvals_cave[cave_area:transform(area, vi)] < 0 -- this indicates if we're in the "flooded" set of caves or not.

		if flooded_caverns and minp.y < subsea_level and area:get_y(vi) < subsea_level then
			-- underwater ceiling, do nothing
		elseif biome_name == "barren" then
			if flooded_caverns then
				-- wet barren
				if abs_cracks < 0.1 then
					df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
				end
			else
				-- dry barren
				if abs_cracks < 0.075 then
					df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
				end
			end
		else -- all the other biomes
			df_caverns.glow_worm_cavern_ceiling(abs_cracks, vert_rand, vi, area, data, data_param2)
		end
	end
	
	----------------------------------------------
	-- Tunnel floors

	for _, vi in ipairs(node_arrays.tunnel_floor_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome_name = get_biome(heatmap[index2d], humiditymap[index2d])
		local flooded_caverns = nvals_cave[cave_area:transform(area, vi)] < 0 -- this indicates if we're in the "flooded" set of caves or not.

		if not (flooded_caverns and minp.y < subsea_level and area:get_y(vi) < subsea_level) then
			if flooded_caverns or biome_name ~= "barren" then		
				-- we're in flooded areas or are not barren
				df_caverns.tunnel_floor(minp, maxp, area, vi, nvals_cracks, data, data_param2, true)
			else
				df_caverns.tunnel_floor(minp, maxp, area, vi, nvals_cracks, data, data_param2, false)
			end
		end
	end
	
	------------------------------------------------------
	-- Tunnel ceiling
	
	for _, vi in ipairs(node_arrays.tunnel_ceiling_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome_name = get_biome(heatmap[index2d], humiditymap[index2d])
		local flooded_caverns = nvals_cave[cave_area:transform(area, vi)] < 0 -- this indicates if we're in the "flooded" set of caves or not.

		if not (flooded_caverns and minp.y < subsea_level and area:get_y(vi) < subsea_level) then
			if flooded_caverns or biome_name ~= "barren" then		
				-- we're in flooded areas or are not barren
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, true)
			else
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, false)
			end
		else
			-- air pockets
			local ystride = area.ystride
			local cracks = nvals_cracks[index2d]
			if cracks > 0.5 and data[vi-ystride] == c_water then
				data[vi-ystride] = c_air
				if cracks > 0.7 and data[vi-ystride*2] == c_water then
					data[vi-ystride*2] = c_air
				end
			end			
		end
	end
	
	----------------------------------------------
	-- Warren floors
	
	for _, vi in ipairs(node_arrays.warren_floor_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome_name = get_biome(heatmap[index2d], humiditymap[index2d])
		local flooded_caverns = nvals_cave[cave_area:transform(area, vi)] < 0 -- this indicates if we're in the "flooded" set of caves or not.

		if not (flooded_caverns and minp.y < subsea_level and area:get_y(vi) < subsea_level) then
			if flooded_caverns or biome_name ~= "barren" then		
				-- we're in flooded areas or are not barren
				df_caverns.tunnel_floor(minp, maxp, area, vi, nvals_cracks, data, data_param2, true)
			else
				df_caverns.tunnel_floor(minp, maxp, area, vi, nvals_cracks, data, data_param2, false)
			end
		end
	end
	
	------------------------------------------------------
	-- Warren ceiling

	for _, vi in ipairs(node_arrays.warren_ceiling_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome_name = get_biome(heatmap[index2d], humiditymap[index2d])
		local flooded_caverns = nvals_cave[cave_area:transform(area, vi)] < 0 -- this indicates if we're in the "flooded" set of caves or not.

		if not (flooded_caverns and minp.y < subsea_level and area:get_y(vi) < subsea_level) then
			if flooded_caverns or biome_name ~= "barren" then		
				-- we're in flooded areas or are not barren
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, true)
			else
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, false)
			end
		end
		-- else air pockets?
	end

	----------------------------------------------
	-- Column material override for dry biome
	
	for _, vi in ipairs(node_arrays.column_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome_name = get_biome(heatmap[index2d], humiditymap[index2d])
		local dry = (biome_name == "barren") and (nvals_cave[cave_area:transform(area, vi)] > 0)

		if dry and data[vi] == c_wet_flowstone then
			data[vi] = c_dry_flowstone
		end
	end

	vm:set_param2_data(data_param2)
end

-------------------------------------------------------------------------------------------

subterrane.register_layer({
	name = "cavern layer 1",
	y_max = df_caverns.config.ymax,
	y_min = df_caverns.config.level1_min,
	cave_threshold = df_caverns.config.cavern_threshold,
	boundary_blend_range = 64, -- range near ymin and ymax over which caves diminish to nothing
	perlin_cave = df_caverns.perlin_cave,
	perlin_wave = df_caverns.perlin_wave,
	solidify_lava = true,
	columns = {
		maximum_radius = 10,
		minimum_radius = 4,
		node = "df_mapitems:wet_flowstone",
		weight = 0.25,
		maximum_count = 50,
		minimum_count = 0,
	},
	decorate = decorate_level_1,
	warren_region_variability_threshold = 0.33,
	double_frequency = true,
})