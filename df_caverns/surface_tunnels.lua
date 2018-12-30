-- surface tunnels

local y_max = -10
local y_min = df_caverns.config.ymax

minetest.register_on_generated(function(minp, maxp, seed)
	--if out of range of cave definition limits, abort
	if minp.y > y_max or maxp.y < y_min then
		return
	end	
	
	local t_start = os.clock()

	local vm, data, data_param2, area = mapgen_helper.mapgen_vm_data_param2()
	local humiditymap = minetest.get_mapgen_object("humiditymap")
	local nvals_cracks = mapgen_helper.perlin2d("df_cavern:cracks", minp, maxp, df_caverns.np_cracks)

	local previous_state = "outside_region"
	local previous_y = minp.y
	
	for vi, x, y, z in area:iterp_yxz(minp, maxp) do
		
		if y < previous_y then
			previous_state = "outside_region"
		end
		previous_y = y
		
		if y < y_max then
			if mapgen_helper.buildable_to(data[vi]) then
				if previous_state == "in_rock" and not mapgen_helper.buildable_to(data[vi-area.ystride]) then
					local index2d = mapgen_helper.index2d(minp, maxp, x, z)
					local humidity = humiditymap[index2d]
					df_caverns.tunnel_floor(minp, maxp, area, vi-area.ystride, nvals_cracks, data, data_param2, humidity > 30)
				end
				previous_state = "in_tunnel"
			else
				if previous_state == "in_tunnel" and not mapgen_helper.buildable_to(data[vi]) then
					local index2d = mapgen_helper.index2d(minp, maxp, x, z)
					local humidity = humiditymap[index2d]
					df_caverns.tunnel_ceiling(minp, maxp, area, vi, nvals_cracks, data, data_param2, humidity > 30)
				end
				previous_state = "in_rock"
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
		minetest.log("info", "[df_caverns surface tunnels] "..chunk_generation_time.." ms") --tell people how long
	else
		minetest.log("warning", "[df_caverns surface tunnels] took "..chunk_generation_time.." ms to generate map block "
			.. minetest.pos_to_string(minp) .. minetest.pos_to_string(maxp))
	end	
	
end)
