-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local wheat_grow_time = df_farming.config.plant_growth_time * df_farming.config.cave_wheat_delay_multiplier / 8

local register_cave_wheat = function(number)
	local name = "df_farming:cave_wheat_"..tostring(number)
	local def = {
		description = S("Cave Wheat"),
		_doc_items_longdesc = df_farming.doc.cave_wheat_desc,
		_doc_items_usagehelp = df_farming.doc.cave_wheat_usage,
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 3,
		tiles = {"dfcaverns_cave_wheat_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_cave_wheat_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		floodable = true,
		groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
		
		on_timer = function(pos, elapsed)
			df_farming.grow_underground_plant(pos, name, elapsed)
		end,
		
		drop = {
			max_items = 1,
			items = {
				{
					items = {'df_farming:cave_wheat_seed 2', 'df_farming:cave_wheat'},
					rarity = 9-number,
				},
				{
					items = {'df_farming:cave_wheat_seed 1', 'df_farming:cave_wheat'},
					rarity = 9-number,
				},
				{
					items = {'df_farming:cave_wheat_seed'},
					rarity = 9-number,
				},
			},
		},
	}
	
	if number < 8 then
		def._dfcaverns_next_stage_time = wheat_grow_time
		def._dfcaverns_next_stage = "df_farming:cave_wheat_"..tostring(number+1)
	end

	minetest.register_node(name, def)
end

for i = 1,8 do
	register_cave_wheat(i)
end

local place_list = {
	minetest.get_content_id("df_farming:cave_wheat_1"),
	minetest.get_content_id("df_farming:cave_wheat_2"),
	minetest.get_content_id("df_farming:cave_wheat_3"),
	minetest.get_content_id("df_farming:cave_wheat_4"),
	minetest.get_content_id("df_farming:cave_wheat_5"),
	minetest.get_content_id("df_farming:cave_wheat_6"),
	minetest.get_content_id("df_farming:cave_wheat_7"),
	minetest.get_content_id("df_farming:cave_wheat_8"),
}
-- doesn't set the timer running, so plants placed by this method won't grow
df_farming.spawn_cave_wheat_vm = function(vi, area, data, param2_data)
	data[vi] = place_list[math.random(1,8)]
	param2_data[vi] = 3
end


df_farming.register_seed(
	"cave_wheat_seed",
	S("Cave Wheat Seed"),
	"dfcaverns_cave_wheat_seed.png",
	"df_farming:cave_wheat_1",
	wheat_grow_time,
	df_farming.doc.cave_wheat_desc,
	df_farming.doc.cave_wheat_usage)

minetest.register_craftitem("df_farming:cave_wheat", {
	description = S("Cave Wheat"),
	_doc_items_longdesc = df_farming.doc.cave_wheat_desc,
	_doc_items_usagehelp = df_farming.doc.cave_wheat_usage,
	inventory_image = "dfcaverns_cave_wheat.png",
	stack_max = 99,
})
minetest.register_craft({
	type = "fuel",
	recipe = "df_farming:cave_wheat",
	burntime = 2
})

minetest.register_craftitem("df_farming:cave_flour", {
	description = S("Cave Wheat Flour"),
	_doc_items_longdesc = df_farming.doc.cave_flour_desc,
	_doc_items_usagehelp = df_farming.doc.cave_flour_usage,
	inventory_image = "dfcaverns_flour.png",
	groups = {flammable = 1, dfcaverns_cookable = 1},
})

minetest.register_craftitem("df_farming:cave_bread", {
	description = S("Dwarven Bread"),
	_doc_items_longdesc = df_farming.doc.cave_bread_desc,
	_doc_items_usagehelp = df_farming.doc.cave_bread_usage,
	inventory_image = "dfcaverns_bread.png",
	on_use = minetest.item_eat(5),
	groups = {flammable = 2, food = 5},
})

if minetest.get_modpath("cottages") then
	cottages.handmill_product["df_farming:cave_wheat"] = "df_farming:cave_flour";
else
minetest.register_craft({
	type = "shapeless",
	output = "df_farming:cave_flour",
	recipe = {"df_farming:cave_wheat", "df_farming:cave_wheat", "df_farming:cave_wheat", "df_farming:cave_wheat"}
})
end

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "df_farming:cave_bread",
	recipe = "df_farming:cave_flour"
})
