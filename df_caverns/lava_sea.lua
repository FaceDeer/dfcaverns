if not df_caverns.config.enable_lava_sea then
	return
end

local c_air = minetest.get_content_id("air")
local c_lava = minetest.get_content_id("default:lava_source")
local c_meseore = minetest.get_content_id("default:stone_with_mese")
local c_mese_crystal = minetest.get_content_id("df_mapitems:mese_crystal")
local c_mese_crystal_block = minetest.get_content_id("df_mapitems:glow_mese")
local c_obsidian = minetest.get_content_id("default:obsidian")

-------------------------------------------------------------------------------------------

local stats = df_caverns.stats

local perlin_cave = {
	offset = 0,
	scale = 1,
	spread = {x=100, y=100, z=100},
	seed = -787324,
	octaves = 3,
	persist = 0.67
}

-- large-scale rise and fall
local perlin_wave = {
	offset = 0,
	scale = 1,
	spread = {x=1000, y=1000, z=1000},
	seed = 256664,
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

stats.lava_sea_blocks = 0
stats.lava_sea_ceiling_ore = 0
stats.lava_sea_ceiling_crystal = 0
stats.lava_sea_ceiling_mese_stalactite = 0

minetest.register_on_generated(function(minp, maxp, seed)
	--if out of range of cave definition limits, abort
	if minp.y > y_max or maxp.y < y_min then
		return
	end
	
	local t_start = os.clock()

	math.randomseed(minp.x + minp.y*2^8 + minp.z*2^16 + seed) -- make decorations consistent between runs
	stats.lava_sea_blocks = stats.lava_sea_blocks + 1
	
	local vm, data, data_param2, area = mapgen_helper.mapgen_vm_data_param2()
	local heatmap = minetest.get_mapgen_object("heatmap")
	
	local nvals_cave = mapgen_helper.perlin2d("df_caverns:lava_cave", minp, maxp, perlin_cave)
	local nvals_wave = mapgen_helper.perlin2d("df_caverns:lava_wave", minp, maxp, perlin_wave)
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

	-- decoration loop.
	for x = minp.x + 1, maxp.x-1 do
		for z = minp.z + 1, maxp.z -1 do
			local index2d = mapgen_helper.index2d(minp, maxp, x, z)
			local rand = math.random()
			local mese_intensity = math.min(heatmap[index2d], 100) * rand
					
			local abs_cave = math.abs(nvals_cave[index2d]) -- range is from 0 to approximately 2, with 0 being connected and 2s being islands
			local wave = nvals_wave[index2d] * wave_mult
			local floor_height = math.floor(abs_cave * floor_mult + floor_displace + median + wave)
			local ceiling_height = math.floor(abs_cave * ceiling_mult + median + ceiling_displace + wave)

			local lava = nvals_lavasurface[index2d]
			local lava_height = math.floor(median + lava * 2)
		
			if mese_intensity > 60 and ceiling_height > lava_height + 1 and ceiling_height > floor_height + 1 and ceiling_height <= maxp.y and ceiling_height >= minp.y then
				local vi = area:index(x, ceiling_height, z)
				if not mapgen_helper.buildable_to(data[vi]) then
					-- decorate ceiling
					if math.random() > 0.25 then
						stats.lava_sea_ceiling_ore = stats.lava_sea_ceiling_ore + 1
						data[vi] = c_meseore
					elseif mese_intensity > 70 and math.random() > 0.25 then
						stats.lava_sea_ceiling_crystal = stats.lava_sea_ceiling_crystal + 1
						local bi = vi-area.ystride
						data[bi] = c_mese_crystal
						data_param2[bi] = math.random(1,4) + 19
					elseif mese_intensity > 80 and math.random() > 0.25 then
						stats.lava_sea_ceiling_mese_stalactite = stats.lava_sea_ceiling_mese_stalactite + 1
						subterrane.big_stalactite(vi, area, data, 6, 13, c_meseore, c_meseore, c_mese_crystal_block)
					end
				end
			end
		end
	end
			
		
	--send data back to voxelmanip
	vm:set_data(data)
	vm:set_param2_data(data_param2)
	--calc lighting
	vm:set_lighting({day = 0, night = 0})
	vm:calc_lighting()
	
	vm:update_liquids()
	--write it to world
	vm:write_to_map()
	
	local chunk_generation_time = math.ceil((os.clock() - t_start) * 1000) --grab how long it took
	if chunk_generation_time < 1000 then
		minetest.log("info", "[df_caverns] lava sea mapblock generation took "..chunk_generation_time.." ms") --tell people how long
	else
		minetest.log("warning", "[df_caverns] lava sea took "..chunk_generation_time.." ms to generate map block "
			.. minetest.pos_to_string(minp) .. minetest.pos_to_string(maxp))
	end
end)