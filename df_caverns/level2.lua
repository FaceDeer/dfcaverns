local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_dirt = minetest.get_content_id("default:dirt")
local c_dirt_moss = minetest.get_content_id("df_mapitems:dirt_with_cave_moss")

local c_wet_flowstone = minetest.get_content_id("df_mapitems:wet_flowstone")
local c_dry_flowstone = minetest.get_content_id("df_mapitems:dry_flowstone")

local c_sweet_pod = minetest.get_content_id("df_farming:sweet_pod_6") -- param2 = 0
local c_plump_helmet = minetest.get_content_id("df_farming:plump_helmet_4") -- param2 = 0-3
local c_pig_tail = minetest.get_content_id("df_farming:pig_tail_8") -- param2 = 3
local c_cave_wheat = minetest.get_content_id("df_farming:cave_wheat_8") -- param2 = 3
local c_dead_fungus = minetest.get_content_id("df_farming:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("df_farming:cavern_fungi") -- param2 = 0

local subsea_level = df_caverns.config.level2_min - (df_caverns.config.level2_min - df_caverns.config.level1_min) * 0.33
local flooding_threshold = math.min(df_caverns.config.tunnel_flooding_threshold, df_caverns.config.cavern_threshold)

local goblin_cap_shrublist = {c_plump_helmet, c_plump_helmet, c_dead_fungus, c_cavern_fungi}
local tunnel_tube_shrublist = {c_sweet_pod, c_cave_wheat, c_cave_wheat, c_dead_fungus, c_cavern_fungi}
local spore_tree_shrublist = {c_pig_tail, c_pig_tail, c_cave_wheat, c_dead_fungus, c_cavern_fungi}

local goblin_cap_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end
		if math.random() < 0.1 then
			df_caverns.place_shrub(data, vi+ystride, data_param2, goblin_cap_shrublist)
		elseif math.random() < 0.015 then
			df_trees.spawn_goblin_cap_vm(vi, area, data)
		end
	end

end

local spore_tree_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)			
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end
		if math.random() < 0.1 then
			df_caverns.place_shrub(data, vi+ystride, data_param2, spore_tree_shrublist)
		elseif math.random() < 0.05 then
			df_trees.spawn_spore_tree_vm(vi+ystride, area, data)
		end
	end
end


local tunnel_tube_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end
		if math.random() < 0.1 then
			df_caverns.place_shrub(data, vi+ystride, data_param2, tunnel_tube_shrublist)
		elseif math.random() < 0.05 then
			df_trees.spawn_tunnel_tube_vm(vi+ystride, area, data, data_param2, nil, nil) -- not sure why those nils are needed, but without them this method call occasionally spontaneously passes garbage values in for those parameters
		end
	end
end


local decorate_level_2 = function(minp, maxp, seed, vm, node_arrays, area, data)
	math.randomseed(minp.x + minp.y*2^8 + minp.z*2^16 + seed) -- make decorations consistent between runs

	local biomemap = minetest.get_mapgen_object("biomemap")
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
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		local abs_cracks = math.abs(nvals_cracks[index2d])
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		
		if minp.y < subsea_level and area:get_y(vi) < subsea_level and nvals_cave[cave_area:transform(area, vi)] < 0 then
			-- underwater floor
			df_caverns.flooded_cavern_floor(abs_cracks, vert_rand, vi, area, data)
		elseif biome_name == "dfcaverns_level2_barren_biome" then
			df_caverns.dry_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level2_goblin_cap_biome" then
			goblin_cap_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)			
		elseif biome_name == "dfcaverns_level2_spore_tree_biome" then
			spore_tree_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)			
		elseif biome_name == "dfcaverns_level2_tunnel_tube_biome" then
			tunnel_tube_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
		end
	end

	--------------------------------------
	-- Cavern ceilings
	
	for _, vi in ipairs(node_arrays.cavern_ceiling_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		local abs_cracks = math.abs(nvals_cracks[index2d])
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		local negative_zone = nvals_cave[cave_area:transform(area, vi)] < 0
		if negative_zone and minp.y < subsea_level and area:get_y(vi) < subsea_level then
			-- underwater ceiling, do nothing
		elseif biome_name == "dfcaverns_level2_goblin_cap_biome" or
				biome_name == "dfcaverns_level2_spore_tree_biome" or
				biome_name == "dfcaverns_level2_tunnel_tube_biome" then
			df_caverns.glow_worm_cavern_ceiling(abs_cracks, vert_rand, vi, area, data, data_param2)
		elseif biome_name == "dfcaverns_level2_barren_biome" then
			if negative_zone then
				-- wet barren
				if abs_cracks < 0.1 then
					df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
				end
			else
				-- dry barren
				if abs_cracks < 0.075 then
					df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
				end
				local y = area:get_y(vi)
				local y_proportional = (y - df_caverns.config.level1_min) / (df_caverns.config.level2_min - df_caverns.config.level1_min)
				if abs_cracks * y_proportional > 0.3 and math.random() < 0.005 * y_proportional then
					df_mapitems.place_big_crystal_cluster(area, data, data_param2, vi, math.random(0,1), true)
				end
			end			
		end
	end
	
	----------------------------------------------
	-- Tunnel floors
	
	for _, vi in ipairs(node_arrays.tunnel_floor_nodes) do
		local biome = mapgen_helper.get_biome_def_i(biomemap, minp, maxp, area, vi) or {}
		local negative_zone = nvals_cave[cave_area:transform(area, vi)] < 0
		if not (negative_zone and minp.y < subsea_level and area:get_y(vi) < subsea_level) then
			if negative_zone or biome.name ~= "dfcaverns_level1_barren_biome" then		
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
		local biome, cracks, vert_rand = df_caverns.get_decoration_node_data(minp, maxp, area, vi, biomemap, nvals_cracks)
		local abs_cracks = math.abs(cracks)
		local negative_zone = nvals_cave[cave_area:transform(area, vi)] < 0
		if not (negative_zone and minp.y < subsea_level and area:get_y(vi) < subsea_level) then
			if negative_zone or biome.name ~= "dfcaverns_level1_barren_biome" then		
				-- we're in flooded areas or are not barren
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, true)
			else
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, false)
			end
		else
			-- air pockets
			local ystride = area.ystride
			if cracks > 0.6 and data[vi-ystride] == c_water then
				data[vi-ystride] = c_air
				if cracks > 0.8 and data[vi-ystride*2] == c_water then
					data[vi-ystride*2] = c_air
				end
			end			
		end
	end

	----------------------------------------------
	-- Warren floors
	
	for _, vi in ipairs(node_arrays.warren_floor_nodes) do
		local biome = mapgen_helper.get_biome_def_i(biomemap, minp, maxp, area, vi) or {}
		local negative_zone = nvals_cave[cave_area:transform(area, vi)] < 0
		if not (negative_zone and minp.y < subsea_level and area:get_y(vi) < subsea_level) then
			if negative_zone or biome.name ~= "dfcaverns_level1_barren_biome" then		
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
		local biome = mapgen_helper.get_biome_def_i(biomemap, minp, maxp, area, vi) or {}
		local negative_zone = nvals_cave[cave_area:transform(area, vi)] < 0
		if not (negative_zone and minp.y < subsea_level and area:get_y(vi) < subsea_level) then
			if negative_zone or biome.name ~= "dfcaverns_level1_barren_biome" then		
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
		local biome = mapgen_helper.get_biome_def_i(biomemap, minp, maxp, area, vi) or {}
		local dry = (biome.name == "dfcaverns_level2_barren_biome") and (nvals_cave[cave_area:transform(area, vi)] > 0)
		if dry and data[vi] == c_wet_flowstone then
			data[vi] = c_dry_flowstone
		end
	end

	vm:set_param2_data(data_param2)
end


subterrane.register_layer({
	y_max = df_caverns.config.level1_min,
	y_min = df_caverns.config.level2_min,
	cave_threshold = df_caverns.config.cavern_threshold,
	boundary_blend_range = 64, -- range near ymin and ymax over which caves diminish to nothing
	perlin_cave = df_caverns.perlin_cave,
	perlin_wave = df_caverns.perlin_wave,
	solidify_lava = true,
	columns = {
		maximum_radius = 15,
		minimum_radius = 4,
		node = "df_mapitems:wet_flowstone",
		weight = 0.25,
		maximum_count = 50,
		minimum_count = 5,
	},
	decorate = decorate_level_2,
	warren_region_variability_threshold = 0.33,
	double_frequency = true,
})


-------------------------------------------------------------------------------------------

minetest.register_biome({
	name = "dfcaverns_level2_barren_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 50,
	humidity_point = 15,
})

minetest.register_biome({
	name = "dfcaverns_level2_goblin_cap_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 20,
	humidity_point = 60,
})

minetest.register_biome({
	name = "dfcaverns_level2_spore_tree_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 60,
	humidity_point = 60,
})

minetest.register_biome({
	name = "dfcaverns_level2_tunnel_tube_biome",
	y_min = df_caverns.config.level2_min,
	y_max = df_caverns.config.level1_min,
	heat_point = 80,
	humidity_point = 40,
})
