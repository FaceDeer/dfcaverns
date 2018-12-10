-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local invulnerable = df_mapitems.config.invulnerable_slade or minetest.settings:get_bool("creative_mode")

local add_immortality = function(slade_def)
	slade_def.groups.immortal = 1
	slade_def.groups.cracky = nil
	slade_def.on_destruct = function() end
	slade_def.can_dig = function(pos, player) return minetest.settings:get_bool("creative_mode") == true end
	slade_def.diggable = false
	--slade_def.on_blast = function() end
	return slade_def
end

local slade_def = {
	description = S("Slade"),
	tiles = {"dfcaverns_slade.png"},
	groups = {cracky=3, stone=1, level=3},
	sounds = { footstep = { name = "bedrock2_step", gain = 1 } },
	is_ground_content = false,
	on_blast = function(pos, intensity)
		if intensity > 3.0 then
			minetest.set_node(pos, {name="df_mapitems:slade_sand"})
			minetest.check_for_falling(pos)
		end
	end,
}
if invulnerable then
	add_immortality(slade_def)
end
minetest.register_node("df_mapitems:slade", slade_def)

local slade_brick_def = {
	description = S("Slade Brick"),
	tiles = {"dfcaverns_slade_brick.png"},
	groups = {immortal=1, stone=1, },
	sounds = { footstep = { name = "bedrock2_step", gain = 1 } },
	is_ground_content = false,
	on_blast = function(pos, intensity)
		if intensity > 4.0 then
			minetest.set_node(pos, {name="df_mapitems:slade_sand"})
			minetest.check_for_falling(pos)
		end
	end,
}
if invulnerable then
	add_immortality(slade_brick_def)
end
minetest.register_node("df_mapitems:slade_brick", slade_brick_def)

local slade_wall_def = {
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
	tiles = {"dfcaverns_slade_brick.png"},
	walkable = true,
	groups = { stone=1, },
	sounds = { footstep = { name = "bedrock2_step", gain = 1 } },
	on_blast = function(pos, intensity)
		if intensity > 3.0 then
			minetest.set_node(pos, {name="df_mapitems:slade_sand"})
			minetest.check_for_falling(pos)
		end
	end,
}
if invulnerable then
	add_immortality(slade_wall_def)
end
minetest.register_node("df_mapitems:slade_wall", slade_wall_def)


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

--if minetest.get_modpath("moreblocks") then
--	stairsplus:register_all(
--		"df_mapitems", "slade_brick", "df_mapitems:slade_brick", {
--			description = S("Slade Brick"),
--			groups = {cracky = 2, level = 2},
--			tiles = {"dfcaverns_slade_brick.png"},
--			sounds = default.node_sound_stone_defaults(),
--			can_dig = function(pos, player)
--				return minetest.settings:get_bool("creative_mode")
--			end,
--	})
--end

if minetest.get_modpath("mesecons_mvps") ~= nil then
	mesecon.register_mvps_stopper("bedrock2:bedrock")
end