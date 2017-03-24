-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local wheat_names = {}

local register_cave_wheat = function(number)
	local def = {
		description = S("Cave Wheat"),
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 3,
		tiles = {"dfcaverns_cave_wheat_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_cave_wheat_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
		drop = {
			max_items = 1,
			items = {
				{
					items = {'dfcaverns:cave_wheat_seed 2', 'dfcaverns:cave_wheat'},
					rarity = 9-number,
				},
				{
					items = {'dfcaverns:cave_wheat_seed 1', 'dfcaverns:cave_wheat'},
					rarity = 9-number,
				},
				{
					items = {'dfcaverns:cave_wheat_seed'},
					rarity = 9-number,
				},
			},
		},
	}
	
	if number < 8 then
		def._dfcaverns_next_stage = "dfcaverns:cave_wheat_"..tostring(number+1)
		table.insert(wheat_names, "dfcaverns:cave_wheat_"..tostring(number))
	end

	minetest.register_node("dfcaverns:cave_wheat_"..tostring(number), def)
end

for i = 1,8 do
	register_cave_wheat(i)
end

dfcaverns.register_seed("cave_wheat_seed", S("Cave Wheat Seed"), "dfcaverns_cave_wheat_seed.png", "dfcaverns:cave_wheat_1")
table.insert(wheat_names, "dfcaverns:cave_wheat_seed")

dfcaverns.register_grow_abm(wheat_names, dfcaverns.config.plant_growth_timer * dfcaverns.config.cave_wheat_timer_multiplier, dfcaverns.config.plant_growth_chance)

minetest.register_craftitem("dfcaverns:cave_wheat", {
	description = S("Cave Wheat"),
	inventory_image = "dfcaverns_cave_wheat.png",
	stack_max = 99,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:cave_wheat",
	burntime = 2
})

minetest.register_craftitem("dfcaverns:cave_flour", {
	description = S("Cave Wheat Flour"),
	inventory_image = "dfcaverns_flour.png",
	groups = {flammable = 1, dfcaverns_cookable = 1},
})

minetest.register_craftitem("dfcaverns:cave_bread", {
	description = S("Dwarven Bread"),
	inventory_image = "dfcaverns_bread.png",
	on_use = minetest.item_eat(5),
	groups = {flammable = 2},
})

if minetest.get_modpath("cottages") then
	cottages.handmill_product["dfcaverns:cave_wheat"] = "dfcaverns:cave_flour";
else
minetest.register_craft({
	type = "shapeless",
	output = "dfcaverns:cave_flour",
	recipe = {"dfcaverns:cave_wheat", "dfcaverns:cave_wheat", "dfcaverns:cave_wheat", "dfcaverns:cave_wheat"}
})
end

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "dfcaverns:cave_bread",
	recipe = "dfcaverns:cave_flour"
})
