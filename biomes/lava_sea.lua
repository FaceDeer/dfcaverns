local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_cobble = minetest.get_content_id("default:cobble")
local c_dirt = minetest.get_content_id("default:dirt")
local c_sand = minetest.get_content_id("default:sand")
local c_lava = minetest.get_content_id("default:lava_source")
local c_meseore = minetest.get_content_id("default:stone_with_mese")
local c_mesecry = minetest.get_content_id("dfcaverns:glow_mese")

-------------------------------------------------------------------------------------------

local mese_crystal_ceiling = function(area, data, ai, vi, bi)
	if math.random() < 0.025 then
		if math.random() < 0.25 then
			subterrane:giant_stalactite(ai, area, data, 6, 13, c_meseore, c_meseore, c_mesecry)
		else
			data[vi] = c_meseore
			if math.random() < 0.25 then
				data[bi] = c_mesecry
			end
		end		
	end
end

local mese_ore_ceiling = function(area, data, ai, vi, bi)
	if math.random() < 0.025 then
		data[vi] = c_meseore
		if math.random() < 0.25 then
			data[bi] = c_mesecry
		end
	end
end

local mese_ore_floor = function(area, data, ai, vi, bi)
	if math.random() < 0.01 then
		data[vi] = c_meseore
		if math.random() < 0.25 then
			data[ai] = c_mesecry
		end
	end
end


local lava_sea_crystal_biome_def = {
	name = "dfcaverns_lava_sea_with_mese_crystal",
	y_min = dfcaverns.config.lava_sea_min,
	y_max = dfcaverns.config.lava_sea_max,
	heat_point = 60,
	humidity_point = 30,
	_subterrane_ceiling_decor = mese_crystal_ceiling,
	_subterrane_floor_decor = mese_ore_floor,
}

local lava_sea_mese_biome_def = {
	name = "dfcaverns_lava_sea_with_mese",
	y_min = dfcaverns.config.lava_sea_min,
	y_max = dfcaverns.config.lava_sea_max,
	heat_point = 50,
	humidity_point = 40,
	_subterrane_ceiling_decor = mese_ore_ceiling,
}

local lava_sea_barren_biome_def = {
	name = "dfcaverns_lava_sea",
	y_min = dfcaverns.config.lava_sea_min,
	y_max = dfcaverns.config.lava_sea_max,
	heat_point = 30,
	humidity_point = 50,
}


minetest.register_biome(lava_sea_crystal_biome_def)
minetest.register_biome(lava_sea_mese_biome_def)
minetest.register_biome(lava_sea_barren_biome_def)

local airspace = (dfcaverns.config.lava_sea_max - dfcaverns.config.lava_sea_min) / 2.75
local lava_sea_level = dfcaverns.config.lava_sea_max - airspace

local data = {}
local lavasurface_buffer = {}

local lavasurface_noise

local lavasurface_noise_params = {
	offset = 0,
	scale = 2,
	spread = {x=20, y=20, z=20},
	seed = 5033,
	octaves = 3,
	persist = 0.6
}

minetest.register_on_generated(function(minp, maxp, seed)
	--if out of range of cave definition limits, abort
	if minp.y > lava_sea_level or maxp.y < dfcaverns.config.lava_sea_min then
		return
	end
	
	if not lavasurface_noise then
		local sidelen = maxp.x - minp.x + 1 --length of a mapblock
		local chunk_lengths = {x = sidelen, y = sidelen, z = sidelen} --table of chunk edges
		lavasurface_noise = minetest.get_perlin_map(lavasurface_noise_params, chunk_lengths)
	end
	local nvals_lavasurface = lavasurface_noise:get2dMap({x=minp.x, y=minp.z}, lavasurface_buffer)

	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	vm:get_data(data)
	
	local minx = minp.x-1
	local minz = minp.z-1
	
	for vi, x, y, z in area:iterp_xyz(minp, maxp) do
		local lavaheight = nvals_lavasurface[x-minx][z-minz]
		if y < lava_sea_level + lavaheight then
			if data[vi] == c_air or data[vi] == c_water then
				data[vi] = c_lava
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
end)