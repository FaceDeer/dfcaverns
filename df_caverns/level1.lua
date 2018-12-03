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
local flooded_biomes = df_caverns.config.flooded_biomes

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

-- name = "dfcaverns_level1_dry_biome",
-- name = "dfcaverns_level1_flooded_biome",
-- name = "dfcaverns_level1_fungiwood_biome",
-- name = "dfcaverns_level1_fungiwood_flooded_biome",
-- name = "dfcaverns_level1_tower_cap_biome",
-- name = "dfcaverns_level1_tower_cap_flooded_biome",

local data_param2 = {}

local tower_cap_shrublist = {c_plump_helmet, c_plump_helmet, c_pig_tail, c_dead_fungus, c_cavern_fungi}
local fungiwood_shrublist = {c_plump_helmet, c_pig_tail, c_cave_wheat, c_cave_wheat, c_dead_fungus, c_cavern_fungi}

--local c_mese = minetest.get_content_id("default:mese")

local stalagmites = function(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, wet, reverse_sign)
	local flowstone
	local stalagmite_ids
	if wet then
		flowstone = c_wet_flowstone
		stalagmite_ids = df_mapitems.wet_stalagmite_ids
	else
		flowstone = c_dry_flowstone
		stalagmite_ids = df_mapitems.dry_stalagmite_ids	
	end
	
	local height_mult = 1
	if reverse_sign then
		ystride = - ystride
		height_mult = -1
	end		

	if vert_rand < 0.002 then
		if reverse_sign then
			subterrane:giant_stalactite(vi+ystride, area, data, 6, 15, flowstone, flowstone, flowstone)
		else
			subterrane:giant_stalagmite(vi+ystride, area, data, 6, 15, flowstone, flowstone, flowstone)
		end
	else
		local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
		local height = math.floor(abs_cracks * 50)
		subterrane:small_stalagmite(vi+ystride, area, data, data_param2, param2, height*height_mult, stalagmite_ids)
	end
	data[vi] = flowstone
end

local stalactites = function(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, wet)
	stalagmites(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, wet, true)
end

local deep_water = function(cracks, vi, ystride, data)
	local depth = cracks + 1
	vi = vi + ystride
	while depth > 0 and data[vi] == c_air do
		data[vi] = c_water
		vi = vi + ystride
		depth = depth - 1
	end
end

local tunnel_ceiling = function(minp, maxp, area, vi, ystride, biomemap, nvals_cracks, data, data_param2)
	local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
	local biome = mapgen_helper.get_biome_def(biomemap[index2d])
	local abs_cracks = math.abs(nvals_cracks[index2d])
	
	if biome == nil then
		--data[vi] = c_mese
	elseif biome.name == "dfcaverns_level1_flooded_biome" then
	
	elseif biome.name == "dfcaverns_level1_dry_biome" then
		if abs_cracks < 0.025 then
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = math.floor(abs_cracks * 100)
			subterrane:small_stalagmite(vi-ystride, area, data, data_param2, param2, -height, df_mapitems.dry_stalagmite_ids)
		end
	else
		if abs_cracks < 0.05 then
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = math.floor(abs_cracks * 100)
			subterrane:small_stalagmite(vi-ystride, area, data, data_param2, param2, -height, df_mapitems.wet_stalagmite_ids)
			data[vi] = c_wet_flowstone
		end
	end
end

local tunnel_floor = function(minp, maxp, area, vi, ystride, biomemap, nvals_cracks, data, data_param2)
	local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
	local biome = mapgen_helper.get_biome_def(biomemap[index2d])
	local cracks = nvals_cracks[index2d]
	local abs_cracks = math.abs(nvals_cracks[index2d])
	
	if biome == nil then
		--data[vi] = c_mese
	elseif biome.name == "dfcaverns_level1_flooded_biome" then
		if flooded_biomes then
			deep_water(cracks, vi, ystride, data)
		end
	elseif biome.name == "dfcaverns_level1_dry_biome" then
		if abs_cracks < 0.025 then
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = math.floor(abs_cracks * 100)
			subterrane:small_stalagmite(vi+ystride, area, data, data_param2, param2, height, df_mapitems.dry_stalagmite_ids)
		elseif cracks > 0.5 and data[vi-ystride] ~= c_air then
			data[vi] = c_gravel
		end
	else
		if abs_cracks < 0.05 then
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = math.floor(abs_cracks * 100)
			subterrane:small_stalagmite(vi+ystride, area, data, data_param2, param2, height, df_mapitems.wet_stalagmite_ids)
			data[vi] = c_wet_flowstone
		end
	end
end

local decorate_level_1 = function(minp, maxp, seed, vm, node_arrays, area, data)
	local biomemap = minetest.get_mapgen_object("biomemap")
	local ystride = area.ystride
	vm:get_param2_data(data_param2)
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, np_cracks)
	
	---------------------------------------------------------
	-- Cavern floors
	
	for _, vi in pairs(node_arrays.cavern_floor_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		local abs_cracks = math.abs(nvals_cracks[index2d])
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		
		if biome == nil then
			--data[vi] = c_mese
		elseif biome.name == "dfcaverns_level1_tower_cap_biome" or
			biome.name == "dfcaverns_level1_tower_cap_flooded_biome" then

			if abs_cracks < 0.1 then
				stalagmites(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, true)
			elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
				if math.random() < 0.25 then
					data[vi] = c_dirt
				else
					data[vi] = c_dirt_moss
				end
				
				if math.random() < 0.1 then
					df_caverns.place_shrub(data, vi+ystride, data_param2, tower_cap_shrublist)
				elseif math.random() < 0.01 and abs_cracks > 0.25 then
					df_trees.spawn_tower_cap_vm(vi, area, data)
				end
			end			
			
		elseif biome.name == "dfcaverns_level1_fungiwood_biome" or
			biome.name == "dfcaverns_level1_fungiwood_flooded_biome" then

			if abs_cracks < 0.1 then
				stalagmites(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, true)
			elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
				if math.random() < 0.25 then
					data[vi] = c_dirt
				else
					data[vi] = c_dirt_moss
				end
				if math.random() < 0.1 then
					df_caverns.place_shrub(data, vi, data_param2, fungiwood_shrublist)
				elseif math.random() < 0.03 and abs_cracks > 0.35 then
					df_trees.spawn_fungiwood_vm(vi, area, data)
				end
			end
	
		elseif biome.name == "dfcaverns_level1_flooded_biome" then
			if abs_cracks < 0.25 then
				data[vi] = c_mossycobble
			elseif data[vi-ystride] ~= c_air then
				data[vi] = c_dirt
				
				if not flooded_biomes then -- don't put vegetation if the floor's going to be covered in water
					if math.random() < 0.05 then
						data[vi+ystride] = c_dead_fungus
					elseif math.random() < 0.05 then
						data[vi+ystride] = c_cavern_fungi
					end
				end
			end
			
			if flooded_biomes then
				-- put in only the large stalagmites that won't get in the way of the water
				if abs_cracks < 0.1 then
					if vert_rand < 0.002 then
						subterrane:giant_stalagmite(vi+ystride, area, data, 6, 15, c_wet_flowstone, c_wet_flowstone, c_wet_flowstone)
					end
				end
				--Cover the floor with a thick layer of water
				deep_water(cracks, vi, ystride, data)
			else
				-- Put in stalagmites and the occasional isolated blob of water.
				if abs_cracks < 0.1 then
					stalagmites(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, true)
				elseif math.random() < 0.001 then
					data[vi+ystride] = c_water
				end
			end
			
		elseif biome.name == "dfcaverns_level1_dry_biome" then
			if abs_cracks < 0.1 then
				stalagmites(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, false)
			elseif abs_cracks < 0.4 then
				data[vi] = c_cobble
			elseif abs_cracks < 0.6 then
				data[vi] = c_cobble_fungus_fine
			else
				data[vi] = c_cobble_fungus
				if math.random() < 0.05 then
					data[vi+ystride] = c_dead_fungus
				end
			end
		end		
	end

	--------------------------------------
	-- Cavern ceilings
	
	for _, vi in pairs(node_arrays.cavern_ceiling_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local biome = mapgen_helper.get_biome_def(biomemap[index2d])
		local abs_cracks = math.abs(nvals_cracks[index2d])
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		
		if biome == nil then
			--data[vi] = c_mese
		elseif biome.name == "dfcaverns_level1_tower_cap_biome" or
			biome.name == "dfcaverns_level1_tower_cap_flooded_biome" or
			biome.name == "dfcaverns_level1_fungiwood_biome" or
			biome.name == "dfcaverns_level1_fungiwood_flooded_biome" then

			if abs_cracks < 0.1 then
				stalactites(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, true)
			elseif abs_cracks < 0.5 and abs_cracks > 0.3 and math.random() < 0.3 then
				df_mapitems.glow_worm_ceiling(area, data, vi-ystride)
			end

		elseif biome.name == "dfcaverns_level1_flooded_biome" then
			if abs_cracks < 0.1 then
				stalactites(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, true)
			end

		elseif biome.name == "dfcaverns_level1_dry_biome" then
			if abs_cracks < 0.1 then
				stalactites(abs_cracks, vert_rand, ystride, vi, area, data, data_param2, false)
			end	
		end
	end
	
	----------------------------------------------
	-- Tunnel floors
	
	for _, vi in pairs(node_arrays.tunnel_floor_nodes) do
		tunnel_floor(minp, maxp, area, vi, ystride, biomemap, nvals_cracks, data, data_param2)
	end
	
	------------------------------------------------------
	-- Tunnel ceiling
	
	for _, vi in pairs(node_arrays.tunnel_ceiling_nodes) do
		tunnel_ceiling(minp, maxp, area, vi, ystride, biomemap, nvals_cracks, data, data_param2)
	end
	
	------------------------------------------------------
	-- Warren ceiling

	for _, vi in pairs(node_arrays.warren_ceiling_nodes) do
		tunnel_ceiling(minp, maxp, area, vi, ystride, biomemap, nvals_cracks, data, data_param2)
	end

	----------------------------------------------
	-- Tunnel floors
	
	for _, vi in pairs(node_arrays.warren_floor_nodes) do
		tunnel_floor(minp, maxp, area, vi, ystride, biomemap, nvals_cracks, data, data_param2)
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
		maximum_count = 20,
		minimum_count = 0,
	},
	decorate = decorate_level_1,
})