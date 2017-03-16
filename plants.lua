-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-----------------------------------------------------------------------
-- Plants


minetest.register_node("dfcaverns:dead_fungus", {
	description = S("Dead Fungus"),
	drawtype = "plantlike",
	tiles = {"dfcaverns_dead_fungus.png"},
	inventory_image = "dfcaverns_dead_fungus.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {flammable=4, oddly_breakable_by_hand=1, plant = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:dead_fungus",
	burntime = 2
})

dfcaverns.register_seed = function(name, description, image, stage_one)
	local def = {
		description = description,
		tiles = {image},
		inventory_image = image,
		drawtype = "signlike",
		paramtype2 = "wallmounted",
		groups = {flammable=4, oddly_breakable_by_hand=1},
		_dfcaverns_next_stage = stage_one,
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
	}
	
	minetest.register_node("dfcaverns:"..name, def)
	minetest.register_craft({
		type = "fuel",
		recipe = "dfcaverns:"..name,
		burntime = 1
	})
end

dfcaverns.register_grow_abm = function(names, interval, chance)
	minetest.register_abm({
		nodenames = names,
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			local node_def = minetest.registered_nodes[node.name]
			local next_stage = node_def._dfcaverns_next_stage
			if next_stage then
				local next_def = minetest.registered_nodes[next_stage]
				pos.y = pos.y+1
				minetest.swap_node(pos, {name=next_stage, param2 = next_def.place_param2 or node.param2})
			end
		end
	})
end
