local pig_tail_names = {}

local register_pig_tail = function(number)
	local def = {
		description = S("Pig Tail"),
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 3,
		tiles = {"dfcaverns_pig_tail_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_pig_tail_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
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
		def._dfcaverns_next_stage = "dfcaverns:pig_tail_"..tostring(number+1)
		table.insert(pig_tail_names, "dfcaverns:pig_tail_"..tostring(number))
	end
	
	minetest.register_node("dfcaverns:pig_tail_"..tostring(number), def)
end

for i = 1,8 do
	register_pig_tail(i)
end

dfcaverns.register_seed("pig_tail_seed", S("Pig Tail Spore"), "dfcaverns_pig_tail_seed.png", "dfcaverns:pig_tail_1")
table.insert(pig_tail_names, "dfcaverns:pig_tail_seed")

dfcaverns.register_grow_abm(pig_tail_names, 10, 1)

minetest.register_craftitem("dfcaverns:pig_tail_thread", {
	description = S("Pig tail thread"),
	inventory_image = "dfcaverns_pig_tail_thread.png",
	groups = {flammable = 1},
})

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:pig_tail_thread",
	burntime = 1,
})

