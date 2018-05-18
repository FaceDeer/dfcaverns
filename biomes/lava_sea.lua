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

local lava_ceiling = function(area, data, ai, vi, bi)
	if math.random() < 0.005 then
		subterrane:giant_stalactite(ai, area, data, 6, 13, c_meseore, c_meseore, c_mesecry)
	end
end


local lava_sea_biome_def = {
	name = "dfcaverns_lava_sea",
	y_min = dfcaverns.config.lava_sea_min,
	y_max = dfcaverns.config.lava_sea_max,
	heat_point = 50,
	humidity_point = 50,
	_subterrane_ceiling_decor = lava_ceiling,
}

minetest.register_biome(lava_sea_biome_def)

local airspace = (dfcaverns.config.lava_sea_max - dfcaverns.config.lava_sea_min) / 3

local data = {}

minetest.register_on_generated(function(minp, maxp, seed)
	--if out of range of cave definition limits, abort
	if minp.y > dfcaverns.config.lava_sea_max - airspace or maxp.y < dfcaverns.config.lava_sea_min then
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
			local vi = area:index(x_min, y, z) --current node index
			for x = x_min, x_max do -- for each node do
				if data[vi] == c_air or data[vi] == c_water then
					data[vi] = c_lava
				end
				vi = vi + 1
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