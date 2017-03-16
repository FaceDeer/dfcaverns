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
		groups = {flammable=4, oddly_breakable_by_hand=1, light_sensitive_fungus = 11},
		sounds = default.node_sound_leaves_defaults(),
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

dfcaverns.register_grow_abm(sweet_names, 10, 1)
