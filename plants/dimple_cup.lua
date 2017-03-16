local dimple_names = {}

local register_dimple_cup = function(number)
	local def = {
		description = S("Dimple Cup"),
		drawtype = "plantlike",
		tiles = {"dfcaverns_dimple_cup_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_dimple_cup_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
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
		def._dfcaverns_next_stage = "dfcaverns:dimple_cup_"..tostring(number+1)
		table.insert(dimple_names, "dfcaverns:dimple_cup_"..tostring(number))
	end
	
	minetest.register_node("dfcaverns:dimple_cup_"..tostring(number), def)
end

for i = 1,4 do
	register_dimple_cup(i)
end

dfcaverns.register_seed("dimple_cup_seed", S("Dimple Cup Spores"), "dfcaverns_dimple_cup_seed.png", "dfcaverns:dimple_cup_1")
table.insert(dimple_names, "dfcaverns:dimple_cup_seed")

dfcaverns.register_grow_abm(dimple_names, 10, 1)
