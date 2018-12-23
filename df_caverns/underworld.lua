if not df_caverns.config.enable_underworld then
	return
end

local c_slade = minetest.get_content_id("df_mapitems:slade")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")

local c_glowstone = minetest.get_content_id("df_mapitems:glowstone")
local c_amethyst = minetest.get_content_id("df_mapitems:glow_amethyst")
local c_pit_plasma = minetest.get_content_id("df_mapitems:pit_plasma")

local MP = minetest.get_modpath(minetest.get_current_modname())
local oubliette_schematic = dofile(MP.."/schematics/oubliette.lua")
local lamppost_schematic = dofile(MP.."/schematics/lamppost.lua")
local small_slab_schematic = dofile(MP.."/schematics/small_slab.lua")
local small_building_schematic = dofile(MP.."/schematics/small_building.lua")
local medium_building_schematic = dofile(MP.."/schematics/medium_building.lua")

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

-- building zones
local perlin_zone = {
	offset = 0,
	scale = 1,
	spread = {x=500, y=500, z=500},
	seed = 199422,
	octaves = 3,
	persist = 0.67
}

local median = df_caverns.config.underworld_level
local floor_mult = 20
local floor_displace = -10
local ceiling_mult = -40
local ceiling_displace = 20
local wave_mult = 50

local y_max = median + 2*wave_mult + ceiling_displace + -2*ceiling_mult
local y_min = median - 2*wave_mult + floor_displace - 2*floor_mult


---------------------------------------------------------
-- Buildings

local oubliette_threshold = 0.8
local town_threshold = 1.1

local local_random = function(x, z)
	math.randomseed(x + z*2^16)
	return math.random()
end

-- create a deterministic list of buildings
local get_buildings = function(emin, emax, pit, nvals_zone)
	local buildings = {}
	for x = emin.x, emax.x do
		for z = emin.z, emax.z do
		
			local index2d = mapgen_helper.index2d(emin, emax, x, z)
			local zone = math.abs(nvals_zone[index2d])
			
			if zone > oubliette_threshold and zone < town_threshold then
				-- oubliette zone
				--zone = (zone - oubliette_threshold)/(town_threshold-oubliette_threshold) -- turn this into a 0-1 spread
				local building_val = local_random(x, z)
				if building_val > 0.98 then
					building_val = (building_val - 0.98)/0.02
					local building_type
					if building_val < 0.8 then
						building_type = "oubliette"
					elseif building_val < 0.9 then
						building_type = "open oubliette"
					else
						building_type = "lamppost"
					end
					table.insert(buildings,
						{
							pos = {x=x, y=0, z=z}, -- y to be determined later
							building_type = building_type,
							bounding_box = {minpos={x=x-2, z=z-2}, maxpos={x=x+2, z=z+2}},
							priority = math.floor(building_val * 10000000) % 1000, -- indended to allow for deterministic removal of overlapping buildings
						}						
					)
				end
			elseif zone > town_threshold then
				-- town zone
				local building_val = local_random(x, z)
				if building_val > 0.9925 then
					building_val = (building_val - 0.9925)/0.0075
	
					local building_type
					local bounding_box
					local priority = math.floor(building_val * 10000000) % 1000
					local rotation = (priority % 4) * 90
	
					if building_val < 0.75 then
						building_type = "small building"
						local boundmin, boundmax = mapgen_helper.get_schematic_bounding_box({x=x, y=0, z=z}, small_building_schematic, rotation)
						bounding_box = {minpos=boundmin, maxpos=boundmax}
					elseif building_val < 0.85 then
						building_type = "medium building"
						local boundmin, boundmax = mapgen_helper.get_schematic_bounding_box({x=x, y=0, z=z}, medium_building_schematic, rotation)
						bounding_box = {minpos=boundmin, maxpos=boundmax}					
					else
						building_type = "small slab"
						local boundmin, boundmax = mapgen_helper.get_schematic_bounding_box({x=x, y=0, z=z}, small_slab_schematic, rotation)
						bounding_box = {minpos=boundmin, maxpos=boundmax}						
					end
					
					table.insert(buildings,
						{
							pos = {x=x, y=0, z=z}, -- y to be determined later
							building_type = building_type,
							bounding_box = bounding_box,
							rotation = rotation,
							priority = priority, -- indended to allow for deterministic removal of overlapping buildings
						}
					)
				end
			end
		end
	end
	
	-- eliminate overlapping buildings
	local building_count = table.getn(buildings)
	local overlap_count = 0
	for i = 1, building_count-1 do
		local curr_building = buildings[i]
		for j = i+1, building_count do
			local test_building = buildings[j]
			if test_building ~= nil and curr_building ~= nil and mapgen_helper.intersect_exists_xz(
				curr_building.bounding_box.minpos,
				curr_building.bounding_box.maxpos,
				test_building.bounding_box.minpos,
				test_building.bounding_box.maxpos) then
				
				if curr_building.priority < test_building.priority then -- this makes elimination of overlapping buildings deterministic
					buildings[i] = nil
					j=building_count+1
				else
					buildings[j] = nil
				end
				overlap_count = overlap_count + 1
			end
		end
	end
	
	if overlap_count > building_count * 2/3 then
		minetest.log("warning", "[df_caverns] underworld mapgen generated " ..
			tostring(building_count) .. " buildings and " .. tostring(overlap_count) ..
			" were eliminated as overlapping, consider reducing building generation probability" ..
			" to improve efficiency.")
	end
	
	local compacted_buildings = {}
	for _, building in pairs(buildings) do
		compacted_buildings[minetest.hash_node_position(building.pos)] = building
	end
	
	return compacted_buildings
end

-----------------------------------------------------------
-- Pits

local radius_pit_max = 40 -- won't actually be this wide, there'll be crystal spires around it
local radius_pit_variance = 10

local region_mapblocks = 8 -- One glowing pit in each region this size
local mapgen_chunksize = tonumber(minetest.get_mapgen_setting("chunksize"))
local pit_region_size = region_mapblocks * mapgen_chunksize * 16

local scatter_2d = function(min_xz, gridscale, border_width)
	local bordered_scale = gridscale - 2 * border_width
	local point = {}
	point.x = math.random() * bordered_scale + min_xz.x + border_width
	point.y = 0
	point.z = math.random() * bordered_scale + min_xz.z + border_width
	return point
end

-- For some reason, map chunks generate with -32, -32, -32 as the "origin" minp. To make the large-scale grid align with map chunks it needs to be offset like this.
local get_corner = function(pos)
	return {x = math.floor((pos.x+32) / pit_region_size) * pit_region_size - 32, z = math.floor((pos.z+32) / pit_region_size) * pit_region_size - 32}
end

local get_pit = function(pos, mapgen_seed)
	local corner_xz = get_corner(pos)
	local next_seed = math.random(1, 1000000000)
	math.randomseed(corner_xz.x + corner_xz.z * 2 ^ 8)
	local location = scatter_2d(corner_xz, pit_region_size, radius_pit_max + radius_pit_variance)
	local variance_multiplier = math.random()
	local radius = variance_multiplier * (radius_pit_max - 15) + 15
	local variance = radius_pit_variance/2 + radius_pit_variance*variance_multiplier/2 
	math.randomseed(next_seed)
	return {location = location, radius = radius, variance = variance}
end

local perlin_pit = {
	offset = 0,
	scale = 1,
	spread = {x=30, y=30, z=30},
	seed = 901,
	octaves = 3,
	persist = 0.67
}

-------------------------------------


minetest.register_on_generated(function(minp, maxp, seed)

	--if out of range of cave definition limits, abort
	if minp.y > y_max or maxp.y < y_min then
		return
	end

	local t_start = os.clock()

	local vm, data, data_param2, area = mapgen_helper.mapgen_vm_data_param2()
	local emin = area.MinEdge
	local emax = area.MaxEdge
	
	local nvals_cave = mapgen_helper.perlin2d("df_caverns:underworld", emin, emax, perlin_cave) --cave noise for structure
	local nvals_wave = mapgen_helper.perlin2d("df_caverns:underworld_wave", emin, emax, perlin_wave) --cave noise for structure
	local nvals_zone = mapgen_helper.perlin2d("df_caverns:underworld_zone", emin, emax, perlin_zone) --building zones
	
	local pit = get_pit(minp)
	--minetest.chat_send_all(minetest.pos_to_string(pit.location))
	
	local buildings = get_buildings(emin, emax, pit, nvals_zone)
	
	local pit_uninitialized = true
	local nvals_pit, area_pit
	
	for vi, x, y, z in area:iterp_yxz(minp, maxp) do
		local index2d = mapgen_helper.index2d(emin, emax, x, z)
		local abs_cave = math.abs(nvals_cave[index2d]) -- range is from 0 to approximately 2, with 0 being connected and 2s being islands
		local wave = nvals_wave[index2d] * wave_mult
		
		local floor_height =  math.floor(abs_cave * floor_mult + median + floor_displace + wave)
		local ceiling_height =  math.floor(abs_cave * ceiling_mult + median + ceiling_displace + wave)
		if y <= floor_height then
			data[vi] = c_slade
			if	pit.location.x - radius_pit_max - radius_pit_variance < maxp.x and
				pit.location.x + radius_pit_max + radius_pit_variance > minp.x and
				pit.location.z - radius_pit_max - radius_pit_variance < maxp.z and
				pit.location.z + radius_pit_max + radius_pit_variance > minp.z
			then
				-- there's a pit nearby
				if pit_uninitialized then
					nvals_pit, area_pit = mapgen_helper.perlin3d("subterrane:perlin_cave", minp, maxp, perlin_pit) -- determine which areas are spongey with warrens
					pit_uninitialized = false
				end
				local pit_value = nvals_pit[area_pit:index(x,y,z)] * pit.variance
				local distance = vector.distance({x=x, y=y, z=z}, {x=pit.location.x, y=y, z=pit.location.z}) + pit_value
				if y <  median + floor_displace + wave - 50 and distance < pit.radius then
					data[vi] = c_pit_plasma				
				elseif distance < pit.radius -3 then
					data[vi] = c_air
				elseif distance < pit.radius then
					data[vi] = c_amethyst
				elseif distance < radius_pit_max and y == floor_height - 4 then
					if math.random() > 0.95 then
						df_mapitems.underworld_shard(data, area, vi)
					end
				end
			end			
		elseif y < ceiling_height and data[vi] ~= c_amethyst then
			data[vi] = c_air
		end		
	end

	-- Ceiling decoration
	for x = minp.x + 1, maxp.x-1 do
		for z = minp.z + 1, maxp.z -1 do
			local index2d = mapgen_helper.index2d(emin, emax, x, z)
			local abs_cave = math.abs(nvals_cave[index2d]) -- range is from 0 to approximately 2, with 0 being connected and 2s being islands
			local wave = nvals_wave[index2d] * wave_mult
			local floor_height = math.floor(abs_cave * floor_mult + median + floor_displace + wave)
			local ceiling_height = math.floor(abs_cave * ceiling_mult + median + ceiling_displace + wave)
	
			if ceiling_height > floor_height + 5 and ceiling_height < maxp.y and ceiling_height > minp.y then
				local vi = area:index(x, ceiling_height, z)
				if (
					--test if we're nestled in a crevice
					(data[vi-area.ystride + 1] == c_stone and data[vi-area.ystride - 1] == c_stone) or
					(data[vi-area.ystride + area.zstride] == c_stone and data[vi-area.ystride - area.zstride] == c_stone) or
					(data[vi-area.ystride + 1 + area.zstride] == c_stone and data[vi-area.ystride - 1 - area.zstride] == c_stone) or
					(data[vi-area.ystride - 1 + area.zstride] == c_stone and data[vi-area.ystride + 1 - area.zstride] == c_stone)
				)
				then
					data[vi] = c_glowstone
				end
			end
		end
	end

	-- buildings
	for x = emin.x + 5, emax.x - 5 do
		for z = emin.z + 5, emax.z - 5 do
		
			local skip = false
			if	pit.location.x - radius_pit_max - radius_pit_variance < x and
				pit.location.x + radius_pit_max + radius_pit_variance > x and
				pit.location.z - radius_pit_max - radius_pit_variance < z and
				pit.location.z + radius_pit_max + radius_pit_variance > z
			then
				if vector.distance(pit.location, {x=x, y=0, z=z}) < radius_pit_max + radius_pit_variance then
					-- there's a pit nearby
					skip = true -- TODO
				end
			end

		
			local index2d = mapgen_helper.index2d(emin, emax, x, z)
			local abs_cave = math.abs(nvals_cave[index2d]) -- range is from 0 to approximately 2, with 0 being connected and 2s being islands
			local wave = nvals_wave[index2d] * wave_mult
			local floor_height = math.floor(abs_cave * floor_mult + median + floor_displace + wave)
			local ceiling_height = math.floor(abs_cave * ceiling_mult + median + ceiling_displace + wave)
		
			if ceiling_height > floor_height and floor_height <= maxp.y and floor_height >= minp.y  then
				local building = buildings[minetest.hash_node_position({x=x,y=0,z=z})]
				if building ~= nil then
					building.pos.y = floor_height
					--minetest.chat_send_all("placing " .. building.building_type .. " at " .. minetest.pos_to_string(building.pos))
					if building.building_type == "oubliette" then
						mapgen_helper.place_schematic_on_data(data, data_param2, area, building.pos, oubliette_schematic)						
					elseif building.building_type == "open oubliette" then
						mapgen_helper.place_schematic_on_data(data, data_param2, area, building.pos, oubliette_schematic, 0, {["df_mapitems:slade_seal"] = "air"})
					elseif building.building_type == "lamppost" then
						mapgen_helper.place_schematic_on_data(data, data_param2, area, building.pos, lamppost_schematic)
					elseif building.building_type == "small building" then
						mapgen_helper.place_schematic_on_data(data, data_param2, area, building.pos, small_building_schematic, building.rotation)
					elseif building.building_type == "medium building" then
						mapgen_helper.place_schematic_on_data(data, data_param2, area, building.pos, medium_building_schematic, building.rotation)
					elseif building.building_type == "small slab" then
						mapgen_helper.place_schematic_on_data(data, data_param2, area, building.pos, small_slab_schematic, building.rotation)
					else
						minetest.log("error", "unrecognized underworld building type: " .. tostring(building.building_type))
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
		minetest.log("info", "[df_caverns underworld] "..chunk_generation_time.." ms") --tell people how long
	else
		minetest.log("warning", "[df_caverns underworld] took "..chunk_generation_time.." ms to generate map block "
			.. minetest.pos_to_string(minp) .. minetest.pos_to_string(maxp))
	end
end)
