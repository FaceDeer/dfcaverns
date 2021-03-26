local data = {}

local maxy = tonumber(minetest.settings:get("chasms_maxy")) or -50
local miny = tonumber(minetest.settings:get("chasms_miny")) or -2500
local falloff = tonumber(minetest.settings:get("chasms_falloff")) or 100

local chasms_threshold = tonumber(minetest.settings:get("chasms_threshold")) or 0.9
local np_chasms_default = {
	offset = 0,
	scale = 1,
	spread = {x = 50, y = 1000, z = 3000},
	seed = 94586,
	octaves = 2,
	persist = 0.63,
	lacunarity = 2.0,
}
local np_chasms = minetest.settings:get_np_group("chasms_params") or np_chasms_default
-- For some reason, these numbers are returned as strings by get_np_group.
local tonumberize_params = function(params)
	params.scale = tonumber(params.scale)
	params.lacunarity = tonumber(params.lacunarity)
	params.spread.x = tonumber(params.spread.x)
	params.spread.y = tonumber(params.spread.y)
	params.spread.z = tonumber(params.spread.z)
	params.offset = tonumber(params.offset)
	params.persistence = tonumber(params.persistence)
end
tonumberize_params(np_chasms)
local nobj_chasm
local chasm_data = {}

local waver_strength = 8
local waver_vector = {x=waver_strength, y=0, z=0}
local np_waver = {
	offset = 0,
	scale = waver_strength,
	spread = {x = 50, y = 50, z = 50},
	seed = 49585,
	octaves = 2,
	persist = 0.63,
	lacunarity = 2.0,
}
local nobj_waver
local waver_data = {}

local minfalloff = miny + falloff
local maxfalloff = maxy - falloff
local get_intensity = function(y)
	if y < miny or y > maxy then
		return 0
	end
	if y <= maxfalloff and y >= minfalloff then
		return 1
	end
	if y < minfalloff then
		return (y-miny)/falloff
	end
--	if y > maxfalloff then
	return (maxy-y)/falloff
--	end
end

local c_air = minetest.get_content_id("air")

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y >= maxy or maxp.y <= miny then
		return
	end
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	vm:get_data(data)

	nobj_chasm = nobj_chasm or minetest.get_perlin_map(np_chasms, {x = emax.x - emin.x + 1 + waver_strength*2, y = emax.y - emin.y + 1, z = emax.z - emin.z + 1})
	nobj_chasm:get_3d_map_flat(vector.subtract(emin, waver_vector), chasm_data)

	nobj_waver = nobj_waver or minetest.get_perlin_map(np_waver, {x = emax.x - emin.x + 1, y = emax.y - emin.y + 1, z = emax.z - emin.z + 1})
	nobj_waver:get_3d_map_flat(emin, waver_data)

	local chasm_area = VoxelArea:new{MinEdge = vector.subtract(emin, waver_vector), MaxEdge = vector.add(emax, waver_vector)}
	local data_area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}

--	local count = {}

	for i, x, y, z in data_area:iterp_xyz(minp, maxp) do
		local waver = math.min(math.max(math.floor(waver_data[i]+0.5), -waver_strength), waver_strength)
--		count[waver] = (count[waver] or 0) + 1
		local intensity = get_intensity(y)
		if chasm_data[chasm_area:index(x+waver, y, z)]*intensity > chasms_threshold then
			data[i] = c_air
		end
	end
	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map()
	
--	minetest.debug(dump(count))
end)
