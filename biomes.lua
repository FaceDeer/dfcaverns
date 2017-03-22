local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_sand = minetest.get_content_id("default:sand")
local c_dirt = minetest.get_content_id("default:dirt")
local c_coal_ore = minetest.get_content_id("default:stone_with_coal")
local c_gravel = minetest.get_content_id("default:gravel")

local c_sweet_pod = minetest.get_content_id("dfcaverns:sweet_pod_6") -- param2 = 0
local c_quarry_bush = minetest.get_content_id("dfcaverns:quarry_bush_5") -- param2 = 4
local c_plump_helmet = minetest.get_content_id("dfcaverns:plump_helmet_4") -- param2 = 0-3
local c_pig_tail = minetest.get_content_id("dfcaverns:pig_tail_8") -- param2 = 3
local c_dimple_cup = minetest.get_content_id("dfcaverns:dimple_cup_4") -- param2 = 0
local c_cave_wheat = minetest.get_content_id("dfcaverns:cave_wheat_8") -- param2 = 3
local c_dead_fungus = minetest.get_content_id("dfcaverns:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("dfcaverns:cavern_fungi") -- param2 = 0

local c_dirt_moss = minetest.get_content_id("dfcaverns:dirt_with_cave_moss")
local c_cobble_fungus = minetest.get_content_id("dfcaverns:cobble_with_floor_fungus")


local shallow_cave_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	local drip_rand = subterrane:vertically_consistent_random(vi, area)
	if drip_rand < 0.025 then
		local param2 = drip_rand*1000000 - math.floor(drip_rand*1000000/4)*4
		local height = math.floor(drip_rand/0.025 * 4)
		subterrane:stalagmite(vi, area, data, param2_data, param2, height, false)
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
		subterrane:stalagmite(vi, area, data, param2_data, param2, -height, false)
	end	
end

-- default mapgen registers an "underground" biome that gets in the way of everything.
subterrane:override_biome({
	name = "underground",
	y_min = dfcaverns.config.ymax,
	y_max = -113,
	heat_point = 50,
	humidity_point = 50,
	_subterrane_cave_floor_decor = shallow_cave_floor,
	_subterrane_cave_ceiling_decor = shallow_cave_ceiling,
})

subterrane:register_cave_decor(-113, dfcaverns.config.ymax)

subterrane:register_cave_layer({
	minimum_depth = dfcaverns.config.ymax,
	maximum_depth = dfcaverns.config.level1_min,
})

subterrane:register_cave_layer({
	minimum_depth = dfcaverns.config.level1_min,
	maximum_depth = dfcaverns.config.level2_min,
})

subterrane:register_cave_layer({
	minimum_depth = dfcaverns.config.level2_min,
	maximum_depth = dfcaverns.config.level3_min,
})

subterrane:register_cave_layer({
	minimum_depth = dfcaverns.config.level3_min,
	maximum_depth = dfcaverns.config.lava_sea_min,
})

subterrane:register_cave_layer({
	minimum_depth = dfcaverns.config.lava_sea_min,
	maximum_depth = dfcaverns.config.ymin,
})

dfcaverns.can_support_vegetation = {[c_sand] = true, [c_dirt] = true, [c_coal_ore] = true, [c_gravel] = true}

dfcaverns.place_shrub = function(data, vi, param2_data)
	local shrub = math.random(1,8)
	if shrub == 1 then
		data[vi] = c_sweet_pod
		param2_data[vi] = 0
	elseif shrub == 2 then
		data[vi] = c_quarry_bush
		param2_data[vi] = 4
	elseif shrub == 3 then
		data[vi] = c_plump_helmet
		param2_data[vi] = math.random(0,3)
	elseif shrub == 4 then
		data[vi] = c_pig_tail
		param2_data[vi] = 3
	elseif shrub == 5 then
		data[vi] = c_dimple_cup
		param2_data[vi] = 0
	elseif shrub == 6 then
		data[vi] = c_cave_wheat
		param2_data[vi] = 3
	elseif shrub == 7 then
		data[vi] = c_dead_fungus
		param2_data[vi] = 0
	elseif shrub == 8 then
		data[vi] = c_cavern_fungi
		param2_data[vi] = 0
	end	
end