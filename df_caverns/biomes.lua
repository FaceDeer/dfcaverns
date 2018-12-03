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

local c_wet_flowstone = minetest.get_content_id("df_mapitems:wet_flowstone")

local shallow_cave_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.025 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.025 * 4)
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, height, df_mapitems.dry_stalagmite_ids)
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
		subterrane:small_stalagmite(vi, area, data, param2_data, param2, -height, df_mapitems.dry_stalagmite_ids)
	end	
end


local perlin_cave = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale, y=df_caverns.config.vertical_cavern_scale, z=df_caverns.config.horizontal_cavern_scale},
	seed = -400000000089,
	octaves = 3,
	persist = 0.67
}

local perlin_wave = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale * 2, y=df_caverns.config.vertical_cavern_scale, z=df_caverns.config.horizontal_cavern_scale * 2}, -- squashed 2:1
	seed = 59033,
	octaves = 6,
	persist = 0.63
}

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

subterrane:register_cave_decor(-113, df_caverns.config.ymax)

subterrane:register_cave_layer({
	minimum_depth = df_caverns.config.level1_min,
	maximum_depth = df_caverns.config.level2_min,
	cave_threshold = df_caverns.config.cavern_threshold,
	perlin_cave = perlin_cave,
	perlin_wave = perlin_wave,
	columns = {
		maximum_radius = 15,
		minimum_radius = 4,
		node = c_wet_flowstone,
		weight = 0.25,
		maximum_count = 30,
		minimum_count = 5,
	},
})

subterrane:register_cave_layer({
	minimum_depth = df_caverns.config.level2_min,
	maximum_depth = df_caverns.config.level3_min,
	cave_threshold = df_caverns.config.cavern_threshold,
	perlin_cave = perlin_cave,
	perlin_wave = perlin_wave,
	columns = {
		maximum_radius = 20,
		minimum_radius = 5,
		node = c_wet_flowstone,
		weight = 0.25,
		maximum_count = 50,
		minimum_count = 10,
	},
})

local perlin_cave_lava = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale * 2, y=df_caverns.config.vertical_cavern_scale * 0.5, z=df_caverns.config.horizontal_cavern_scale * 2},
	seed = -400000000089,
	octaves = 3,
	persist = 0.67
}

local perlin_wave_lava = {
	offset = 0,
	scale = 1,
	spread = {x=df_caverns.config.horizontal_cavern_scale * 4, y=df_caverns.config.vertical_cavern_scale * 0.5, z=df_caverns.config.horizontal_cavern_scale * 4}, -- squashed 2:1
	seed = 59033,
	octaves = 6,
	persist = 0.63
}

--Sunless Sea
subterrane:register_cave_layer({
	minimum_depth = df_caverns.config.level3_min,
	maximum_depth = df_caverns.config.sunless_sea_min,
	cave_threshold = df_caverns.config.lava_sea_threshold,
	perlin_cave = perlin_cave_lava,
	perlin_wave = perlin_wave_lava,
	columns = {
		maximum_radius = 25,
		minimum_radius = 5,
		node = c_stone,
		weight = 0.25,
		maximum_count = 100,
		minimum_count = 25,
	},
})

if df_caverns.config.enable_lava_sea then
	subterrane:register_cave_layer({
		minimum_depth = df_caverns.config.lava_sea_max,
		maximum_depth = df_caverns.config.lava_sea_min,
		cave_threshold = df_caverns.config.lava_sea_threshold,
		perlin_cave = perlin_cave_lava,
		perlin_wave = perlin_wave_lava,
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

df_caverns.can_support_vegetation = {[c_sand] = true, [c_dirt] = true, [c_coal_ore] = true, [c_gravel] = true}

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