-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local quarry_grow_time = dfcaverns.config.plant_growth_time * dfcaverns.config.quarry_bush_delay_multiplier / 5

local register_quarry_bush = function(number)
	local name = "dfcaverns:quarry_bush_"..tostring(number)
	local def = {
		description = S("Quarry Bush"),
		_doc_items_longdesc = dfcaverns.doc.quarry_bush_desc,
		_doc_items_usagehelp = dfcaverns.doc.quarry_bush_usage,
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 4,
		tiles = {"dfcaverns_quarry_bush_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_quarry_bush_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),

		on_timer = function(pos, elapsed)
			dfcaverns.grow_underground_plant(pos, name, elapsed)
		end,

		drop = {
			max_items = 2,
			items = {
				{
					items = {'dfcaverns:quarry_bush_seed 2', 'dfcaverns:quarry_bush_leaves 2'},
					rarity = 6-number,
				},
				{
					items = {'dfcaverns:quarry_bush_seed 1', 'dfcaverns:quarry_bush_leaves'},
					rarity = 6-number,
				},
				{
					items = {'dfcaverns:quarry_bush_seed'},
					rarity = 6-number,
				},
			},
		},
	}

	if number < 5 then
		def._dfcaverns_next_stage_time = quarry_grow_time
		def._dfcaverns_next_stage = "dfcaverns:quarry_bush_"..tostring(number+1)
	end

	minetest.register_node(name, def)
end

for i = 1,5 do
	register_quarry_bush(i)
end

dfcaverns.register_seed(
	"quarry_bush_seed",
	S("Rock Nuts"),
	"dfcaverns_rock_nuts.png",
	"dfcaverns:quarry_bush_1",
	quarry_grow_time,
	dfcaverns.doc.quarry_bush_desc,
	dfcaverns.doc.quarry_bush_usage
)

minetest.register_craftitem("dfcaverns:quarry_bush_leaves", {
	description = S("Quarry Bush Leaves"),
	_doc_items_longdesc = dfcaverns.doc.quarry_bush_leaves_desc,
	_doc_items_usagehelp = dfcaverns.doc.quarry_bush_leaves_usage,
	inventory_image = "dfcaverns_quarry_bush_leaves.png",
	groups = {dfcaverns_cookable = 1},
	stack_max = 99,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:quarry_bush_leaves",
	burntime = 4
})
