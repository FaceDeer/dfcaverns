local quarry_names = {}

local register_quarry_bush = function(number)
	local def = {
		description = S("Quarry Bush"),
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 4,
		tiles = {"dfcaverns_quarry_bush_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_quarry_bush_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
	
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
		def._dfcaverns_next_stage = "dfcaverns:quarry_bush_"..tostring(number+1)
		table.insert(quarry_names, "dfcaverns:quarry_bush_"..tostring(number))
	end

	minetest.register_node("dfcaverns:quarry_bush_"..tostring(number), def)
end

for i = 1,5 do
	register_quarry_bush(i)
end

dfcaverns.register_seed("quarry_bush_seed", S("Rock Nuts"), "dfcaverns_rock_nuts.png", "dfcaverns:quarry_bush_1")
table.insert(quarry_names, "dfcaverns:quarry_bush_seed")

dfcaverns.register_grow_abm(quarry_names, 10, 1)

minetest.register_craftitem("dfcaverns:quarry_bush_leaves", {
	description = S("Quarry Bush Leaves"),
	inventory_image = "dfcaverns_quarry_bush_leaves.png",
	stack_max = 99,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:quarry_bush_leaves",
	burntime = 4
})
