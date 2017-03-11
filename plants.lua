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
	groups = {flammable=4, oddly_diggable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
	},
})


--------------------------------------------------
-- Cave wheat

-- stalks. White

farming.register_plant("dfcaverns:cave_wheat", {
	description = "Cave wheat seed",
	paramtype2 = "meshoptions",
	inventory_image = "dfcaverns_cave_wheat_seed.png",
	steps = 8,
	minlight = 0,
	maxlight = 8,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
	place_param2 = 3,
})

--------------------------------------------------
-- Dimple cup

-- royal blue

--------------------------------------------------
-- Pig tail

-- Twisting stalks. Gray

--------------------------------------------------
-- Plump helmet

-- Purple, rounded tops

--------------------------------------------------
-- Quarry Bush

-- Gray leaves
-- Produces rock nuts

--------------------------------------------------
-- Sweet Pod

-- Round shape, red
