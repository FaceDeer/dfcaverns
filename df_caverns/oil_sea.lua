if not df_caverns.config.enable_oil_sea then
	return
end

local c_oil = minetest.get_content_id("oil:oil_source")
local c_gas = minetest.get_content_id("oil:gas")
local c_lava = minetest.get_content_id("default:lava_source")
local c_obsidian = minetest.get_content_id("default:obsidian")

-------------------------------------------------------------------------------------------

local perlin_cave = {
	offset = 0,
	scale = 1,
	spread = {x=300, y=300, z=300},
	seed = 6000089,
	octaves = 3,
	persist = 0.67
}

-- large-scale rise and fall
local perlin_wave = {
	offset = 0,
	scale = 1,
	spread = {x=1000, y=1000, z=1000},
	seed = 10089,
	octaves = 3,
	persist = 0.67
}

local median = df_caverns.config.oil_sea_level
local floor_mult = -80
local floor_displace = 60
local ceiling_mult = 40
local ceiling_displace = -30
local wave_mult = 10

local c_lava_set

local y_max = median + 2*wave_mult + 2*ceiling_mult + ceiling_displace
local y_min = median - 2*wave_mult + 2*floor_mult + floor_displace

minetest.register_on_generated(function(minp, maxp, seed)
	--if out of range of cave definition limits, abort
	if minp.y > y_max or maxp.y < y_min then
		return
	end

	local t_start = os.clock()

	local vm, data, area = mapgen_helper.mapgen_vm_data()
	
	local nvals_cave = mapgen_helper.perlin2d("df_caverns:oil_cave", minp, maxp, perlin_cave)
	local nvals_wave = mapgen_helper.perlin2d("df_caverns:oil_wave", minp, maxp, perlin_wave)
	
	if c_lava_set == nil then
		c_lava_set = {}
		for name, def in pairs(minetest.registered_nodes) do
			if def.groups ~= nil and def.groups.lava ~= nil then
				c_lava_set[minetest.get_content_id(name)] = true
			end
		end
	end
	
	for vi, x, y, z in area:iterp_yxz(minp, maxp) do
		local index2d = mapgen_helper.index2d(minp, maxp, x, z)

		local abs_cave = math.abs(nvals_cave[index2d]) -- range is from 0 to approximately 2, with 0 being connected and 2s being islands
		local wave = nvals_wave[index2d] * wave_mult
		
		local floor_height = math.floor(abs_cave * floor_mult + floor_displace + median + wave)
		local ceiling_height = math.floor(abs_cave * ceiling_mult + median + ceiling_displace + wave)
	
		if y > floor_height - 5 and y < ceiling_height + 5 then
			if c_lava_set[data[vi]] then
				data[vi] = c_obsidian
			end
		end
		if y > floor_height and y < ceiling_height then
			if y > median then
				data[vi] = c_gas
			else
				data[vi] = c_oil
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
		minetest.log("info", "[df_caverns] oil sea mapblock generation took "..chunk_generation_time.." ms") --tell people how long
	else
		minetest.log("warning", "[df_caverns] oil sea took "..chunk_generation_time.." ms to generate map block "
			.. minetest.pos_to_string(minp) .. minetest.pos_to_string(maxp))
	end
end)

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "oil:gas_seep",
	wherein        = "default:stone",
	clust_scarcity = 32 * 32 * 32,
	clust_num_ores = 27,
	clust_size     = 6,
	y_max          = df_caverns.config.sunless_sea_min,
	y_min          = y_min,
})