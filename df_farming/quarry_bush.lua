-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local quarry_grow_time = df_farming.config.plant_growth_time * df_farming.config.quarry_bush_delay_multiplier / 5

local register_quarry_bush = function(number)
	local name = "df_farming:quarry_bush_"..tostring(number)
	local def = {
		description = S("Quarry Bush"),
		_doc_items_longdesc = df_farming.doc.quarry_bush_desc,
		_doc_items_usagehelp = df_farming.doc.quarry_bush_usage,
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 4,
		tiles = {"dfcaverns_quarry_bush_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_quarry_bush_"..tostring(number)..".png",
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
			max_items = 2,
			items = {
				{
					items = {'df_farming:quarry_bush_seed 2', 'df_farming:quarry_bush_leaves 2'},
					rarity = 6-number,
				},
				{
					items = {'df_farming:quarry_bush_seed 1', 'df_farming:quarry_bush_leaves'},
					rarity = 6-number,
				},
				{
					items = {'df_farming:quarry_bush_seed'},
					rarity = 6-number,
				},
			},
		},
	}

	if number < 5 then
		def._dfcaverns_next_stage_time = quarry_grow_time
		def._dfcaverns_next_stage = "df_farming:quarry_bush_"..tostring(number+1)
	end

	minetest.register_node(name, def)
end

for i = 1,5 do
	register_quarry_bush(i)
end

df_farming.register_seed(
	"quarry_bush_seed",
	S("Rock Nuts"),
	"dfcaverns_rock_nuts.png",
	"df_farming:quarry_bush_1",
	quarry_grow_time,
	df_farming.doc.quarry_bush_desc,
	df_farming.doc.quarry_bush_usage
)

minetest.register_craftitem("df_farming:quarry_bush_leaves", {
	description = S("Quarry Bush Leaves"),
	_doc_items_longdesc = df_farming.doc.quarry_bush_leaves_desc,
	_doc_items_usagehelp = df_farming.doc.quarry_bush_leaves_usage,
	inventory_image = "dfcaverns_quarry_bush_leaves.png",
	groups = {dfcaverns_cookable = 1},
	stack_max = 99,
})
minetest.register_craft({
	type = "fuel",
	recipe = "df_farming:quarry_bush_leaves",
	burntime = 4
})
