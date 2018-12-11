local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_dirt = minetest.get_content_id("default:dirt")
local c_sand = minetest.get_content_id("default:sand")
local c_wet_flowstone = minetest.get_content_id("df_mapitems:wet_flowstone")

------------------------------------------------------------------------------------------

local perlin_cave_rivers = {
	offset = 0,
	scale = 1,
	spread = {x=400, y=400, z=400},
	seed = -400000000089,
	octaves = 3,
	persist = 0.67,
	eased = false,
}

-- large-scale rise and fall to make the seam between roof and floor less razor-flat
local perlin_wave_rivers = {
	offset = 0,
	scale = 1,
	spread = {x=800, y=800, z=800},
	seed = -4000089,
	octaves = 3,
	persist = 0.67,
}

local sea_level = df_caverns.config.level3_min - (df_caverns.config.level3_min - df_caverns.config.sunless_sea_min) * 0.5

local floor_mult = 100
local floor_displace = -10
local ceiling_mult = -200
local ceiling_displace = 20
local wave_mult = 10
local ripple_mult = 15
local y_max_river = sea_level + 2*wave_mult + ceiling_displace 
local y_min_river = sea_level - 2*wave_mult + floor_displace

minetest.debug(y_max_river)
minetest.debug(y_min_river)

--y_max_river = df_caverns.config.level3_min
--y_min_river = df_caverns.config.sunless_sea_min

local decorate_sunless_sea = function(minp, maxp, seed, vm, node_arrays, area, data)
	local heatmap = minetest.get_mapgen_object("heatmap")
	local data_param2 = df_caverns.data_param2
	vm:get_param2_data(data_param2)
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, df_caverns.np_cracks)

	local minp_below = minp.y <= sea_level
	local maxp_above = maxp.y > sea_level
	
	local nvals_cave = mapgen_helper.perlin2d("df_caverns:sunless_sea", minp, maxp, perlin_cave_rivers) --cave noise for structure
	local nvals_wave = mapgen_helper.perlin2d("df_caverns:sunless_sea_wave", minp, maxp, perlin_wave_rivers) --cave noise for structure
	
	-- creates "river" caverns
	for vi, x, y, z in area:iterp_xyz(minp, maxp) do
		if mapgen_helper.is_ground_content(data[vi]) then		
			if y < y_max_river and y > y_min_river then
				local index2d = mapgen_helper.index2d(minp, maxp, x, z)
				local abs_cave = math.abs(nvals_cave[index2d])
				local wave = nvals_wave[index2d] * wave_mult
				
				local ripple = nvals_cracks[index2d] * ((y - sea_level) / (y_max_river - sea_level)) * ripple_mult

				-- above floor and below ceiling
				local floor_height = math.floor(abs_cave * floor_mult + sea_level + floor_displace + wave)
				local ceiling_height = math.floor(abs_cave * ceiling_mult + sea_level + ceiling_displace + wave + ripple)
				if y > floor_height and y < ceiling_height and data[vi] ~= c_wet_flowstone then
					data[vi] = c_air
				end
			end
			-- convert all air below sea level into water
			if y <= sea_level and data[vi] == c_air then
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
subterrane.register_layer({
	y_max = df_caverns.config.level3_min,
	y_min = df_caverns.config.sunless_sea_min,
	cave_threshold = df_caverns.config.lava_sea_threshold,
	perlin_cave = df_caverns.perlin_cave_lava,
	perlin_wave = df_caverns.perlin_wave_lava,
	columns = {
		maximum_radius = 20,
		minimum_radius = 5,
		node = c_wet_flowstone,
		weight = 0.5,
		maximum_count = 100,
		minimum_count = 25,
	},
	decorate = decorate_sunless_sea,
})



minetest.register_biome({
	name = "dfcaverns_sunless_sea_barren",
	y_min = df_caverns.config.sunless_sea_min,
	y_max = df_caverns.config.sunless_sea_level,
	heat_point = 80,
	humidity_point = 10,
})

minetest.register_biome({
	name = "dfcaverns_sunless_sea_snareweed",
	y_min = df_caverns.config.sunless_sea_min,
	y_max = df_caverns.config.sunless_sea_level,
	heat_point = 80,
	humidity_point = 90,
})

minetest.register_biome({
	name = "dfcaverns_sunless_sea_coral",
	y_min = df_caverns.config.sunless_sea_min,
	y_max = df_caverns.config.sunless_sea_level,
	heat_point = 0,
	humidity_point = 50,
})
