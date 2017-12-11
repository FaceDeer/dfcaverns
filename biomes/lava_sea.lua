local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_cobble = minetest.get_content_id("default:cobble")
local c_dirt = minetest.get_content_id("default:dirt")
local c_sand = minetest.get_content_id("default:sand")
local c_lava = minetest.get_content_id("default:lava_source")

local c_dirt_moss = minetest.get_content_id("dfcaverns:dirt_with_cave_moss")
local c_cobble_fungus = minetest.get_content_id("dfcaverns:cobble_with_floor_fungus")
local c_dead_fungus = minetest.get_content_id("dfcaverns:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("dfcaverns:cavern_fungi") -- param2 = 0

-------------------------------------------------------------------------------------------

local lava_sea_biome_def = {
	name = "dfcaverns_lava_sea",
	y_min = dfcaverns.config.lava_sea_min,
	y_max = dfcaverns.config.level3_min,
	heat_point = 50,
	humidity_point = 50,
}

if not dfcaverns.config.bottom_sea_contains_lava then
	lava_sea_biome_def._subterrane_mitigate_lava = true
end

minetest.register_biome(lava_sea_biome_def)

local c_sea
if dfcaverns.config.bottom_sea_contains_lava then
	c_sea = c_lava
else
	c_sea = c_water
end

local airspace = 256

local data = {}

minetest.register_on_generated(function(minp, maxp, seed)
	--if out of range of cave definition limits, abort
	if minp.y > dfcaverns.config.level3_min - airspace or maxp.y < dfcaverns.config.lava_sea_min then
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
					data[vi] = c_sea
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