local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_dirt = minetest.get_content_id("default:dirt")
local c_sand = minetest.get_content_id("default:sand")

-------------------------------------------------------------------------------------------

local sea_level = dfcaverns.config.sunless_sea_level

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
		dfcaverns.place_snareweed_patch(area, data, bi, param2_data, 6)
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
		dfcaverns.spawn_cave_coral(area, data, vi, iterations)
	end
end

local sunless_sea_coral_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	local coral_rand = subterrane:vertically_consistent_random(vi, area)
	if coral_rand < 0.01 then
		local iterations = math.ceil(coral_rand / 0.01 * 6)
		dfcaverns.spawn_coral_pile(area, data, vi, iterations)
	end
end

minetest.register_biome({
	name = "dfcaverns_sunless_sea_barren",
	y_min = dfcaverns.config.sunless_sea_min,
	y_max = dfcaverns.config.sunless_sea_level,
	heat_point = 80,
	humidity_point = 10,
	_subterrane_fill_node = c_water,
	_subterrane_cave_fill_node = c_air,
	_subterrane_mitigate_lava = true,
	_subterrane_floor_decor = sunless_sea_barren_floor,
})

minetest.register_biome({
	name = "dfcaverns_sunless_sea_snareweed",
	y_min = dfcaverns.config.sunless_sea_min,
	y_max = dfcaverns.config.sunless_sea_level,
	heat_point = 80,
	humidity_point = 90,
	_subterrane_fill_node = c_water,
	_subterrane_cave_fill_node = c_water,
	_subterrane_mitigate_lava = true,
	_subterrane_floor_decor = sunless_sea_snareweed_floor,
})

minetest.register_biome({
	name = "dfcaverns_sunless_sea_coral",
	y_min = dfcaverns.config.sunless_sea_min,
	y_max = dfcaverns.config.sunless_sea_level,
	heat_point = 0,
	humidity_point = 50,
	_subterrane_fill_node = c_water,
	_subterrane_cave_fill_node = c_water,
	_subterrane_mitigate_lava = true,
	_subterrane_floor_decor = sunless_sea_coral_floor,
	_subterrane_ceiling_decor = sunless_sea_coral_ceiling,
})

local data = {}
minetest.register_on_generated(function(minp, maxp, seed)
	--if out of range of cave definition limits, abort
	if minp.y > dfcaverns.config.sunless_sea_level or maxp.y < dfcaverns.config.sunless_sea_min then
		return
	end
		
	--easy reference to commonly used values
	local t_start = os.clock()
	local x_max = maxp.x
	local y_max = maxp.y
	local z_max = maxp.z
	local x_min = minp.x
	local y_min = minp.y
	local z_min = minp.z
		
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	vm:get_data(data)
		
	for z = z_min, z_max do -- for each xy plane progressing northwards
		for y = y_min, y_max do -- for each x row progressing upwards
			if y <= dfcaverns.config.sunless_sea_level then
				local vi = area:index(x_min, y, z) --current node index
				for x = x_min, x_max do -- for each node do
					if data[vi] == c_air then
						data[vi] = c_water
					end
					vi = vi + 1
				end
			end
		end
	end
		
	--send data back to voxelmanip
	vm:set_data(data)
	--calc lighting
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	--write it to world
	vm:write_to_map()
end)