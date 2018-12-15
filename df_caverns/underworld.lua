
local c_slade = minetest.get_content_id("df_mapitems:slade")
local c_air = minetest.get_content_id("air")

local c_glowstone = minetest.get_content_id("df_mapitems:glowstone")

local perlin_cave = {
	offset = 0,
	scale = 1,
	spread = {x=200, y=200, z=200},
	seed = -400000000089,
	octaves = 6,
	persist = 0.67
}

-- large-scale rise and fall to make the seam between stone and slade less razor-flat
local perlin_wave = {
	offset = 0,
	scale = 1,
	spread = {x=1000, y=1000, z=1000},
	seed = -4000089,
	octaves = 3,
	persist = 0.67
}

local median = -4500
local floor_mult = 20
local floor_displace = -10
local ceiling_mult = -40
local ceiling_displace = 20
local wave_mult = 50

local y_max = median + 2*wave_mult + ceiling_displace + -2*ceiling_mult
local y_min = median - 2*wave_mult + floor_displace - 2*floor_mult

minetest.register_on_generated(function(minp, maxp, seed)

	--if out of range of cave definition limits, abort
	if minp.y > y_max or maxp.y < y_min then
		return
	end
	local t_start = os.clock()

	local vm, data, area = mapgen_helper.mapgen_vm_data()
	local nvals_cave = mapgen_helper.perlin2d("df_caverns:underworld", minp, maxp, perlin_cave) --cave noise for structure
	local nvals_wave = mapgen_helper.perlin2d("df_caverns:underworld_wave", minp, maxp, perlin_wave) --cave noise for structure
	
	for vi, x, y, z in area:iterp_yxz(minp, maxp) do
		local index2d = mapgen_helper.index2d(minp, maxp, x, z)
		local abs_cave = math.abs(nvals_cave[index2d]) -- range is from 0 to approximately 2, with 0 being connected and 2s being islands
		local wave = nvals_wave[index2d] * wave_mult
		
		local floor_height = abs_cave * floor_mult + median + floor_displace + wave 
		local ceiling_height = abs_cave * ceiling_mult + median + ceiling_displace + wave
		if y < floor_height then
			data[vi] = c_slade
		elseif y < ceiling_height then
			data[vi] = c_air
		end
	end

	-- TODO don't need to iterate the whole thing for this, just the ceiling nodes.
	for vi, x, y, z in area:iterp_yxz(vector.add(minp,1), vector.subtract(maxp, 1)) do
		local index2d = mapgen_helper.index2d(minp, maxp, x, z)
		local abs_cave = math.abs(nvals_cave[index2d]) -- range is from 0 to approximately 2, with 0 being connected and 2s being islands
		
		local wave = nvals_wave[index2d] * wave_mult
		
		local floor_height = abs_cave * floor_mult + median + floor_displace + wave 
		local ceiling_height = abs_cave * ceiling_mult + median + ceiling_displace + wave
	
		if y == math.floor(ceiling_height) and y > floor_height + 5 and 
			(
				(data[vi-area.ystride + 1] ~= c_air and data[vi-area.ystride - 1] ~= c_air) or
				(data[vi-area.ystride + area.zstride] ~= c_air and data[vi-area.ystride - area.zstride] ~= c_air) or
				(data[vi-area.ystride + 1 + area.zstride] ~= c_air and data[vi-area.ystride - 1 - area.zstride] ~= c_air) or
				(data[vi-area.ystride - 1 + area.zstride] ~= c_air and data[vi-area.ystride + 1 - area.zstride] ~= c_air)
			)
			then
			data[vi] = c_glowstone
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
