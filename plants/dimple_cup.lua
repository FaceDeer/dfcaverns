-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local dimple_grow_time = dfcaverns.config.plant_growth_time * dfcaverns.config.dimple_cup_delay_multiplier / 4

local register_dimple_cup = function(number)
	local name = "dfcaverns:dimple_cup_"..tostring(number)
	local def = {
		description = S("Dimple Cup"),
		_doc_items_longdesc = dfcaverns.doc.dimple_cup_desc,
		_doc_items_usagehelp = dfcaverns.doc.dimple_cup_usage,
		drawtype = "plantlike",
		tiles = {"dfcaverns_dimple_cup_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_dimple_cup_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, color_blue = 1, light_sensitive_fungus = 11, flower = 1},
		sounds = default.node_sound_leaves_defaults(),
		
		on_timer = function(pos, elapsed)
			dfcaverns.grow_underground_plant(pos, name, elapsed)
		end,
		
		drop = {
			max_items = 1,
			items = {
				{
					items = {'dfcaverns:dimple_cup_seed 2', 'dfcaverns:dimple_cup_4'},
					rarity = 7-number,
				},
				{
					items = {'dfcaverns:dimple_cup_seed 1', 'dfcaverns:dimple_cup_4'},
					rarity = 5-number,
				},
			},
		},
	}
	
	if number < 4 then
		def._dfcaverns_next_stage_time = dimple_grow_time
		def._dfcaverns_next_stage = "dfcaverns:dimple_cup_"..tostring(number+1)
	end
	
	minetest.register_node(name, def)
end

for i = 1,4 do
	register_dimple_cup(i)
end

dfcaverns.register_seed(
	"dimple_cup_seed",
	S("Dimple Cup Spores"),
	"dfcaverns_dimple_cup_seed.png",
	"dfcaverns:dimple_cup_1",
	dimple_grow_time,
	dfcaverns.doc.dimple_cup_desc,
	dfcaverns.doc.dimple_cup_usage)
