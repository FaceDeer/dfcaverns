-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local pig_tail_grow_time = dfcaverns.config.plant_growth_time * dfcaverns.config.pig_tail_delay_multiplier / 8

local register_pig_tail = function(number)
	local name = "dfcaverns:pig_tail_"..tostring(number)
	local def = {
		description = S("Pig Tail"),
		_doc_items_longdesc = dfcaverns.doc.pig_tail_desc,
		_doc_items_usagehelp = dfcaverns.doc.pig_tail_usage,
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 3,
		tiles = {"dfcaverns_pig_tail_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_pig_tail_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
		
		on_timer = function(pos, elapsed)
			dfcaverns.grow_underground_plant(pos, name, elapsed)
		end,
		
		drop = {
			max_items = 1,
			items = {
				{
					items = {'dfcaverns:pig_tail_seed 2', 'dfcaverns:pig_tail_thread 2'},
					rarity = 9-number,
				},
				{
					items = {'dfcaverns:pig_tail_seed 1', 'dfcaverns:pig_tail_thread'},
					rarity = 9-number,
				},
				{
					items = {'dfcaverns:pig_tail_seed'},
					rarity = 9-number,
				},
			},
		},
	}
	
	if number < 8 then
		def._dfcaverns_next_stage_time = pig_tail_grow_time
		def._dfcaverns_next_stage = "dfcaverns:pig_tail_"..tostring(number+1)
	end
	
	minetest.register_node(name, def)
end

for i = 1,8 do
	register_pig_tail(i)
end

dfcaverns.register_seed(
	"pig_tail_seed",
	S("Pig Tail Spore"),
	"dfcaverns_pig_tail_seed.png",
	"dfcaverns:pig_tail_1",
	pig_tail_grow_time,
	dfcaverns.doc.pig_tail_desc,
	dfcaverns.doc.pig_tail_usage)

minetest.register_craftitem("dfcaverns:pig_tail_thread", {
	description = S("Pig tail thread"),
	_doc_items_longdesc = dfcaverns.doc.pig_tail_thread_desc,
	_doc_items_usagehelp = dfcaverns.doc.pig_tail_thread_usage,
	inventory_image = "dfcaverns_pig_tail_thread.png",
	groups = {flammable = 1, thread = 1},
})

if minetest.get_modpath("wool") then
	minetest.register_craft({
		output = "wool:white",
		recipe = {
			{"group:thread", "group:thread"},
			{"group:thread", "group:thread"},
		}
	})
end

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:pig_tail_thread",
	burntime = 1,
})

