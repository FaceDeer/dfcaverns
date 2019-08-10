if not df_caverns.config.enable_primordial or not minetest.get_modpath("df_primordial_items") then
	return
end

-----------------------------------------------------------------------------------------

local perlin_cave_primordial = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale, y=df_caverns.config.vertical_cavern_scale*0.5, z=df_caverns.config.horizontal_cavern_scale},
	seed = 14055553,
	octaves = 3,
	persist = 0.67
}

local perlin_wave_primordial = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale, y=df_caverns.config.vertical_cavern_scale*0.5, z=df_caverns.config.horizontal_cavern_scale},
	seed = 923444,
	octaves = 6,
	persist = 0.63
}


local mushroom_cavern_floor = function(abs_cracks, vi, area, data, data_param2)
	local ystride = area.ystride
end

local c_orb = minetest.get_content_id("df_primordial_items:glow_orb_hanging")
local c_mycelial_dirt = minetest.get_content_id("df_primordial_items:dirt_with_mycelium")
local mushroom_cavern_ceiling = function(abs_cracks, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.4 then
		data[vi] = c_mycelial_dirt
		if abs_cracks < 0.3 then
			if math.random() < 0.2 then
				data[vi-ystride] = c_orb
			elseif math.random() < 0.03 then
				df_primordial_items.spawn_ceiling_spire_vm(vi, area, data)
			end
		end
	end
end
local mushroom_warren_ceiling = function(abs_cracks, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.3 then
		data[vi] = c_mycelial_dirt
		if abs_cracks < 0.2 then
			if math.random() < 0.2 then
				data[vi-ystride] = c_orb
			end
		end
	end
end

local jungle_cavern_floor = function(abs_cracks, vi, area, data, data_param2)
	local ystride = area.ystride
end

local jungle_cavern_ceiling = function(abs_cracks, vi, area, data, data_param2)
end
local jungle_warren_ceiling = function(abs_cracks, vi, area, data, data_param2)
end

local decorate_primordial = function(minp, maxp, seed, vm, node_arrays, area, data)
	math.randomseed(minp.x + minp.y*2^8 + minp.z*2^16 + seed) -- make decorations consistent between runs

	local data_param2 = df_caverns.data_param2
	vm:get_param2_data(data_param2)
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, df_caverns.np_cracks)
	local cave_area = node_arrays.cave_area
	local nvals_cave = node_arrays.nvals_cave
	
	---------------------------------------------------------
	-- Cavern floors
	
	for _, vi in ipairs(node_arrays.cavern_floor_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local cracks = nvals_cracks[index2d]
		local abs_cracks = math.abs(cracks)
		local jungle = nvals_cave[cave_area:transform(area, vi)] < 0
		
		if jungle then
			jungle_cavern_floor(abs_cracks, vi, area, data, data_param2)
		else
			mushroom_cavern_floor(abs_cracks, vi, area, data, data_param2)
		end
	end
	
	--------------------------------------
	-- Cavern ceilings

	for _, vi in ipairs(node_arrays.cavern_ceiling_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local cracks = nvals_cracks[index2d]
		local abs_cracks = math.abs(cracks)
		local jungle = nvals_cave[cave_area:transform(area, vi)] < 0

--		if jungle then
--			jungle_cavern_ceiling(abs_cracks, vi, area, data, data_param2)
--		else
			mushroom_cavern_ceiling(abs_cracks, vi, area, data, data_param2)
--		end


	end
	
		----------------------------------------------
	-- Tunnel floors
	
	for _, vi in ipairs(node_arrays.tunnel_floor_nodes) do
	end
	
	------------------------------------------------------
	-- Tunnel ceiling
	
	for _, vi in ipairs(node_arrays.tunnel_ceiling_nodes) do
	end
	
	------------------------------------------------------
	-- Warren ceiling

	for _, vi in ipairs(node_arrays.warren_ceiling_nodes) do
		local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
		local cracks = nvals_cracks[index2d]
		local abs_cracks = math.abs(cracks)
		local jungle = nvals_cave[cave_area:transform(area, vi)] < 0
		
--		if jungle then
--			jungle_warren_ceiling(abs_cracks, vi, area, data, data_param2)
--		else
			mushroom_warren_ceiling(abs_cracks, vi, area, data, data_param2)
--		end

	end

	----------------------------------------------
	-- Warren floors
	
	for _, vi in ipairs(node_arrays.warren_floor_nodes) do
	end

	-- columns
	for _, vi in ipairs(node_arrays.column_nodes) do
		local jungle = nvals_cave[cave_area:transform(area, vi)] < 0
		if jungle then
		end
	end

	vm:set_param2_data(data_param2)
end

--Primordial Caverns
subterrane.register_layer({
	name = "primordial",
	y_max = df_caverns.config.primordial_max,
	y_min = df_caverns.config.primordial_min,
	cave_threshold = df_caverns.config.sunless_sea_threshold, -- Make the caves a bit bigger than above
	perlin_cave = perlin_cave_primordial,
	perlin_wave = perlin_wave_primordial,
	solidify_lava = true,
	columns = {
		maximum_radius = 20,
		minimum_radius = 5,
		node = "df_mapitems:wet_flowstone",
		weight = 0.5,
		maximum_count = 60,
		minimum_count = 10,
	},
	decorate = decorate_primordial,
	double_frequency = true,
})
