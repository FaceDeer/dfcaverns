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
local c_desert_sand = minetest.get_content_id("default:desert_sand")
local c_stone_with_coal = minetest.get_content_id("default:stone_with_coal")

local c_silver_sand = minetest.get_content_id("default:silver_sand")
local c_snow = minetest.get_content_id("default:snow")
local c_ice = minetest.get_content_id("default:ice")

local c_oil = minetest.get_content_id("oil:oil_source")

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

local subsea_level = df_caverns.config.level3_min - (df_caverns.config.level3_min - df_caverns.config.level2_min) * 0.33

local black_cap_shrublist = {c_quarry_bush, c_dead_fungus, c_dead_fungus}
local nether_cap_shrublist = {c_dimple_cup, c_dead_fungus, c_dead_fungus, c_dead_fungus, c_cavern_fungi}
local blood_thorn_shrublist = {c_sweet_pod, c_sweet_pod, c_dead_fungus, c_dead_fungus, c_dead_fungus, c_cavern_fungi}

local black_cap_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	if math.random() < 0.25 then
		data[vi] = c_stone_with_coal
	else
		data[vi] = c_cobble_fungus
	end
	
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
	elseif abs_cracks < 0.15 and math.random() < 0.3 then
		df_trees.spawn_torchspine_vm(vi+area.ystride, area, data, data_param2)
	else
		if math.random() < 0.05 then
			df_caverns.place_shrub(data, vi+area.ystride, data_param2, black_cap_shrublist)
		elseif math.random() < 0.01 and abs_cracks > 0.25 then
			df_trees.spawn_black_cap_vm(vi, area, data)
		end
	end
end

local nether_cap_cavern_floor = function(cracks, abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		if vert_rand < 0.004 then
			subterrane.big_stalagmite(vi+ystride, area, data, 6, 15, c_ice, c_ice, c_ice)
		else
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = abs_cracks * 50
			if vert_rand > 0.5 then
				subterrane.stalagmite(vi+ystride, area, data, data_param2, param2, math.floor(height), df_mapitems.icicle_ids)
			else
				subterrane.stalagmite(vi+ystride, area, data, data_param2, param2, math.floor(height*0.5), df_mapitems.dry_stalagmite_ids)
			end
		end
	end
	
	if cracks < -0.3 then
		data[vi] = c_silver_sand
		if  math.random() < 0.025 then
			df_trees.spawn_nether_cap_vm(vi+ystride, area, data)
		elseif math.random() < 0.05 then
			df_caverns.place_shrub(data, vi+ystride, data_param2, nether_cap_shrublist)
		elseif cracks < -0.4 and cracks > -0.6 then
			data[vi + ystride] = c_snow
		end
	elseif cracks > 0.1 then
		if math.random() < 0.002 then
			df_trees.spawn_nether_cap_vm(vi+ystride, area, data)
		else
			data[vi] = c_ice
		end
		if cracks > 0.4 then
			data[vi + ystride] = c_ice
			if cracks > 0.6 then
				data[vi + 2*ystride] = c_ice
			end
		end
	end	
end

local blood_thorn_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	if abs_cracks < 0.075 then
		if vert_rand < 0.004 then
			subterrane.big_stalagmite(vi+area.ystride, area, data, 6, 15, c_dry_flowstone, c_dry_flowstone, c_dry_flowstone)
		else
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = math.floor(abs_cracks * 66)
			subterrane.stalagmite(vi+area.ystride, area, data, data_param2, param2, height, df_mapitems.dry_stalagmite_ids)
		end
	elseif math.random() > abs_cracks + 0.66 then
		df_trees.spawn_blood_thorn_vm(vi+area.ystride, area, data, data_param2)
		data[vi] = c_desert_sand
	else
		if math.random() < 0.1 then
			df_caverns.place_shrub(data, vi+area.ystride, data_param2, blood_thorn_shrublist)
			data[vi] = c_desert_sand
		elseif math.random() > 0.25 then
			data[vi] = c_desert_sand
		else
			data[vi] = c_cobble_fungus_fine
		end
	end
end


local decorate_level_3 = function(minp, maxp, seed, vm, node_arrays, area, data)
	local biomemap = minetest.get_mapgen_object("biomemap")
	local data_param2 = df_caverns.data_param2
	vm:get_param2_data(data_param2)
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, df_caverns.np_cracks)
	local nvals_cave = node_arrays.nvals_cave
	local cave_area = node_arrays.cave_area
	
	-- Partly fill flooded caverns and warrens
	if minp.y <= subsea_level then
		for vi in area:iterp(minp, maxp) do
			local y = area:get_y(vi)
			if y <= subsea_level and nvals_cave[cave_area:transform(area, vi)] < -0.15 then
				if data[vi] == c_air and y <= subsea_level then
					data[vi] = c_water
				end
				
				local biome = mapgen_helper.get_biome_def_i(biomemap, minp, maxp, area, vi)
				local biome_name
				if biome then
					biome_name = biome.name
				end
				
				if biome_name == "dfcaverns_level3_black_cap_biome" then
					-- oil slick
					if y == subsea_level and data[vi] == c_water then
						data[vi] = c_oil
					end
				elseif biome_name == "dfcaverns_level3_bloodnether_biome" then
					-- floating ice
					if y <= subsea_level and y > subsea_level - 3 and data[vi] == c_water then
						data[vi] = c_ice
					end				
				end
			end
		end
	end
	
	---------------------------------------------------------
	-- Cavern floors
	
	for _, vi in ipairs(node_arrays.cavern_floor_nodes) do
		local biome, cracks, vert_rand = df_caverns.get_decoration_node_data(minp, maxp, area, vi, biomemap, nvals_cracks)
		local abs_cracks = math.abs(cracks)
		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		local negative_zone = nvals_cave[cave_area:transform(area, vi)] < 0

		if negative_zone and minp.y < subsea_level and area:get_y(vi) < subsea_level then
			-- underwater floor
			df_caverns.flooded_cavern_floor(abs_cracks, vert_rand, vi, area, data) -- TODO maybe something with gravel instead of dirt?
		elseif biome_name == "dfcaverns_level3_barren_biome" then
			if negative_zone then
				-- wet zone floor
				df_caverns.dry_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)
			else
				-- dry zone floor, add crystals
				if abs_cracks < 0.075 then
					df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
				elseif abs_cracks > 0.3 and math.random() < 0.005 then
					df_mapitems.place_big_crystal_cluster(area, data, data_param2, vi+area.ystride,  math.random(0,2), false)
				end
			end
		elseif biome_name == "dfcaverns_level3_black_cap_biome" then
			black_cap_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)			
		elseif biome_name == "dfcaverns_level3_bloodnether_biome" then
			if negative_zone then
				nether_cap_cavern_floor(cracks, abs_cracks, vert_rand, vi, area, data, data_param2)				
			else
				blood_thorn_cavern_floor(abs_cracks, vert_rand, vi, area, data, data_param2)		
			end
		end
	end
	
	--------------------------------------
	-- Cavern ceilings

	for _, vi in ipairs(node_arrays.cavern_ceiling_nodes) do
		local biome, cracks, vert_rand = df_caverns.get_decoration_node_data(minp, maxp, area, vi, biomemap, nvals_cracks)
		local abs_cracks = math.abs(cracks)
		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		local negative_zone = nvals_cave[cave_area:transform(area, vi)] < 0

		if negative_zone and minp.y < subsea_level and area:get_y(vi) < subsea_level then
			-- underwater ceiling, do nothing

		elseif biome_name == "dfcaverns_level3_black_cap_biome" then
			if abs_cracks < 0.1 then
				df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
			end	
			if math.random() < 0.25 then
				data[vi] = c_stone_with_coal
			end

		elseif biome_name == "dfcaverns_level3_barren_biome" then
			if negative_zone then
				-- wet zone ceiling
				if abs_cracks < 0.1 then
					df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
				end
			else
				-- dry zone ceiling, add crystals
				if abs_cracks < 0.1 then
					df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
				end
				if abs_cracks > 0.3 and math.random() < 0.005 then
					df_mapitems.place_big_crystal_cluster(area, data, data_param2, vi, math.random(0,3), true)
				end
			end

		elseif biome_name == "dfcaverns_level3_bloodnether_biome" then
			if negative_zone then
				--Nethercap ceiling
				local ystride = area.ystride
				if abs_cracks < 0.1 then
					if vert_rand < 0.01 then
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
				-- bloodthorn ceiling
				if abs_cracks < 0.075 then
					df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
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
			if negative_zone or biome.name ~= "dfcaverns_level3_barren_biome" then		
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
		local biome, cracks, vert_rand = df_caverns.get_decoration_node_data(minp, maxp, area, vi, biomemap, nvals_cracks) -- TODO: don't need all of these
		local abs_cracks = math.abs(cracks)
		local negative_zone = nvals_cave[cave_area:transform(area, vi)] < 0
		if not (negative_zone and minp.y < subsea_level and area:get_y(vi) < subsea_level) then
			if negative_zone then		
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, true)
			else
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, false)
			end
		else
			-- air pockets
			local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
			local cracks = nvals_cracks[index2d]
			local ystride = area.ystride
			if cracks > 0.6 and data[vi-ystride] == c_water then
				data[vi-ystride] = c_air
				if cracks > 0.8 and data[vi-ystride*2] == c_water then
					data[vi-ystride*2] = c_air
				end
			end			
		end
	end

	
	------------------------------------------------------
	-- Warren ceiling

	for _, vi in ipairs(node_arrays.warren_ceiling_nodes) do
		local biome = mapgen_helper.get_biome_def_i(biomemap, minp, maxp, area, vi) or {}
		local negative_zone = nvals_cave[cave_area:transform(area, vi)] < 0
		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		
		if negative_zone and minp.y < subsea_level and area:get_y(vi) < subsea_level then
			-- underwater ceiling, do nothing
		elseif biome_name == "dfcaverns_level3_bloodnether_biome" and node_arrays.contains_negative_zone then
			-- Nethercap warrens
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
			if negative_zone then
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, true)
			else
				df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, false)
			end
		end
	end

	----------------------------------------------
	-- Warren floors
	
	for _, vi in ipairs(node_arrays.warren_floor_nodes) do
		local biome = mapgen_helper.get_biome_def_i(biomemap, minp, maxp, area, vi) or {}		
		local biome_name
		if biome then
			biome_name = biome.name
		end
		
		if minp.y < subsea_level and area:get_y(vi) < subsea_level and nvals_cave[cave_area:transform(area, vi)] < 0 then
			-- underwater floor, do nothing
		elseif biome_name == "dfcaverns_level3_bloodnether_cap_biome" then
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
			df_caverns.tunnel_floor(minp, maxp, area, vi, nvals_cracks, data, data_param2, false)
		end
	end
	
	----------------------------------------------
	-- Column material override for dry biome
	
	for _, vi in ipairs(node_arrays.column_nodes) do
		local biome = mapgen_helper.get_biome_def_i(biomemap, minp, maxp, area, vi) or {}
		if biome.name == "dfcaverns_level3_bloodnether_biome" then
			if data[vi] == c_wet_flowstone then
				local dry = nvals_cave[cave_area:transform(area, vi)] > 0
				if dry then
					data[vi] = c_dry_flowstone -- bloodthorn
				else
					if area:get_y(vi) >= subsea_level then
						data[vi] = c_ice
					else
						data[vi] = c_water -- ice columns shouldn't extend below the surface of the water. There should probably be a bulge below, though. Not sure best way to implement that.
					end
				end
			end
		end
	end

	vm:set_param2_data(data_param2)
end

-- Layer 3
subterrane.register_layer({
	y_max = df_caverns.config.level2_min,
	y_min = df_caverns.config.level3_min,
	cave_threshold = df_caverns.config.cavern_threshold,
	boundary_blend_range = 64, -- range near ymin and ymax over which caves diminish to nothing
	perlin_cave = df_caverns.perlin_cave,
	perlin_wave = df_caverns.perlin_wave,
	solidify_lava = true,
	columns = {
		maximum_radius = 20,
		minimum_radius = 5,
		node = "df_mapitems:wet_flowstone",
		weight = 0.25,
		maximum_count = 50,
		minimum_count = 10,
	},
	decorate = decorate_level_3,
	warren_region_variability_threshold = 0.33,
	double_frequency = true,
})

-------------------------------------------------------------------------------------------

minetest.register_biome({
	name = "dfcaverns_level3_barren_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 50,
	humidity_point = 10,
})

minetest.register_biome({
	name = "dfcaverns_level3_bloodnether_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 80,
	humidity_point = 50,
})

minetest.register_biome({
	name = "dfcaverns_level3_black_cap_biome",
	y_min = df_caverns.config.sunless_sea_level,
	y_max = df_caverns.config.level2_min,
	heat_point = 20,
	humidity_point = 50,
})
