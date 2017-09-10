local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_cobble = minetest.get_content_id("default:cobble")
local c_mossycobble = minetest.get_content_id("default:mossycobble")
local c_dirt = minetest.get_content_id("default:dirt")

local c_dirt_moss = minetest.get_content_id("dfcaverns:dirt_with_cave_moss")
local c_cobble_fungus = minetest.get_content_id("dfcaverns:cobble_with_floor_fungus")

local c_wet_flowstone = minetest.get_content_id("subterrane:wet_flowstone")
local c_dry_flowstone = minetest.get_content_id("subterrane:dry_flowstone")

local subsea_level = (dfcaverns.config.level1_min - dfcaverns.config.ymax) * 0.3 + dfcaverns.config.level1_min

local c_sweet_pod = minetest.get_content_id("dfcaverns:sweet_pod_6") -- param2 = 0
local c_quarry_bush = minetest.get_content_id("dfcaverns:quarry_bush_5") -- param2 = 4
local c_plump_helmet = minetest.get_content_id("dfcaverns:plump_helmet_4") -- param2 = 0-3
local c_pig_tail = minetest.get_content_id("dfcaverns:pig_tail_8") -- param2 = 3
local c_dimple_cup = minetest.get_content_id("dfcaverns:dimple_cup_4") -- param2 = 0
local c_cave_wheat = minetest.get_content_id("dfcaverns:cave_wheat_8") -- param2 = 3
local c_dead_fungus = minetest.get_content_id("dfcaverns:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("dfcaverns:cavern_fungi") -- param2 = 0

local level_1_tower_cap_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	if math.random() < 0.25 then
		data[bi] = c_dirt
	else
		data[bi] = c_dirt_moss
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if math.random() < 0.1 then
		dfcaverns.place_shrub(data, vi, param2_data, {c_plump_helmet, c_plump_helmet, c_pig_tail, c_dead_fungus, c_cavern_fungi})
	elseif drip_rand < 0.0025 then
		
	elseif drip_rand < 0.1 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.005 then
		dfcaverns.spawn_tower_cap_vm(vi, area, data)
	end
end

local level_1_fungiwood_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	if math.random() < 0.25 then
		data[bi] = c_dirt
	else
		data[bi] = c_dirt_moss
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	
	if math.random() < 0.1 then
		dfcaverns.place_shrub(data, vi, param2_data, {c_plump_helmet, c_pig_tail, c_cave_wheat, c_cave_wheat, c_dead_fungus, c_cavern_fungi})
	elseif drip_rand < 0.001 then
		subterrane:giant_stalagmite(bi, area, data, 6, 15, c_wet_flowstone, c_wet_flowstone, c_wet_flowstone)
	elseif drip_rand < 0.1 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.005 then
		dfcaverns.spawn_fungiwood_vm(vi, area, data)
	end
end

local level_1_moist_ceiling = function(area, data, ai, vi, bi, param2_data)
	if data[ai] ~= c_stone then
		return
	end
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.0025 then
		subterrane:giant_stalactite(ai, area, data, 6, 15, c_wet_flowstone, c_wet_flowstone, c_wet_flowstone)
	elseif drip_rand < 0.075 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.075 * 5)
		subterrane:stalagmite(vi, area, data, param2_data, param2, -height, true)
	elseif math.random() < 0.03 then
		dfcaverns.glow_worm_ceiling(area, data, ai, vi, bi)
	end
end

local level_1_wet_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end

	if math.random() < 0.5 then
		data[bi] = c_mossycobble
		if math.random() < 0.05 then
			data[vi] = c_dead_fungus
		elseif math.random() < 0.05 then
			data[vi] = c_cavern_fungi
		end
	end	
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)

	if drip_rand < 0.001 then
		subterrane:giant_stalagmite(bi, area, data, 6, 15, c_wet_flowstone, c_wet_flowstone, c_wet_flowstone)
	elseif drip_rand < 0.025 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.025 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, true)
	end
end

local level_1_dry_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	if math.random() < 0.25 then
		data[bi] = c_cobble_fungus
		if math.random() < 0.1 then
			data[vi] = c_dead_fungus
		end
	elseif math.random() < 0.5 then
		data[bi] = c_cobble
	end	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)

	if drip_rand < 0.001 then
		subterrane:giant_stalagmite(bi, area, data, 6, 15, c_dry_flowstone, c_dry_flowstone, c_dry_flowstone)
	elseif drip_rand < 0.05 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.05 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, false)
	end
end

local level_1_dry_ceiling = function(area, data, ai, vi, bi, param2_data)
	if data[ai] ~= c_stone then
		return
	end
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.001 then
		subterrane:giant_stalactite(ai, area, data, 6, 15, c_dry_flowstone, c_dry_flowstone, c_dry_flowstone)
	elseif drip_rand < 0.075 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.075 * 5)
		subterrane:stalagmite(vi, area, data, param2_data, param2, -height, false)
	end
end

local level_1_underwater_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	if math.random() < 0.25 then
		data[bi] = c_mossycobble
	else
		data[bi] = c_dirt
	end
	if data[vi] == c_air then
		data[vi] = c_water
	end
	if data[ai] == c_air then
		data[ai] = c_water
	end
end


local level_1_cave_floor = function(area, data, ai, vi, bi, param2_data)
	if dfcaverns.can_support_vegetation[data[bi]] then
		data[bi] = c_cobble_fungus
		if math.random() < 0.15 then
			if data[vi] == c_air then
				dfcaverns.place_shrub(data, vi, param2_data, {c_plump_helmet, c_dead_fungus, c_dead_fungus, c_cavern_fungi, c_cavern_fungi})
			end
		end
		return
	end
	
	if data[bi] ~= c_stone then
		return
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.075 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.075 * 4)
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, true)
	end	
end

local level_1_cave_ceiling = function(area, data, ai, vi, bi, param2_data)
	if data[ai] ~= c_stone then
		return
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)

	if drip_rand < 0.1 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, -height, true)
	end	
end

-------------------------------------------------------------------------------------------


minetest.register_biome({
	name = "dfcaverns_level1_flooded_biome_lower",
	y_min = dfcaverns.config.level1_min,
	y_max = subsea_level,
	heat_point = 50,
	humidity_point = 100,
	_subterrane_fill_node = c_water,
	_subterrane_cave_fill_node = c_water,
	_subterrane_floor_decor = level_1_underwater_floor,
	_subterrane_mitigate_lava = false, -- no need to mitigate lava in a flooded cave, problem is self-solving
})

minetest.register_biome({
	name = "dfcaverns_level1_flooded_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.ymax,
	heat_point = 50,
	humidity_point = 100,
	_subterrane_ceiling_decor = level_1_moist_ceiling,
	_subterrane_floor_decor = level_1_wet_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_fill_node = c_water,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level1_tower_cap_biome_lower",
	y_min = dfcaverns.config.level1_min,
	y_max = subsea_level,
	heat_point = 30,
	humidity_point = 40,
	_subterrane_ceiling_decor = level_1_moist_ceiling,
	_subterrane_floor_decor = level_1_tower_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_1_cave_floor,
	_subterrane_cave_ceiling_decor = level_1_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level1_tower_cap_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.ymax,
	heat_point = 30,
	humidity_point = 40,
	_subterrane_ceiling_decor = level_1_moist_ceiling,
	_subterrane_floor_decor = level_1_tower_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_1_cave_floor,
	_subterrane_cave_ceiling_decor = level_1_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level1_fungiwood_biome_lower",
	y_min = dfcaverns.config.level1_min,
	y_max = subsea_level,
	heat_point = 70,
	humidity_point = 40,
	_subterrane_ceiling_decor = level_1_moist_ceiling,
	_subterrane_floor_decor = level_1_fungiwood_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_1_cave_floor,
	_subterrane_cave_ceiling_decor = level_1_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level1_fungiwood_biome_upper",
	y_min = dfcaverns.config.level1_min,
	y_max = subsea_level,
	heat_point = 70,
	humidity_point = 40,
	_subterrane_ceiling_decor = level_1_moist_ceiling,
	_subterrane_floor_decor = level_1_fungiwood_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_1_cave_floor,
	_subterrane_cave_ceiling_decor = level_1_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level1_tower_cap_flooded_biome_lower",
	y_min = subsea_level,
	y_max = dfcaverns.config.ymax,
	heat_point = 20,
	humidity_point = 80,
	_subterrane_fill_node = c_air,
	_subterrane_cave_fill_node = c_water,
	_subterrane_floor_decor = level_1_underwater_floor,
	_subterrane_mitigate_lava = false, -- no need to mitigate lava in a flooded cave, problem is self-solving
})


minetest.register_biome({
	name = "dfcaverns_level1_tower_cap_flooded_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.ymax,
	heat_point = 20,
	humidity_point = 80,
	_subterrane_ceiling_decor = level_1_moist_ceiling,
	_subterrane_floor_decor = level_1_tower_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_1_cave_floor,
	_subterrane_cave_ceiling_decor = level_1_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level1_fungiwood_flooded_biome_lower",
	y_min = dfcaverns.config.level1_min,
	y_max = subsea_level,
	heat_point = 80,
	humidity_point = 80,
	_subterrane_fill_node = c_air,
	_subterrane_cave_fill_node = c_water,
	_subterrane_floor_decor = level_1_underwater_floor,
	_subterrane_mitigate_lava = false, -- no need to mitigate lava in a flooded cave, problem is self-solving
})

minetest.register_biome({
	name = "dfcaverns_level1_fungiwood_flooded_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.ymax,
	heat_point = 80,
	humidity_point = 80,
	_subterrane_ceiling_decor = level_1_moist_ceiling,
	_subterrane_floor_decor = level_1_fungiwood_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_1_cave_floor,
	_subterrane_cave_ceiling_decor = level_1_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level1_dry_biome_lower",
	y_min = dfcaverns.config.level1_min,
	y_max = subsea_level,
	heat_point = 50,
	humidity_point = 0,
	_subterrane_ceiling_decor = level_1_dry_ceiling,
	_subterrane_floor_decor = level_1_dry_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = false, -- let the lava spill in, nothing to protect
})

minetest.register_biome({
	name = "dfcaverns_level1_dry_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.ymax,
	heat_point = 50,
	humidity_point = 0,
	_subterrane_ceiling_decor = level_1_dry_ceiling,
	_subterrane_floor_decor = level_1_dry_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = false, -- let the lava spill in, nothing to protect
})