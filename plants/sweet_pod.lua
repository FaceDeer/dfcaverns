-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local sweet_names = {}

local register_sweet_pod = function(number)
	local def = {
		description = S("Sweet Pod"),
		drawtype = "plantlike",
		tiles = {"dfcaverns_sweet_pod_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_sweet_pod_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),

		drop = {
			max_items = 2,
			items = {
				{
					items = {'dfcaverns:sweet_pod_seed 2', 'dfcaverns:sweet_pods 2'},
					rarity = 7-number,
				},
				{
					items = {'dfcaverns:sweet_pod_seed', 'dfcaverns:sweet_pods'},
					rarity = 7-number,
				},
				{
					items = {'dfcaverns:sweet_pod_seed'},
					rarity = 7-number,
				},
			},
		},
	}
	
	if number < 6 then
		def._dfcaverns_next_stage = "dfcaverns:sweet_pod_"..tostring(number+1)
		table.insert(sweet_names, "dfcaverns:sweet_pod_"..tostring(number))
	end
	
	minetest.register_node("dfcaverns:sweet_pod_"..tostring(number), def)
end

for i = 1,6 do
	register_sweet_pod(i)
end

dfcaverns.register_seed("sweet_pod_seed", S("Sweet Pod Spores"), "dfcaverns_sweet_pod_seed.png", "dfcaverns:sweet_pod_1")
table.insert(sweet_names, "dfcaverns:sweet_pod_seed")

dfcaverns.register_grow_abm(sweet_names, dfcaverns.config.plant_growth_timer * dfcaverns.config.sweet_pod_timer_multiplier, dfcaverns.config.plant_growth_chance)

minetest.register_craftitem("dfcaverns:sweet_pods", {
	description = S("Sweet Pods"),
	inventory_image = "dfcaverns_sweet_pods.png",
	stack_max = 99,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:sweet_pods",
	burntime = 4
})