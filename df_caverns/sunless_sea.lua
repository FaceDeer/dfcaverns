local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_dirt = minetest.get_content_id("default:dirt")
local c_sand = minetest.get_content_id("default:sand")
local c_wet_flowstone = minetest.get_content_id("df_mapitems:wet_flowstone")

-------------------------------------------------------------------------------------------

local sea_level = df_caverns.config.level3_min - (df_caverns.config.level3_min - df_caverns.config.sunless_sea_min) * 0.5

local decorate_sunless_sea = function(minp, maxp, seed, vm, node_arrays, area, data)
	local heatmap = minetest.get_mapgen_object("heatmap")
	local data_param2 = df_caverns.data_param2
	vm:get_param2_data(data_param2)
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, df_caverns.np_cracks)

	local minp_below = minp.y < sea_level
	local maxp_above = maxp.y > sea_level
	
	-- convert all air below sea level into water
	if minp_below then
		for vi in area:iter(minp.x, minp.y, minp.z, maxp.z, math.min(sea_level, maxp.y), maxp.z) do
			if data[vi] == c_air then
				data[vi] = c_water
			end
		end
	end
	
	---------------------------------------------------------
	-- Cavern floors
	
	for _, vi in pairs(node_arrays.cavern_floor_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local heat = heatmap[index2d]
		local cracks = nvals_cracks[index2d]
		local abs_cracks = math.abs(cracks)
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		local y = area:position(vi).y
		
		-- TODO

	end
	
	--------------------------------------
	-- Cavern ceilings

	for _, vi in pairs(node_arrays.cavern_ceiling_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local heat = heatmap[index2d]
		local cracks = nvals_cracks[index2d]
		local abs_cracks = math.abs(cracks)
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		local y = area:position(vi).y
		
		-- TODO

	end
	
		----------------------------------------------
	-- Tunnel floors
	
	for _, vi in pairs(node_arrays.tunnel_floor_nodes) do
		--df_caverns.basic_tunnel_floor(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level3_flooded_biome", dry_biomes)
	end
	
	------------------------------------------------------
	-- Tunnel ceiling
	
	for _, vi in pairs(node_arrays.tunnel_ceiling_nodes) do
		--df_caverns.basic_tunnel_ceiling(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level3_flooded_biome", dry_biomes)
	end
	
	------------------------------------------------------
	-- Warren ceiling

	for _, vi in pairs(node_arrays.warren_ceiling_nodes) do
		--df_caverns.basic_tunnel_ceiling(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level3_flooded_biome", dry_biomes)
	end

	----------------------------------------------
	-- Warren floors
	
	for _, vi in pairs(node_arrays.warren_floor_nodes) do
		--df_caverns.basic_tunnel_floor(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, "dfcaverns_level3_flooded_biome", dry_biomes)
	end
	
	----------------------------------------------
	-- Column material override for dry biome
	
	for _, vi in pairs(node_arrays.column_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local heat = heatmap[index2d]
		local cracks = nvals_cracks[index2d]
		local abs_cracks = math.abs(cracks)
		local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
		

		-- TODO
	end
	
	vm:set_param2_data(data_param2)
end

local sunless_sea_barren_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	data[bi] = c_sand
end

local sunless_sea_snareweed_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	if math.random() < 0.005 then
		df_mapitems.place_snareweed_patch(area, data, bi, param2_data, 6)
	else
		data[bi] = c_dirt
	end
end

local sunless_sea_coral_ceiling = function(area, data, ai, vi, bi, param2_data)
	if data[ai] ~= c_stone then
		return
	end
	local coral_rand = subterrane:vertically_consistent_random(vi, area)
	if coral_rand < 0.01 then
		local iterations = math.ceil(coral_rand / 0.01 * 6)
		df_mapitems.spawn_cave_coral(area, data, vi, iterations)
	end
end

local sunless_sea_coral_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	local coral_rand = subterrane:vertically_consistent_random(vi, area)
	if coral_rand < 0.01 then
		local iterations = math.ceil(coral_rand / 0.01 * 6)
		df_mapitems.spawn_coral_pile(area, data, vi, iterations)
	end
end

--Sunless Sea
--subterrane.register_layer({
--	y_max = df_caverns.config.level3_min,
--	y_min = df_caverns.config.sunless_sea_min,
--	cave_threshold = df_caverns.config.lava_sea_threshold,
--	perlin_cave = df_caverns.perlin_cave_lava,
--	perlin_wave = df_caverns.perlin_wave_lava,
--	columns = {
--		maximum_radius = 25,
--		minimum_radius = 5,
--		node = c_stone,
--		weight = 0.25,
--		maximum_count = 100,
--		minimum_count = 25,
--	},
--	decorate = sunless_sea_decorate,
--})




local perlin_cave = {
	offset = 0,
	scale = 1,
	spread = {x=400, y=400, z=400},
	seed = -400000000089,
	octaves = 3,
	persist = 0.67,
	eased = false,
}

-- large-scale rise and fall to make the seam between roof and floor less razor-flat
local perlin_wave = {
	offset = 0,
	scale = 1,
	spread = {x=1600, y=1600, z=1600},
	seed = -4000089,
	octaves = 3,
	persist = 0.67,
}

local median = sea_level
local floor_mult = 40
local floor_displace = -20
local ceiling_mult = -100
local ceiling_displace = 50
local wave_mult = 10

local y_max = median + 2*wave_mult + ceiling_displace + -2*ceiling_mult
local y_min = median - 2*wave_mult - 2*floor_mult

local column_def = {
	maximum_radius = 10,
	minimum_radius = 4,
	node = c_wet_flowstone,
	weight = 0.25,
	maximum_count = 50,
	minimum_count = 20,
}

minetest.register_on_generated(function(minp, maxp, seed)

	--if out of range of cave definition limits, abort
	if minp.y > y_max or maxp.y < y_min then
		return
	end
	local t_start = os.clock()

	local vm, data, area = mapgen_helper.mapgen_vm_data()
	local nvals_cave = mapgen_helper.perlin2d("df_caverns:sunless_sea", minp, maxp, perlin_cave) --cave noise for structure
	local nvals_wave = mapgen_helper.perlin2d("df_caverns:sunless_sea_wave", minp, maxp, perlin_wave) --cave noise for structure
	
	local column_points = subterrane.get_column_points(minp, maxp, column_def)
	
	for vi, x, y, z in area:iterp_yxz(minp, maxp) do
		local index2d = mapgen_helper.index2d(minp, maxp, x, z)
		local abs_cave = math.abs(nvals_cave[index2d])
				
		local wave = nvals_wave[index2d] * wave_mult
		
		-- above floor and below ceiling
		local floor_height = abs_cave * floor_mult + median + floor_displace + wave 
		local ceiling_height = abs_cave * ceiling_mult + median + ceiling_displace + wave
		if y > floor_height and y < ceiling_height then
			if y > sea_level then
				data[vi] = c_air
			else
				data[vi] = c_water
			end
		end
	end
	
	--send data back to voxelmanip
	vm:set_data(data)
	--calc lighting
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	vm:update_liquids()
	--write it to world
	vm:write_to_map()
	
	local chunk_generation_time = math.ceil((os.clock() - t_start) * 1000) --grab how long it took
	if chunk_generation_time < 1000 then
		minetest.log("info", "[df_caverns underworld] "..chunk_generation_time.." ms") --tell people how long
	else
		minetest.log("warning", "[df_caverns underworld] took "..chunk_generation_time.." ms to generate map block "
			.. minetest.pos_to_string(minp) .. minetest.pos_to_string(maxp))
	end
end)






minetest.register_biome({
	name = "dfcaverns_sunless_sea_barren",
	y_min = df_caverns.config.sunless_sea_min,
	y_max = df_caverns.config.sunless_sea_level,
	heat_point = 80,
	humidity_point = 10,
	_subterrane_fill_node = c_water,
	_subterrane_cave_fill_node = c_air,
	_subterrane_mitigate_lava = true,
	_subterrane_floor_decor = sunless_sea_barren_floor,
})

minetest.register_biome({
	name = "dfcaverns_sunless_sea_snareweed",
	y_min = df_caverns.config.sunless_sea_min,
	y_max = df_caverns.config.sunless_sea_level,
	heat_point = 80,
	humidity_point = 90,
	_subterrane_fill_node = c_water,
	_subterrane_cave_fill_node = c_water,
	_subterrane_mitigate_lava = true,
	_subterrane_floor_decor = sunless_sea_snareweed_floor,
})

minetest.register_biome({
	name = "dfcaverns_sunless_sea_coral",
	y_min = df_caverns.config.sunless_sea_min,
	y_max = df_caverns.config.sunless_sea_level,
	heat_point = 0,
	humidity_point = 50,
	_subterrane_fill_node = c_water,
	_subterrane_cave_fill_node = c_water,
	_subterrane_mitigate_lava = true,
	_subterrane_floor_decor = sunless_sea_coral_floor,
	_subterrane_ceiling_decor = sunless_sea_coral_ceiling,
})
