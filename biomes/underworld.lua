local c_water = minetest.get_content_id("default:water_source")
local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_cobble = minetest.get_content_id("default:cobble")
local c_dirt = minetest.get_content_id("default:dirt")
local c_sand = minetest.get_content_id("default:sand")
local c_lava = minetest.get_content_id("default:lava_source")

local c_dirt_moss = minetest.get_content_id("dfcaverns:dirt_with_cave_moss")
local c_cobble_fungus = minetest.get_content_id("dfcaverns:cobble_with_floor_fungus")
local c_dead_fungus = minetest.get_content_id("dfcaverns:dead_fungus") -- param2 = 0
local c_cavern_fungi = minetest.get_content_id("dfcaverns:cavern_fungi") -- param2 = 0

-------------------------------------------------------------------------------------------


minetest.register_biome({
	name = "dfcaverns_underworld",
	y_min = dfcaverns.config.ymin,
	y_max = dfcaverns.config.lava_sea_min,
	heat_point = 50,
	humidity_point = 50,	
})

