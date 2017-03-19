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
local c_dimple_cup = minetest.get_content_id("dfcaverns_dimple_cup_4") -- param2 = 0
local c_cave_wheat = minetest.get_content_id("dfcaverns:cave_wheat_8") -- param2 = 3
local c_dead_fungus = minetest.get_content_id("dfcaverns:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("dfcaverns:cavern_fungi") -- param2 = 0

local c_dirt_moss = minetest.get_content_id("dfcaverns:dirt_with_cave_moss")
local c_cobble_fungus = minetest.get_content_id("dfcaverns:cobble_with_floor_fungus")

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