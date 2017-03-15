--------------------------------------------------
-- Tunnel tube

-- Magenta
-- curving trunk
-- Max trunk height 	8
-- depth 2-3

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("dfcaverns:tunnel_tube", {
	description = S("Tunnel Tube"),
	tiles = {"dfcaverns_tunnel_tube.png"},
	paramtype2 = "facedir",
	drawtype = "nodebox",
	paramtype = "light",
	groups = {choppy = 3, oddly_breakable_by_hand=1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	
	node_box = {
		type = "fixed",
		fixed = {
			{-8/16,-8/16,-8/16,-4/16,8/16,8/16},
			{4/16,-8/16,-8/16,8/16,8/16,8/16},
			{-4/16,-8/16,-8/16,4/16,8/16,-4/16},
			{-4/16,-8/16,8/16,4/16,8/16,4/16},
		},
	},
})

minetest.register_node("dfcaverns:tunnel_tube_fruiting_body", {
	description = S("Tunnel Tube Fruiting Body"),
	tiles = {"dfcaverns_tunnel_tube.png^[brighten"},
	paramtype2 = "facedir",
	groups = {choppy = 3, oddly_breakable_by_hand=1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	
	drop = {
		max_items = 3,
		items = {
			{
				items = {'dfcaverns:tunnel_tube_sapling'},
				rarity = 2,
			},
			{
				items = {'dfcaverns:tunnel_tube_sapling'},
				rarity = 2,
			},
			{
				items = {'dfcaverns:tunnel_tube_sapling'},
				rarity = 2,
			},
		}
	},
})

dfcaverns.tunnel_tube_def = {
	axiom="FFcccccc&FFFFFdddR",
	rules_c="/",
	rules_d="F",
	trunk="dfcaverns:tunnel_tube",
	angle=20,
	iterations=2,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
	fruit="dfcaverns:tunnel_tube_fruiting_body",
	fruit_chance=0
}

minetest.register_node("dfcaverns:tunnel_tube_sapling", {
	description = S("Tunnel Tube Spawn"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"dfcaverns_tunnel_tube_sapling.png"},
	inventory_image = "dfcaverns_tunnel_tube_sapling.png",
	wield_image = "dfcaverns_tunnel_tube_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1, light_sensitive_fungus = 11},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(dfcaverns.config.tunnel_tube_min_growth_delay,dfcaverns.config.tunnel_tube_max_growth_delay))
	end,
	
	on_timer = function(pos)
		minetest.set_node(pos, {name="air"})
		minetest.spawn_tree(pos, dfcaverns.tunnel_tube_def)
	end,
})

dfcaverns.spawn_tunnel_tube = function(pos)
	minetest.spawn_tree(pos, dfcaverns.tunnel_tube_def)
end