local data = {}

local maxy = tonumber(minetest.settings:get("chasms_maxy")) or -50
local miny = tonumber(minetest.settings:get("chasms_miny")) or -2500
local falloff = tonumber(minetest.settings:get("chasms_falloff")) or 100

local web_probability = 0.1 -- the chance that a given mapblock will have webbing criss-crossing the chasm

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
local c_web

local big_webs_path = minetest.get_modpath("big_webs")
if big_webs_path then
	c_web = minetest.get_content_id("big_webs:webbing")
end

local z_displace = 10000

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y >= maxy or maxp.y <= miny then
		return
	end
	
	-- build a set of web patterns
	local webs
	if big_webs_path then
		local seed = math.random()*10000000
		math.randomseed(minp.y + z_displace*minp.z) -- use consistent seeds across the x axis
		if math.random() < web_probability then
			webs = {}
			for count = 1, math.random(10,30) do
				local width = math.random(5, 20)
				local direction_vertical = math.random() > 0.5
				local web_y = math.random(minp.y+8, maxp.y-8)
				local web_z = math.random(minp.z+8, maxp.z-8)
				for i = -math.floor(width/2), math.ceil(width/2) do
					if direction_vertical then
						webs[(web_y+i) + web_z*z_displace] = true
					else
						webs[web_y + (web_z+i)*z_displace] = true
					end
				end
			end
		end
		math.randomseed(seed)
	end
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	vm:get_data(data)

	nobj_chasm = nobj_chasm or minetest.get_perlin_map(np_chasms, {x = emax.x - emin.x + 1 + waver_strength*2, y = emax.y - emin.y + 1, z = emax.z - emin.z + 1})
	nobj_chasm:get_3d_map_flat(vector.subtract(emin, waver_vector), chasm_data)

	nobj_waver = nobj_waver or minetest.get_perlin_map(np_waver, {x = emax.x - emin.x + 1, y = emax.y - emin.y + 1, z = emax.z - emin.z + 1})
	nobj_waver:get_3d_map_flat(emin, waver_data)

	local chasm_area = VoxelArea:new{MinEdge = vector.subtract(emin, waver_vector), MaxEdge = vector.add(emax, waver_vector)}
	local data_area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}

	for i, x, y, z in data_area:iterp_xyz(emin, emax) do
		local waver = math.min(math.max(math.floor(waver_data[i]+0.5), -waver_strength), waver_strength)
		local intensity = get_intensity(y)
		if chasm_data[chasm_area:index(x+waver, y, z)]*intensity > chasms_threshold then
			if webs then
				if webs[y + z*z_displace] and math.random() < 0.85 then -- random holes in the web
					data[i] = c_web
					minetest.get_node_timer({x=x,y=y,z=z}):start(1) -- this timer will check for unsupported webs
				else
					data[i] = c_air
				end
			else
				data[i] = c_air
			end
		end
	end
	
	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map()
end)
