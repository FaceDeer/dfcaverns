-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("df_mapitems:slade", {
	description = S("Slade"),
	tiles = {"dfcaverns_slade.png"},
	is_ground_content = true,
	groups = {cracky = 3, level = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
	can_dig = function(pos, player)
		return minetest.settings:get_bool("creative_mode")
	end,
})

minetest.register_node("df_mapitems:slade_sand", {
	description = S("Slade Sand"),
	tiles = {"dfcaverns_slade_sand.png"},
	is_ground_content = true,
	groups = {crumbly = 3, level = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults({
		footstep = {name = "default_gravel_footstep", gain = 0.45},
	}),
	can_dig = function(pos, player)
		return minetest.settings:get_bool("creative_mode")
	end,
})

minetest.register_node("df_mapitems:slade_brick", {
	description = S("Slade Brick"),
	tiles = {"dfcaverns_slade_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2, level = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
	can_dig = function(pos, player)
		return minetest.settings:get_bool("creative_mode")
	end,
})

minetest.register_node("df_mapitems:slade_wall",
{
	description = S("Slade Wall"),
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4}},
		-- connect_bottom =
		connect_front = {{-3/16, -1/2, -1/2,  3/16, 3/8, -1/4}},
		connect_left = {{-1/2, -1/2, -3/16, -1/4, 3/8,  3/16}},
		connect_back = {{-3/16, -1/2,  1/4,  3/16, 3/8,  1/2}},
		connect_right = {{ 1/4, -1/2, -3/16,  1/2, 3/8,  3/16}},
	},
	connects_to = { "group:wall", "group:stone", "group:fence" },
	paramtype = "light",
	is_ground_content = false,
	tiles = {"dfcaverns_slade_brick.png"},
	walkable = true,
	groups = { cracky = 3, wall = 1, stone = 2 },
	sounds = default.node_sound_stone_defaults(),
	can_dig = function(pos, player)
		return minetest.settings:get_bool("creative_mode")
	end,
})


-- Register stair and slab

--if minetest.get_modpath("stairs") then
--	stairs.register_stair_and_slab(
--		"slade_brick",
--		"df_mapitems:slade_brick",
--		{cracky = 2, level = 2},
--		{"dfcaverns_slade_brick.png"},
--		S("Slade Stair"),
--		S("Slade Slab"),
--		default.node_sound_stone_defaults()
--	)
--end

-- StairsPlus

if minetest.get_modpath("moreblocks") then
	stairsplus:register_all(
		"df_mapitems", "slade_brick", "df_mapitems:slade_brick", {
			description = S("Slade Brick"),
			groups = {cracky = 2, level = 2},
			tiles = {"dfcaverns_slade_brick.png"},
			sounds = default.node_sound_stone_defaults(),
			can_dig = function(pos, player)
				return minetest.settings:get_bool("creative_mode")
			end,
	})
end