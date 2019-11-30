-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local get_formspec = function(pos, completion)
	completion = completion or 0.5
	local formspec = 
		"size[10,10]"
		.."list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";main;1,1;3,3;]"
		.."container[5,0.5]"
		.."box[0,0;1,5;#0A0000]box[0.1,0.1;0.8,4.8;#000000]box[0.1," .. 0.1 + 4.8*completion ..";0.8,".. 4.8*completion ..";#FFCC22]"
		.."container_end[]"
		.."container[1,5.75]list[current_player;main;0,0;8,1;]listring[]"
		.."list[current_player;main;0,1.25;8,3;8]container_end[]"
	return formspec
end

local ensure_inventory = function(pos)
    local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	inv:set_size("main", 3*3)
end

local puzzle_seal_def = {
	description = S("Slade Puzzle Seal"),
	_doc_items_longdesc = nil,
	_doc_items_usagehelp = nil,
	drawtype = "mesh",
	mesh = "underworld_seal.obj",
	tiles = {"dfcaverns_slade_block.png", "dfcaverns_slade_block.png^dfcaverns_seal.png", "dfcaverns_slade_block.png"},
	paramtype = "light",
	light_source = 12,
	groups = {immortal=1, stone=1, level=3, slade=1, cracky=1, pit_plasma_resistant=1, mese_radiation_shield=1, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults({ footstep = { name = "bedrock2_step", gain = 1 } }),
		selection_box = {
		type = "fixed",
		fixed = {-0.625, -0.625, -0.625, 0.625, 0.625, 0.625},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.625, -0.625, -0.625, 0.625, 0.625, 0.625},
	},
	is_ground_content = false,
	on_blast = function() end,
	on_construct = function(pos)
	    ensure_inventory(pos)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		--ensure_inventory(pos) -- needed because mapgen doesn't call on_construct
		local player_name = clicker:get_player_name()
		minetest.show_formspec(player_name, "df_underworld_items_puzzle_seal:"..minetest.pos_to_string(pos)..":"..player_name, get_formspec(pos))
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
	end,
}

if minetest.get_modpath("stairs") then
	local stair_groups = {level = 3, mese_radiation_shield=1, pit_plasma_resistant=1, slade=1}
	if invulnerable then
		stair_groups.immortal = 1
	else
		stair_groups.cracky = 3
	end

	stairs.register_stair(
		"slade_block",
		"df_underworld_items:slade_block",
		stair_groups,
		{"dfcaverns_slade_block.png"},
		S("Slade Block Stair"),
		default.node_sound_stone_defaults({ footstep = { name = "bedrock2_step", gain = 1 } })
	)
end

minetest.register_node("df_underworld_items:puzzle_seal", puzzle_seal_def)
