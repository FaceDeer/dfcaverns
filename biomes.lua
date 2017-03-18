local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")


local c_sweet_pod = minetest.get_content_id("dfcaverns:sweet_pod_6") -- param2 = 0
local c_quarry_bush = minetest.get_content_id("dfcaverns:quarry_bush_5") -- param2 = 4
local c_plump_helmet = minetest.get_content_id("dfcaverns:plump_helmet_4") -- param2 = 0-3
local c_pig_tail = minetest.get_content_id("dfcaverns:pig_tail_8") -- param2 = 3
local c_dimple_cup = minetest.get_content_id("dfcaverns_dimple_cup_4") -- param2 = 0
local c_cave_wheat = minetest.get_content_id("dfcaverns:cave_wheat_8") -- param2 = 3
local c_dead_fungus = minetest.get_content_id("dfcaverns:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("dfcaverns:cavern_fungi") -- param2 = 0


local c_dirt_moss = minetest.get_content_id("dfcaverns:dirt_with_cave_moss")
local c_dirt = minetest.get_content_id("default:dirt")
local c_cobble = minetest.get_content_id("default:cobble")
local c_cobble_fungus = minetest.get_content_id("dfcaverns:cobble_with_floor_fungus")

--dfcaverns.spawn_tunnel_tube_vm(vi, area, data, param2_data)
--dfcaverns.spawn_tower_cap_vm(vi, area, data)
--dfcaverns.spawn_spore_tree_vm(vi, data, area)
--dfcaverns.spawn_nether_cap_vm(vi, area, data)
--dfcaverns.spawn_goblin_cap_vm(vi, area, data)
--dfcaverns.spawn_fungiwood_vm(vi, area, data)
--dfcaverns.spawn_blood_thorn_vm(vi, area, data, data_param2)

-----------------------------------------------------------------------------------------------------------
-- Coal Dust

local test_biome_floor = function(area, data, ai, vi, bi, param2_data)
	if data[bi] ~= c_stone then
		return
	end
	
	if math.random() < 0.25 then
		data[bi] = c_dirt
	else
		data[bi] = c_dirt_moss
	end
	
	if math.random() < 0.1 then
		--data[vi] = c_plump_helmet
		--param2_data[vi] = math.random(0,3)
		data[vi] = c_cavern_fungi
	elseif subterrane:vertically_consistent_random(vi, area) < 0.002 then
		subterrane:stalagmite(bi, area, data, 6, 15, c_stone, c_stone, c_stone)
	end
end

local test_biome_ceiling = function(area, data, ai, vi, bi)
	if subterrane:vertically_consistent_random(vi, area) < 0.002 then
		subterrane:stalactite(ai, area, data, 6, 20, c_stone, c_stone, c_stone)
	elseif math.random() < 0.03 then
		dfcaverns.glow_worm_ceiling(area, data, ai, vi, bi)
	end
end

-------------------------------------------------------------------------------------------

minetest.register_biome({
	name = "dfcaverns_test_biome",
	y_min = -2000,
	y_max = -300,
	heat_point = 50,
	humidity_point = 50,
	_subterrane_ceiling_decor = test_biome_ceiling,
	_subterrane_floor_decor = test_biome_floor,
	_subterrane_fill_node = c_air,
})
