--------------------------------------------------
-- Spore Tree

-- Teal
-- raining spores
-- Max trunk height 	5
-- depth 2-3

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("dfcaverns:spore_tree", {
	description = S("Spore Tree"),
	tiles = {"dfcaverns_spore_tree_top.png", "dfcaverns_spore_tree_top.png", "dfcaverns_spore_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node,
	
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		minetest.set_node(pos, {name="air"})
		minetest.spawn_tree(pos, dfcaverns.spore_tree_model)
	end,
	
})

minetest.register_node("dfcaverns:spore_tree_frond", {
	description = S("Spore Tree Frond"),
	waving = 1,
	tiles = {"dfcaverns_spore_tree.png"},
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	walkable = false,
	climbable = true,
	
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625},
			{-0.0625, -0.0625, -0.5, 0.0625, 0.0625, 0.5},
			{-0.5, -0.0625, -0.0625, 0.5, 0.0625, 0.0625},
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})

minetest.register_node("dfcaverns:spore_tree_pod", {
	description = S("Spore Tree Fruiting Body"),
	waving = 1,
	tiles = {"dfcaverns_spore_tree.png"},
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	walkable = false,
	climbable = true,
	
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}, 
			{-0.0625, -0.0625, -0.5, 0.0625, 0.0625, 0.5}, 
			{-0.5, -0.0625, -0.0625, 0.5, 0.0625, 0.0625}, 
			{-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
		}
	},
	
	drop = {
		max_items = 1,
		items = {
			{
				items = {'dfcaverns:spore_tree_sapling'},
				rarity = 10,
			},
			{
				items = {'dfcaverns:spore_tree_frond'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})


minetest.register_node("dfcaverns:spore_tree_sapling", {
	description = S("Spore Tree Spawn"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"dfcaverns_spore_tree_sapling.png"},
	inventory_image = "dfcaverns_spore_tree_sapling.png",
	wield_image = "dfcaverns_spore_tree_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(dfcaverns.config.spore_tree_min_growth_delay,dfcaverns.config.spore_tree_max_growth_delay))
	end,
	
	on_timer = function(pos)
		minetest.set_node(pos, {name="air"})
		minetest.spawn_tree(pos, dfcaverns.spore_tree_def)
	end,
})

dfcaverns.spore_tree_def={
	axiom="TTdddA",
	rules_a="[&&&Tdd&&FF][&&&++++Tdd&&FF][&&&----Tdd&&FF]",
	rules_d="T",
	trunk="dfcaverns:spore_tree",
	leaves="dfcaverns:spore_tree_frond",
	leaves2="dfcaverns:spore_tree_pod",
	leaves2_chance=30,
	angle=30,
	iterations=2,
	random_level=0,
	trunk_type="single",
	thin_branches=true,
}

dfcaverns.spawn_spore_tree = function(pos)
	minetest.spawn_tree(pos, dfcaverns.spore_tree_def)
end

minetest.register_abm{
	label = "spore tree raining spores",
	nodenames = {"dfcaverns:spore_tree_pod"},
	interval = 1,
	chance = 30,
	catch_up = false,
	action = function(pos)
		minetest.add_particlespawner({
			amount = 1,
			time = 1,
			minpos = pos,
			maxpos = pos,
			minvel = {x=-0.1, y=-1, z=-0.1},
			maxvel = {x=0.1, y=-1, z=0.1},
			minacc = {x=0, y=0, z=0},
			maxacc = {x=0, y=0, z=0},
			minexptime = 3,
			maxexptime = 3,
			minsize = 10,
			maxsize = 10,
			collisiondetection = false,
			vertical = false,
			texture = "farming_wheat_seed.png",
		})
		
	end,
}
