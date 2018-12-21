-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local invulnerable = df_mapitems.config.invulnerable_slade and not minetest.settings:get_bool("creative_mode")

local add_immortality = function(slade_def)
	slade_def.groups.immortal = 1
	slade_def.groups.cracky = nil
	--slade_def.on_destruct = function() end
	--slade_def.can_dig = function(pos, player) return minetest.settings:get_bool("creative_mode") == true end
	--slade_def.diggable = false
	--slade_def.on_blast = function() end
	return slade_def
end

local slade_def = {
	description = S("Slade"),
	_doc_items_longdesc = df_mapitems.doc.slade_desc,
	_doc_items_usagehelp = df_mapitems.doc.slade_usage,
	tiles = {"dfcaverns_slade.png"},
	groups = {cracky=3, stone=1, level=3},
	sounds = default.node_sound_stone_defaults({ footstep = { name = "bedrock2_step", gain = 1 } }),
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
	_doc_items_longdesc = df_mapitems.doc.slade_desc,
	_doc_items_usagehelp = df_mapitems.doc.slade_usage,
	tiles = {"dfcaverns_slade_brick.png"},
	groups = { cracky=3, stone=1, level=3 },
	sounds = default.node_sound_stone_defaults({ footstep = { name = "bedrock2_step", gain = 1 } }),
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
	groups = { cracky=3, stone=1, level=3 },
	sounds = default.node_sound_stone_defaults({ footstep = { name = "bedrock2_step", gain = 1 } }),
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
	_doc_items_longdesc = df_mapitems.doc.slade_desc,
	_doc_items_usagehelp = df_mapitems.doc.slade_usage,
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

local slade_block_def = {
	description = S("Slade Block"),
	_doc_items_longdesc = df_mapitems.doc.slade_desc,
	_doc_items_usagehelp = df_mapitems.doc.slade_usage,
	tiles = {"dfcaverns_slade_block.png"},
	groups = {cracky=3, stone=1, level=3},
	sounds = default.node_sound_stone_defaults({ footstep = { name = "bedrock2_step", gain = 1 } }),
	is_ground_content = false,
}
if invulnerable then
	add_immortality(slade_block_def)
	slade_block_def.on_blast = function() end
end
minetest.register_node("df_mapitems:slade_block", slade_block_def)


local slade_seal_def = {
	description = S("Slade Seal"),
	_doc_items_longdesc = df_mapitems.doc.slade_desc,
	_doc_items_usagehelp = df_mapitems.doc.slade_usage,
	tiles = {"dfcaverns_slade_block.png^dfcaverns_seal.png", "dfcaverns_slade_block.png"},
	groups = {cracky=3, stone=1, level=3},
	sounds = default.node_sound_stone_defaults({ footstep = { name = "bedrock2_step", gain = 1 } }),
	is_ground_content = false,
}
if invulnerable then
	slade_seal_def.on_blast = function() end
	add_immortality(slade_seal_def)
end
minetest.register_node("df_mapitems:slade_seal", slade_seal_def)



minetest.register_abm{
	label = "slade seal scratching",
	nodenames = {"df_mapitems:slade_seal"},
	interval = 1,
	chance = 100,
	catch_up = false,
	action = function(pos)
		minetest.sound_play({name="dfcaverns_grinding_stone"},
		{
			pos = pos,
			gain = 0.05,
			max_hear_distance = 32,
		}
	)
	end,
}


-- Register stair and slab

if minetest.get_modpath("stairs") then
	local stair_groups = {level = 3}
	if invulnerable then
		stair_groups.immortal = 1
	else
		stair_groups.cracky = 3
	end

	stairs.register_stair_and_slab(
		"slade_brick",
		"df_mapitems:slade_brick",
		stair_groups,
		{"dfcaverns_slade_brick.png"},
		S("Slade Stair"),
		S("Slade Slab"),
		default.node_sound_stone_defaults({ footstep = { name = "bedrock2_step", gain = 1 } })
	)
end

if minetest.get_modpath("mesecons_mvps") and df_mapitems.config.invulnerable_slade then
	mesecon.register_mvps_stopper("df_mapitems:slade")
end