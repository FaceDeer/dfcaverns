--dfcaverns.spawn_tunnel_tube_vm(vi, area, data, param2_data)
--dfcaverns.spawn_spore_tree_vm(vi, data, area)
--dfcaverns.spawn_nether_cap_vm(vi, area, data)
--dfcaverns.spawn_goblin_cap_vm(vi, area, data)
--dfcaverns.spawn_blood_thorn_vm(vi, area, data, data_param2)


local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_cobble = minetest.get_content_id("default:cobble")
local c_mossycobble = minetest.get_content_id("default:mossycobble")
local c_dirt = minetest.get_content_id("default:dirt")
local c_sand = minetest.get_content_id("default:sand")

local c_silver_sand = minetest.get_content_id("default:silver_sand")
local c_snow = minetest.get_content_id("default:snow")
local c_ice = minetest.get_content_id("default:ice")

local c_dirt_moss = minetest.get_content_id("dfcaverns:dirt_with_cave_moss")
local c_cobble_fungus = minetest.get_content_id("dfcaverns:cobble_with_floor_fungus")

local c_wet_flowstone = minetest.get_content_id("subterrane:wet_flowstone")
local c_dry_flowstone = minetest.get_content_id("subterrane:dry_flowstone")

local c_sweet_pod = minetest.get_content_id("dfcaverns:sweet_pod_6") -- param2 = 0
local c_quarry_bush = minetest.get_content_id("dfcaverns:quarry_bush_5") -- param2 = 4
local c_plump_helmet = minetest.get_content_id("dfcaverns:plump_helmet_4") -- param2 = 0-3
local c_pig_tail = minetest.get_content_id("dfcaverns:pig_tail_8") -- param2 = 3
local c_dimple_cup = minetest.get_content_id("dfcaverns:dimple_cup_4") -- param2 = 0
local c_cave_wheat = minetest.get_content_id("dfcaverns:cave_wheat_8") -- param2 = 3
local c_dead_fungus = minetest.get_content_id("dfcaverns:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("dfcaverns:cavern_fungi") -- param2 = 0

local subsea_level = (dfcaverns.config.level3_min - dfcaverns.config.level2_min) * 0.3 + dfcaverns.config.level3_min

local level_3_moist_ceiling = function(area, data, ai, vi, bi, param2_data)
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

local level_3_dry_floor = function(area, data, ai, vi, bi, param2_data)
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
		subterrane:giant_stalagmite(bi, area, data, 6, 20, c_dry_flowstone, c_dry_flowstone, c_dry_flowstone)
	elseif drip_rand < 0.05 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.05 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, false)
	end
end

local level_3_wet_floor = function(area, data, ai, vi, bi, param2_data)
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
	elseif drip_rand < 0.05 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.05 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, true)
	end
end


local level_3_underwater_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	data[bi] = c_dirt
end

local level_3_dry_ceiling = function(area, data, ai, vi, bi, param2_data)
	if data[ai] ~= c_stone then
		return
	end
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.075 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.075 * 5)
		subterrane:stalagmite(vi, area, data, param2_data, param2, -height, false)
	end
end

local level_3_blood_thorn_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	if math.random() < 0.1 then
		data[bi] = c_dirt_moss
	else
		data[bi] = c_sand
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if math.random() < 0.1 then
		dfcaverns.place_shrub(data, vi, param2_data, {c_sweet_pod, c_sweet_pod, c_plump_helmet, c_dead_fungus, c_dead_fungus, c_dead_fungus, c_cavern_fungi})
	elseif drip_rand < 0.05 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.05 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, false)
	elseif math.random() < 0.05 then
		dfcaverns.spawn_blood_thorn_vm(vi, area, data, param2_data)
	end
end

local level_3_nether_cap_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	local ground = math.random()
	if ground < 0.25 then
		data[bi] = c_silver_sand
	elseif ground < 0.5 then
		data[bi] = c_ice
		data[vi] = c_snow
	elseif ground < 0.75 then
		data[vi] = c_snow
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	
	if math.random() < 0.01 and data[bi] ~= c_ice then
		dfcaverns.place_shrub(data, vi, param2_data, {c_dimple_cup, c_plump_helmet, c_dead_fungus, c_dead_fungus, c_dead_fungus, c_cavern_fungi})
	elseif drip_rand < 0.1 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)
		data[vi] = c_air
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, false)
	elseif math.random() < 0.005 then
		dfcaverns.spawn_nether_cap_vm(vi, area, data)
	end
end

local level_3_tunnel_tube_floor = function(area, data, ai, vi, bi, param2_data)

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
		dfcaverns.place_shrub(data, vi, param2_data, {c_pig_tail, c_quarry_bush, c_quarry_bush, c_cave_wheat, c_dead_fungus, c_cavern_fungi})
	elseif drip_rand < 0.1 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.05 then
		dfcaverns.spawn_tunnel_tube_vm(vi, area, data, param2_data)
	end
end

local level_3_spore_tree_floor = function(area, data, ai, vi, bi, param2_data)
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
		dfcaverns.place_shrub(data, vi, param2_data, {c_pig_tail, c_quarry_bush, c_quarry_bush, c_dimple_cup, c_dead_fungus, c_cavern_fungi})
	elseif drip_rand < 0.001 then
		subterrane:giant_stalagmite(bi, area, data, 6, 15, c_wet_flowstone, c_wet_flowstone, c_wet_flowstone)
	elseif drip_rand < 0.1 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.05 then
		dfcaverns.spawn_spore_tree_vm(vi, area, data)
	end
end

local level_3_black_cap_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end

	if math.random() < 0.25 then
		data[bi] = c_dirt
	else
		data[bi] = c_cobble_fungus
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	
	if math.random() < 0.05 then
		dfcaverns.place_shrub(data, vi, param2_data, {c_quarry_bush, c_dead_fungus, c_dead_fungus})
	elseif drip_rand < 0.001 then
		subterrane:giant_stalagmite(bi, area, data, 6, 15, c_dry_flowstone, c_dry_flowstone, c_dry_flowstone)
	elseif drip_rand < 0.1 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.025 then
		dfcaverns.spawn_black_cap_vm(vi, area, data)
	end
end

local level_3_goblin_cap_floor = function(area, data, ai, vi, bi, param2_data)
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
		dfcaverns.place_shrub(data, vi, param2_data, {c_plump_helmet, c_sweet_pod, c_sweet_pod, c_quarry_bush, c_dead_fungus, c_cavern_fungi})
	elseif drip_rand < 0.1 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.1 * 5)		
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, true)
	elseif math.random() < 0.025 then
		dfcaverns.spawn_goblin_cap_vm(vi, area, data)
	end
end

local level_3_cave_floor = function(area, data, ai, vi, bi, param2_data)
	if dfcaverns.can_support_vegetation[data[bi]] then
		data[bi] = c_dirt_moss
		if math.random() < 0.10 then
			if data[vi] == c_air then
				dfcaverns.place_shrub(data, vi, param2_data, {c_plump_helmet, c_quarry_bush, c_dead_fungus, c_dead_fungus, c_cavern_fungi})
			end
		end
		return
	end
	
	if data[bi] == c_cobble and math.random() < 0.001 then
		data[bi] = c_cobble_fungus
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

local level_3_cave_ceiling = function(area, data, ai, vi, bi, param2_data)
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
	name = "dfcaverns_level3_flooded_biome_lower",
	y_min = dfcaverns.config.level3_min,
	y_max = subsea_level,
	heat_point = 50,
	humidity_point = 90,
	_subterrane_fill_node = c_water,
	_subterrane_cave_fill_node = c_water,
	_subterrane_floor_decor = level_3_underwater_floor,
})

minetest.register_biome({
	name = "dfcaverns_level3_flooded_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level2_min,
	heat_point = 50,
	humidity_point = 90,
	_subterrane_ceiling_decor = level_3_moist_ceiling,
	_subterrane_floor_decor = level_3_wet_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_fill_node = c_water,
	_subterrane_mitigate_lava = true,
})


minetest.register_biome({
	name = "dfcaverns_level3_blood_thorn_biome_lower",
	y_min = dfcaverns.config.level3_min,
	y_max = subsea_level,
	heat_point = 10,
	humidity_point = 30,
	_subterrane_ceiling_decor = level_3_dry_ceiling,
	_subterrane_floor_decor = level_3_blood_thorn_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_blood_thorn_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level2_min,
	heat_point = 10,
	humidity_point = 30,
	_subterrane_ceiling_decor = level_3_dry_ceiling,
	_subterrane_floor_decor = level_3_blood_thorn_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_nether_cap_biome_lower",
	y_min = dfcaverns.config.level3_min,
	y_max = subsea_level,
	heat_point = 90,
	humidity_point = 50,
	_subterrane_ceiling_decor = level_3_dry_ceiling,
	_subterrane_floor_decor = level_3_nether_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_nether_cap_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level2_min,
	heat_point = 90,
	humidity_point = 50,
	_subterrane_ceiling_decor = level_3_dry_ceiling,
	_subterrane_floor_decor = level_3_nether_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_goblin_cap_biome_lower",
	y_min = dfcaverns.config.level3_min,
	y_max = subsea_level,
	heat_point = 20,
	humidity_point = 60,
	_subterrane_ceiling_decor = level_3_moist_ceiling,
	_subterrane_floor_decor = level_3_goblin_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_goblin_cap_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level2_min,
	heat_point = 20,
	humidity_point = 60,
	_subterrane_ceiling_decor = level_3_moist_ceiling,
	_subterrane_floor_decor = level_3_goblin_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_spore_tree_biome_lower",
	y_min = dfcaverns.config.level3_min,
	y_max = subsea_level,
	heat_point = 60,
	humidity_point = 60,
	_subterrane_ceiling_decor = level_3_moist_ceiling,
	_subterrane_floor_decor = level_3_spore_tree_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_spore_tree_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level2_min,
	heat_point = 60,
	humidity_point = 60,
	_subterrane_ceiling_decor = level_3_moist_ceiling,
	_subterrane_floor_decor = level_3_spore_tree_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_tunnel_tube_biome_lower",
	y_min = dfcaverns.config.level3_min,
	y_max = subsea_level,
	heat_point = 60,
	humidity_point = 40,
	_subterrane_ceiling_decor = level_3_moist_ceiling,
	_subterrane_floor_decor = level_3_tunnel_tube_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_tunnel_tube_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level2_min,
	heat_point = 60,
	humidity_point = 40,
	_subterrane_ceiling_decor = level_3_moist_ceiling,
	_subterrane_floor_decor = level_3_tunnel_tube_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_black_cap_biome_lower",
	y_min = dfcaverns.config.level2_min,
	y_max = subsea_level,
	heat_point = 50,
	humidity_point = 15,
	_subterrane_ceiling_decor = level_3_dry_ceiling,
	_subterrane_floor_decor = level_3_black_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_black_cap_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level3_min,
	heat_point = 50,
	humidity_point = 15,
	_subterrane_ceiling_decor = level_3_dry_ceiling,
	_subterrane_floor_decor = level_3_black_cap_floor,
	_subterrane_fill_node = c_air,
	_subterrane_cave_floor_decor = level_3_cave_floor,
	_subterrane_cave_ceiling_decor = level_3_cave_ceiling,
	_subterrane_mitigate_lava = true,
})

minetest.register_biome({
	name = "dfcaverns_level3_dry_biome_lower",
	y_min = dfcaverns.config.level3_min,
	y_max = subsea_level,
	heat_point = 50,
	humidity_point = 10,
	_subterrane_ceiling_decor = level_3_dry_ceiling,
	_subterrane_floor_decor = level_3_dry_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = false,
})

minetest.register_biome({
	name = "dfcaverns_level3_dry_biome_upper",
	y_min = subsea_level,
	y_max = dfcaverns.config.level2_min,
	heat_point = 50,
	humidity_point = 10,
	_subterrane_ceiling_decor = level_3_dry_ceiling,
	_subterrane_floor_decor = level_3_dry_floor,
	_subterrane_fill_node = c_air,
	_subterrane_mitigate_lava = false,
})