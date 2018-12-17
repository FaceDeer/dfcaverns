if not df_caverns.config.enable_lava_sea then
	return
end

local c_air = minetest.get_content_id("air")
local c_lava = minetest.get_content_id("default:lava_source")
local c_meseore = minetest.get_content_id("default:stone_with_mese")
local c_mesecry = minetest.get_content_id("df_mapitems:glow_mese")
local c_obsidian = minetest.get_content_id("default:obsidian")

-------------------------------------------------------------------------------------------

local perlin_cave = {
	offset = 0,
	scale = 1,
	spread = {x=100, y=100, z=100},
	seed = -400000000089,
	octaves = 3,
	persist = 0.67
}

-- large-scale rise and fall
local perlin_wave = {
	offset = 0,
	scale = 1,
	spread = {x=1000, y=1000, z=1000},
	seed = -4000089,
	octaves = 3,
	persist = 0.67
}

local median = df_caverns.config.lava_sea_level
local floor_mult = 60
local floor_displace = -25
local ceiling_mult = -40
local ceiling_displace = 15
local wave_mult = 10

local y_max = median + 2*wave_mult + -2*ceiling_mult + ceiling_displace
local y_min = median - 2*wave_mult - 2*floor_mult + floor_displace

minetest.register_on_generated(function(minp, maxp, seed)
	--if out of range of cave definition limits, abort
	if minp.y > y_max or maxp.y < y_min then
		return
	end

	local t_start = os.clock()

	local vm, data, area = mapgen_helper.mapgen_vm_data()
	local heatmap = minetest.get_mapgen_object("heatmap")
	
	local nvals_cave = mapgen_helper.perlin2d("df_caverns:underworld", minp, maxp, perlin_cave)
	local nvals_wave = mapgen_helper.perlin2d("df_caverns:underworld_wave", minp, maxp, perlin_wave)
	local nvals_lavasurface = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, df_caverns.np_cracks)
	
	for vi, x, y, z in area:iterp_yxz(minp, maxp) do
		local index2d = mapgen_helper.index2d(minp, maxp, x, z)

		local abs_cave = math.abs(nvals_cave[index2d]) -- range is from 0 to approximately 2, with 0 being connected and 2s being islands
		local wave = nvals_wave[index2d] * wave_mult
		local lava = nvals_lavasurface[index2d]
		
		local floor_height = math.floor(abs_cave * floor_mult + floor_displace + median + wave)
		local ceiling_height = math.floor(abs_cave * ceiling_mult + median + ceiling_displace + wave)
		local lava_height = math.floor(median + lava * 2)
		
		if y >= floor_height - 2 and y >= ceiling_height and y < ceiling_height + 2 and y <= lava_height + 2 and not mapgen_helper.buildable_to(data[vi]) then
			data[vi] = c_obsidian -- obsidian ceiling
		elseif y > floor_height and y < ceiling_height then
			if y > lava_height then
				data[vi] = c_air
			else
				data[vi] = c_lava
			end
		elseif y > floor_height - 5 and y < ceiling_height and y <= lava_height + 2 and not mapgen_helper.buildable_to(data[vi]) then
			data[vi] = c_obsidian -- thick obsidian floor
		elseif y < lava_height and data[vi] == c_air then
			data[vi] = c_lava
		end
	end

	-- decoration loop. TODO: only need to do a 2-dimensional run
	for vi, x, y, z in area:iterp_yxz(minp, maxp) do
		local index2d = mapgen_helper.index2d(minp, maxp, x, z)
		local rand = math.random()
		local mese_intensity = heatmap[index2d] * rand * rand
		
		local abs_cave = math.abs(nvals_cave[index2d]) -- range is from 0 to approximately 2, with 0 being connected and 2s being islands
		local wave = nvals_wave[index2d] * wave_mult
		local lava = nvals_lavasurface[index2d]
		
		local floor_height = math.floor(abs_cave * floor_mult + floor_displace + median + wave)
		local ceiling_height = math.floor(abs_cave * ceiling_mult + median + ceiling_displace + wave)
		local lava_height = math.floor(median + lava * 2)
		
		if mese_intensity > 80 and y > lava_height + 1 and y == ceiling_height and y > floor_height + 1 and not mapgen_helper.buildable_to(data[vi]) then
			-- decorate ceiling
			data[vi] = c_meseore
			if mese_intensity > 95 and mese_intensity < 105 then
				data[vi-area.ystride] = c_mesecry
			elseif mese_intensity > 105 then
				subterrane.big_stalactite(vi, area, data, 6, 13, c_meseore, c_meseore, c_mesecry)
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
		minetest.log("info", "[df_caverns lava sea] "..chunk_generation_time.." ms") --tell people how long
	else
		minetest.log("warning", "[df_caverns lava sea] took "..chunk_generation_time.." ms to generate map block "
			.. minetest.pos_to_string(minp) .. minetest.pos_to_string(maxp))
	end
end)