local modpath = minetest.get_modpath(minetest.get_current_modname())
local mapgen_test_path = minetest.get_modpath("mapgen_test")
--local S = minetest.get_translator(minetest.get_current_modname())
local c_air = minetest.get_content_id("air")

local c_glow
if minetest.get_modpath("df_underworld_items") then
	c_glow = minetest.get_content_id("df_underworld_items:glowstone")
end

local perlin_params = {
	offset = 0,
	scale = 1,
	spread = {x=1000, y=500, z=1000},
	seed = 501221,
	octaves = 3,
	persist = 0.67
}
local data = {}
local light_data = {}
local light = 15 + (15 * 16)

local max_depth = -5000
local min_depth = -6000

local noise_obj

local block_size = 80
local cube_inside = 1/math.sqrt(3) -- https://www.quora.com/What-is-the-largest-volume-of-a-cube-that-can-be-enclosed-in-a-sphere-of-diameter-2

local get_bubbles = function(pos)
	noise_obj = noise_obj or minetest.get_perlin(perlin_params)
	local bubbles = {}
	local next_seed = math.random(1000000)
	for block_x = -1, 1 do
		for block_y = -1, 1 do
			for block_z = -1, 1 do
				local this_pos = vector.add(pos, {x=block_x*block_size, y=block_y*block_size, z=block_z*block_size})
				math.randomseed(this_pos.x + this_pos.y*8 + this_pos.z*16)
				this_pos.x = this_pos.x + math.floor(math.random()*block_size - block_size/2)
				this_pos.y = this_pos.y + math.floor(math.random()*block_size - block_size/2)
				this_pos.z = this_pos.z + math.floor(math.random()*block_size - block_size/2)
				local noise_val = math.min(noise_obj:get_3d(this_pos), 1.0)
				if noise_val > 0 then
					local radius = noise_val*block_size*math.random()+5
					local y = this_pos.y
					if y + radius < max_depth  and y - radius > min_depth then -- make sure bubbles remain within the layer
						if mapgen_test_path then
							if noise_val < 0.1 then
								mapgen_test.record_first_location("bubble cave sparse", this_pos, "a bubble cave in a sparsely populated region")
							elseif noise_val < 0.55 and noise_val > 0.45 then
								mapgen_test.record_first_location("bubble cave middle", this_pos, "a bubble cave in a middlingly populated region")
							elseif noise_val > 0.9 then
								mapgen_test.record_first_location("bubble cave dense", this_pos, "a bubble cave in a densely populated region")
							end
						end
						table.insert(bubbles, {loc=this_pos, radius=radius})
					end
				end
			end
		end
	end
	math.randomseed(next_seed)
	return bubbles
end


if mapgen_test_path then
	mapgen_test.log_time_settings("bubble_caves")
end

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y > max_depth or maxp.y < min_depth then
		return
	end

	local nearby_bubbles = get_bubbles({x=minp.x+block_size/2, y=minp.y+block_size/2, z=minp.z+block_size/2})
	if not next(nearby_bubbles) then
		return
	end

	if mapgen_test_path then
		mapgen_test.log_time_start("bubble_caves")
	end
	
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	vm:get_data(data)
	vm:set_lighting({day = 0, night = 0})
	vm:get_light_data(light_data)
	
	for vi, x, y, z in area:iterp_xyz(emin, emax) do
		for _, bubble in pairs(nearby_bubbles) do
			if data[vi] ~= c_air then
				local loc = bubble.loc
				local loc_x = loc.x
				local loc_y = loc.y
				local loc_z = loc.z
				local radius = bubble.radius
				-- check outer bounding box first, faster than true distance
				if x <= loc_x + radius and x >= loc_x - radius and y <= loc_y + radius and y >= loc_y - radius and z <= loc_z + radius and z >= loc_z - radius then
					local inner_box = radius * cube_inside
					if (x <= loc_x + inner_box and x >= loc_x - inner_box and y <= loc_y + inner_box and y >= loc_y - inner_box and z <= loc_z + inner_box and z >= loc_z - inner_box)
						or vector.distance({x=x, y=y, z=z}, loc) < radius+math.random()/2 then
						data[vi] = c_air
						light_data[vi] = light
					end
				end
			end
		end
	end
	
	if c_glow then
		for _, bubble in pairs(nearby_bubbles) do
			local loc = bubble.loc
			if area:containsp(loc) then
				local vol = math.floor(bubble.radius / 20)
				if vol > 0 then
					for vi in area:iter(loc.x-vol, loc.y-vol, loc.z-vol, loc.x+vol, loc.y+vol, loc.z+vol) do
						if area:containsi(vi) then
							data[vi] = c_glow
						end
					end
				else
					data[area:indexp(loc)] = c_glow
				end
			end
		end
	end
	
	--send data back to voxelmanip
	vm:set_data(data)
	--calc lighting
	vm:set_light_data(light_data)
	vm:calc_lighting()
	vm:update_liquids()
	--write it to world
	vm:write_to_map()
	
	if mapgen_test_path then
		mapgen_test.log_time_stop("bubble_caves")
	end

end)
