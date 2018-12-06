local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_sand = minetest.get_content_id("default:sand")
local c_dirt = minetest.get_content_id("default:dirt")
local c_coal_ore = minetest.get_content_id("default:stone_with_coal")
local c_gravel = minetest.get_content_id("default:gravel")
local c_obsidian = minetest.get_content_id("default:obsidian")

local c_sweet_pod = minetest.get_content_id("df_farming:sweet_pod_6") -- param2 = 0
local c_quarry_bush = minetest.get_content_id("df_farming:quarry_bush_5") -- param2 = 4
local c_plump_helmet = minetest.get_content_id("df_farming:plump_helmet_4") -- param2 = 0-3
local c_pig_tail = minetest.get_content_id("df_farming:pig_tail_8") -- param2 = 3
local c_dimple_cup = minetest.get_content_id("df_farming:dimple_cup_4") -- param2 = 0
local c_cave_wheat = minetest.get_content_id("df_farming:cave_wheat_8") -- param2 = 3
local c_dead_fungus = minetest.get_content_id("df_farming:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("df_farming:cavern_fungi") -- param2 = 0

local c_dirt_moss = minetest.get_content_id("df_mapitems:dirt_with_cave_moss")
local c_cobble_fungus = minetest.get_content_id("df_mapitems:cobble_with_floor_fungus")
local c_cobble_fungus_fine = minetest.get_content_id("df_mapitems:cobble_with_floor_fungus_fine")
local c_cobble = minetest.get_content_id("default:cobble")

local c_wet_flowstone = minetest.get_content_id("df_mapitems:wet_flowstone")
local c_dry_flowstone = minetest.get_content_id("df_mapitems:dry_flowstone")

local flooded_biomes = df_caverns.config.flooded_biomes

local tower_cap_shrublist = {c_plump_helmet, c_plump_helmet, c_pig_tail, c_dead_fungus, c_cavern_fungi}
local fungiwood_shrublist = {c_plump_helmet, c_pig_tail, c_cave_wheat, c_cave_wheat, c_dead_fungus, c_cavern_fungi}
local black_cap_shrublist = {c_quarry_bush, c_dead_fungus, c_dead_fungus}
local goblin_cap_shrublist = {c_plump_helmet, c_plump_helmet, c_dimple_cup, c_pig_tail, c_dead_fungus, c_cavern_fungi}
local tunnel_tube_shrublist = {c_pig_tail, c_pig_tail, c_cave_wheat, c_cave_wheat, c_dead_fungus, c_cavern_fungi}
local spore_tree_shrublist = {c_pig_tail, c_dimple_cup, c_dimple_cup, c_cave_wheat, c_dead_fungus, c_cavern_fungi}
df_caverns.nether_cap_shrublist = {c_dimple_cup, c_dead_fungus, c_dead_fungus, c_dead_fungus, c_cavern_fungi}
df_caverns.blood_thorn_shrublist = {c_sweet_pod, c_sweet_pod, c_dead_fungus, c_dead_fungus, c_dead_fungus, c_cavern_fungi}


df_caverns.data_param2 = {}

--------------------------------------------------

df_caverns.stalagmites = function(abs_cracks, vert_rand, vi, area, data, data_param2, wet, reverse_sign)
	local flowstone
	local stalagmite_ids
	if wet then
		flowstone = c_wet_flowstone
		stalagmite_ids = df_mapitems.wet_stalagmite_ids
	else
		flowstone = c_dry_flowstone
		stalagmite_ids = df_mapitems.dry_stalagmite_ids	
	end
	
	local height_mult = 1
	local ystride = area.ystride
	if reverse_sign then
		ystride = - ystride
		height_mult = -1
	end		

	if vert_rand < 0.004 then
		if reverse_sign then
			subterrane.big_stalactite(vi+ystride, area, data, 6, 15, flowstone, flowstone, flowstone)
		else
			subterrane.big_stalagmite(vi+ystride, area, data, 6, 15, flowstone, flowstone, flowstone)
		end
	else
		local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
		local height = math.floor(abs_cracks * 50)
		subterrane.stalagmite(vi+ystride, area, data, data_param2, param2, height*height_mult, stalagmite_ids)
	end
	data[vi] = flowstone
end

df_caverns.stalactites = function(abs_cracks, vert_rand, vi, area, data, data_param2, wet)
	df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, wet, true)
end

--------------------------------------------------

df_caverns.tower_cap_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end

		if math.random() < 0.1 then
			df_caverns.place_shrub(data, vi+ystride, data_param2, tower_cap_shrublist)
		elseif math.random() < 0.01 and abs_cracks > 0.25 then
			df_trees.spawn_tower_cap_vm(vi, area, data)
		end
	end
end

df_caverns.fungiwood_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end
		if math.random() < 0.1 then
			df_caverns.place_shrub(data, vi, data_param2, fungiwood_shrublist)
		elseif math.random() < 0.03 and abs_cracks > 0.35 then
			df_trees.spawn_fungiwood_vm(vi+ystride, area, data)
		end
	end
end

df_caverns.flooded_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.25 then
		data[vi] = c_mossycobble
	elseif data[vi-ystride] ~= c_air then
		data[vi] = c_dirt
		
		if not flooded_biomes then -- don't put vegetation if the floor's going to be covered in water
			if math.random() < 0.05 then
				data[vi+ystride] = c_dead_fungus
			elseif math.random() < 0.05 then
				data[vi+ystride] = c_cavern_fungi
			end
		end
	end
	
	if flooded_biomes then
		-- put in only the large stalagmites that won't get in the way of the water
		if abs_cracks < 0.1 then
			if vert_rand < 0.004 then
				subterrane.big_stalagmite(vi+ystride, area, data, 6, 15, c_wet_flowstone, c_wet_flowstone, c_wet_flowstone)
			end
		end
		--Cover the floor with a thick layer of water
		df_caverns.deep_water(abs_cracks, vi, ystride, data)
	else
		-- Put in stalagmites and the occasional isolated blob of water.
		if abs_cracks < 0.1 then
			df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
		elseif math.random() < 0.001 then
			data[vi+ystride] = c_water
		end
	end
end


df_caverns.dry_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	if abs_cracks < 0.075 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
	elseif abs_cracks < 0.4 then
		data[vi] = c_cobble
	elseif abs_cracks < 0.6 then
		data[vi] = c_cobble_fungus_fine
	else
		data[vi] = c_cobble_fungus
		if math.random() < 0.05 then
			data[vi+area.ystride] = c_dead_fungus
		end
	end
end

df_caverns.black_cap_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	if math.random() < 0.25 then
		data[vi] = c_stone_with_coal
	else
		data[vi] = c_cobble_fungus
	end
	
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, false)
	else
		if math.random() < 0.05 then
			df_caverns.place_shrub(data, vi+area.ystride, data_param2, black_cap_shrublist)
		elseif math.random() < 0.01 and abs_cracks > 0.25 then
			df_trees.spawn_black_cap_vm(vi, area, data)
		end
	end
end


df_caverns.goblin_cap_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end
		if math.random() < 0.1 then
			df_caverns.place_shrub(data, vi+ystride, data_param2, goblin_cap_shrublist)
		elseif math.random() < 0.015 then
			df_trees.spawn_goblin_cap_vm(vi, area, data)
		end
	end

end

df_caverns.spore_tree_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)			
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end
		if math.random() < 0.1 then
			df_caverns.place_shrub(data, vi+ystride, data_param2, spore_tree_shrublist)
		elseif math.random() < 0.05 then
			df_trees.spawn_spore_tree_vm(vi+ystride, area, data)
		end
	end
end


df_caverns.tunnel_tube_cavern_floor = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	local ystride = area.ystride
	if abs_cracks < 0.1 then
		df_caverns.stalagmites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif data[vi-ystride] ~= c_air then -- leave the ground as rock if it's only one node thick
		if math.random() < 0.25 then
			data[vi] = c_dirt
		else
			data[vi] = c_dirt_moss
		end
		if math.random() < 0.1 then
			df_caverns.place_shrub(data, vi+ystride, data_param2, tunnel_tube_shrublist)
		elseif math.random() < 0.05 then
			df_trees.spawn_tunnel_tube_vm(vi+ystride, area, data, data_param2)
		end
	end
end

--------------------------------------

df_caverns.glow_worm_cavern_ceiling = function(abs_cracks, vert_rand, vi, area, data, data_param2)
	if abs_cracks < 0.1 then
		df_caverns.stalactites(abs_cracks, vert_rand, vi, area, data, data_param2, true)
	elseif abs_cracks < 0.5 and abs_cracks > 0.3 and math.random() < 0.3 then
		df_mapitems.glow_worm_ceiling(area, data, vi-area.ystride)
	end
end

local tunnel_floor = function(minp, maxp, area, vi, cracks, abs_cracks, data, data_param2, flooded)
	local ystride = area.ystride
	if flooded == "flooded" then
		if flooded_biomes then
			df_caverns.deep_water(cracks, vi, ystride, data)
		end
	elseif flooded == "wet" then
		if abs_cracks < 0.05 and data[vi+ystride] == c_air then -- TODO: further test, make sure data[vi] is not already flowstone. Stalagmites from lower levels are acting as base for further stalagmites
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = math.floor(abs_cracks * 100)
			subterrane.stalagmite(vi+ystride, area, data, data_param2, param2, height, df_mapitems.wet_stalagmite_ids)
			data[vi] = c_wet_flowstone
		end
	else
		if abs_cracks < 0.025 and data[vi+ystride] == c_air then -- TODO: further test, make sure data[vi] is not already flowstone. Stalagmites from lower levels are acting as base for further stalagmites
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = math.floor(abs_cracks * 100)
			subterrane.stalagmite(vi+ystride, area, data, data_param2, param2, height, df_mapitems.dry_stalagmite_ids)
		elseif cracks > 0.5 and data[vi-ystride] ~= c_air then
			data[vi] = c_gravel
		end
	end
end

local tunnel_ceiling = function(minp, maxp, area, vi, cracks, abs_cracks, data, data_param2, flooded)
	local ystride = area.ystride
	if flooded == "flooded" then
		return
	elseif flooded == "wet" then
		if abs_cracks < 0.05 and data[vi-ystride] == c_air then -- TODO: further test, make sure data[vi] is not already flowstone. Stalactites from upper levels are acting as base for further stalactites
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = math.floor(abs_cracks * 100)
			subterrane.stalactite(vi-ystride, area, data, data_param2, param2, height, df_mapitems.wet_stalagmite_ids)
			data[vi] = c_wet_flowstone
		end
	else
		if abs_cracks < 0.025 and data[vi-ystride] == c_air then -- TODO: further test, make sure data[vi] is not already flowstone. Stalactites from upper levels are acting as base for further stalactites
			local param2 = abs_cracks*1000000 - math.floor(abs_cracks*1000000/4)*4
			local height = math.floor(abs_cracks * 100)
			subterrane.stalactite(vi-ystride, area, data, data_param2, param2, height, df_mapitems.dry_stalagmite_ids)
		end
	end
end


df_caverns.get_decoration_node_data = function(minp, maxp, area, vi, biomemap, nvals_cracks)
	local index2d = mapgen_helper.index2di(minp, maxp, area, vi)
	local biome = mapgen_helper.get_biome_def(biomemap[index2d])
	local cracks = nvals_cracks[index2d]
	local vert_rand = mapgen_helper.xz_consistent_randomi(area, vi)
	return biome, cracks, vert_rand, index2d
end

df_caverns.basic_tunnel_floor = function(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, flooded_biome_name, dry_biome_names)
	local biome, cracks, vert_rand = df_caverns.get_decoration_node_data(minp, maxp, area, vi, biomemap, nvals_cracks)
	local abs_cracks = math.abs(cracks)
	
	if biome and biome.name == flooded_biome_name then
		tunnel_floor(minp, maxp, area, vi, cracks, abs_cracks, data, data_param2, "flooded")
	elseif biome and dry_biome_names[biome.name] then
		tunnel_floor(minp, maxp, area, vi, cracks, abs_cracks, data, data_param2, "dry")
	else
		tunnel_floor(minp, maxp, area, vi, cracks, abs_cracks, data, data_param2, "wet")
	end
end

df_caverns.basic_tunnel_ceiling = function(minp, maxp, area, vi, data, data_param2, biomemap, nvals_cracks, flooded_biome_name, dry_biome_names)
	local biome, cracks, vert_rand = df_caverns.get_decoration_node_data(minp, maxp, area, vi, biomemap, nvals_cracks)
	local abs_cracks = math.abs(cracks)
		
	if biome and biome.name == flooded_biome_name then
		tunnel_ceiling(minp, maxp, area, vi, cracks, abs_cracks, data, data_param2, "flooded")
	elseif biome and dry_biome_names[biome.name] then
		tunnel_ceiling(minp, maxp, area, vi, cracks, abs_cracks, data, data_param2, "dry")
	else
		tunnel_ceiling(minp, maxp, area, vi, cracks, abs_cracks, data, data_param2, "wet")
	end
end

df_caverns.deep_water = function(cracks, vi, ystride, data)
	local depth = cracks + 1
	vi = vi + ystride
	while depth > 0 and data[vi] == c_air do
		data[vi] = c_water
		vi = vi + ystride
		depth = depth - 1
	end
end

df_caverns.perlin_cave = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale, y=df_caverns.config.vertical_cavern_scale, z=df_caverns.config.horizontal_cavern_scale},
	seed = -400000000089,
	octaves = 3,
	persist = 0.67
}

df_caverns.perlin_wave = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale * 2, y=df_caverns.config.vertical_cavern_scale, z=df_caverns.config.horizontal_cavern_scale * 2}, -- squashed 2:1
	seed = 59033,
	octaves = 6,
	persist = 0.63
}

-- Used for making lines of dripstone
df_caverns.np_cracks = {
	offset = 0,
	scale = 1,
	spread = {x = 20, y = 20, z = 20},
	seed = 5717,
	octaves = 3,
	persist = 0.63,
	lacunarity = 2.0,
}

---------------------------------------------------------------------------------

local shallow_cave_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.025 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.025 * 4)
		subterrane.stalagmite(vi, area, data, param2_data, param2, height, df_mapitems.dry_stalagmite_ids)
	end	
end

local shallow_cave_ceiling = function(area, data, ai, vi, bi, param2_data)
	if data[ai] ~= c_stone then
		return
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.025 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.025 * 5)		
		subterrane.stalactite(vi, area, data, param2_data, param2, height, df_mapitems.dry_stalagmite_ids)
	end	
end


-- default mapgen registers an "underground" biome that gets in the way of everything.
subterrane:override_biome({
	name = "underground",
	y_min = df_caverns.config.ymax,
	y_max = -113,
	heat_point = 50,
	humidity_point = 50,
	_subterrane_cave_floor_decor = shallow_cave_floor,
	_subterrane_cave_ceiling_decor = shallow_cave_ceiling,
})

-- surface tunnels
subterrane:register_cave_decor(-113, df_caverns.config.ymax)

df_caverns.perlin_cave_lava = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale * 2, y=df_caverns.config.vertical_cavern_scale * 0.5, z=df_caverns.config.horizontal_cavern_scale * 2},
	seed = -400000000089,
	octaves = 3,
	persist = 0.67
}

df_caverns.perlin_wave_lava = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale * 4, y=df_caverns.config.vertical_cavern_scale * 0.5, z=df_caverns.config.horizontal_cavern_scale * 4}, -- squashed 2:1
	seed = 59033,
	octaves = 6,
	persist = 0.63
}

if df_caverns.config.enable_lava_sea then
	subterrane:register_cave_layer({
		minimum_depth = df_caverns.config.lava_sea_max,
		maximum_depth = df_caverns.config.lava_sea_min,
		cave_threshold = df_caverns.config.lava_sea_threshold,
		perlin_cave = df_caverns.perlin_cave_lava,
		perlin_wave = df_caverns.perlin_wave_lava,
		columns = {
			maximum_radius = 30,
			minimum_radius = 5,
			node = c_obsidian,
			weight = 0.5,
			maximum_count = 100,
			minimum_count = 25,
		},
	})
end

df_caverns.can_support_vegetation = {[c_sand] = true, [c_dirt] = true, [c_coal_ore] = true, [c_gravel] = true} -- Likely to be deprecated


df_caverns.place_shrub = function(data, vi, param2_data, shrub_list)
	local shrub = shrub_list[math.random(#shrub_list)]
	
	if shrub == c_quarry_bush then
		data[vi] = c_quarry_bush
		param2_data[vi] = 4
	elseif shrub == c_plump_helmet then
		data[vi] = c_plump_helmet
		param2_data[vi] = math.random(0,3)
	elseif shrub == c_pig_tail then
		data[vi] = c_pig_tail
		param2_data[vi] = 3
	elseif shrub == c_cave_wheat then
		data[vi] = c_cave_wheat
		param2_data[vi] = 3
	else
		data[vi] = shrub
		param2_data[vi] = 0
	end
end