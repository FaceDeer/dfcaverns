-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local invulnerable = df_underworld_items.config.invulnerable_slade and not minetest.settings:get_bool("creative_mode")

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
	paramtype2 = "facedir",
	light_source = 12,
	groups = {stone=1, level=3, slade=1, pit_plasma_resistant=1, mese_radiation_shield=1, not_in_creative_inventory=1},
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
	on_rotate = function() return false end,
	on_construct = function(pos)
	    ensure_inventory(pos)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.get_node_timer(pos):start(1)
		--ensure_inventory(pos) -- needed because mapgen doesn't call on_construct
		--local player_name = clicker:get_player_name()
		--minetest.show_formspec(player_name, "df_underworld_items_puzzle_seal:"..minetest.pos_to_string(pos)..":"..player_name, get_formspec(pos))
	end,
	
	on_timer = function(pos, elapsed)
		local node = minetest.get_node(pos)
		local below_node = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
		if below_node.name == "ignore" then
			minetest.get_node_timer(pos):start(1)
			return
		end
		
		if minetest.get_item_group(below_node.name, "slade") == 0 then
			minetest.set_node(pos, {name="air"})
			return
		end
		
		local rot = node.param2
		if rot == 0 then
			minetest.place_schematic({x=pos.x-3, y=pos.y-2, z=pos.z-3}, df_underworld_items.seal_stair_schem, 0, {}, true)
			node.param2 = 1
		elseif rot == 1 then
			minetest.place_schematic({x=pos.x-3, y=pos.y-2, z=pos.z-3}, df_underworld_items.seal_stair_schem, 90, {}, true)
			node.param2 = 2
		elseif rot == 2 then
			minetest.place_schematic({x=pos.x-3, y=pos.y-2, z=pos.z-3}, df_underworld_items.seal_stair_schem, 180, {}, true)
			node.param2 = 3
		elseif rot == 3 then
			minetest.place_schematic({x=pos.x-3, y=pos.y-2, z=pos.z-3}, df_underworld_items.seal_stair_schem, 270, {}, true)
			node.param2 = 0
		else
			return
		end
		minetest.set_node(pos, {name="air"})
		local newpos = {x=pos.x, y=pos.y-2, z=pos.z}
		minetest.set_node(newpos, node)
		minetest.get_node_timer(newpos):start(1)		
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
	end,
}

if invulnerable then
	puzzle_seal_def.groups.immortal = 1
else
	puzzle_seal_def.groups.cracky = 3
end

minetest.register_node("df_underworld_items:puzzle_seal", puzzle_seal_def)

local n1 = { name = "df_underworld_items:slade_block" }
local n5 = { name = "default:meselamp" }
local n6 = { name = "air", prob = 0 } -- ceiling pieces to leave in place
local n8 = { name = "df_underworld_items:puzzle_seal" }
local n3 = { name = "air"}
local n2 = n3
local n4 = n3
local n7 = n3
local n9 = n3
local n10 = n1
local n11 = n3

if minetest.get_modpath("stairs") then
	local stair_groups = {level = 3, mese_radiation_shield=1, pit_plasma_resistant=1, slade=1}
	if invulnerable then
		stair_groups.immortal = 1
	else
		stair_groups.cracky = 3
	end

	stairs.register_stair_and_slab(
		"slade_block",
		"df_underworld_items:slade_block",
		stair_groups,
		{"dfcaverns_slade_block.png"},
		S("Slade Block Stair"),
		S("Slade Block Slab"),
		default.node_sound_stone_defaults({ footstep = { name = "bedrock2_step", gain = 1 } })
	)
	
	n2 = { name = "stairs:stair_slade_block", param2 = 3 }
	n4 = { name = "stairs:stair_slade_block", param2 = 1 }
	n7 = { name = "stairs:stair_slade_block", param2 = 2 }
	n9 = { name = "stairs:stair_slade_block" }
	n10 = { name = "stairs:slab_slade_block", param2 = 21 }
	n11 = { name = "stairs:slab_slade_block", param2 = 1 }
end

df_underworld_items.seal_temple_schem = {
	size = {y = 6, x = 7, z = 7},
	data = {
		n1, n2, n3, n3, n3, n4, n1, n1, n3, n3, n3, n3, n3, n1, n1, n3, n3, 
		n3, n3, n3, n1, n5, n3, n3, n3, n3, n3, n5, n6, n6, n6, n6, n6, n6, 
		n6, n6, n6, n6, n6, n6, n6, n6, n7, n3, n3, n3, n3, n3, n7, n3, n3, 
		n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, 
		n3, n3, n6, n3, n3, n3, n3, n3, n6, n6, n6, n6, n6, n6, n6, n6, n3, 
		n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, 
		n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n6, n3, n3, n3, n3, n3, n6, 
		n6, n6, n3, n3, n3, n6, n6, n3, n3, n3, n8, n3, n3, n3, n3, n3, n3, 
		n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, 
		n3, n6, n3, n3, n3, n3, n3, n6, n6, n6, n3, n3, n3, n6, n6, n3, n3, 
		n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, 
		n3, n3, n3, n3, n3, n3, n3, n3, n3, n6, n3, n3, n3, n3, n3, n6, n6, 
		n6, n3, n3, n3, n6, n6, n9, n3, n3, n3, n3, n3, n9, n3, n3, n3, n3, 
		n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, n3, 
		n6, n3, n3, n3, n3, n3, n6, n6, n6, n6, n6, n6, n6, n6, n1, n2, n3, 
		n3, n3, n4, n1, n1, n3, n3, n3, n3, n3, n1, n1, n3, n3, n3, n3, n3, 
		n1, n5, n3, n3, n3, n3, n3, n5, n6, n6, n6, n6, n6, n6, n6, n6, n6, 
		n6, n6, n6, n6, n6, 
	}
}

df_underworld_items.seal_stair_schem = {
	size = {y = 2, x = 7, z = 7},
	data = {
		n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n10, 
		n3, n3, n3, n1, n1, n3, n11, n1, n10, n3, n1, n1, n11, n3, n3, n3, n3, 
		n1, n1, n3, n3, n3, n3, n3, n1, n1, n3, n3, n3, n3, n3, n1, n1, n3, 
		n3, n3, n3, n3, n1, n1, n3, n3, n3, n3, n3, n1, n1, n3, n3, n3, n3, 
		n3, n1, n1, n3, n3, n3, n3, n3, n1, n1, n3, n3, n3, n3, n3, n1, n1, 
		n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
	}
}