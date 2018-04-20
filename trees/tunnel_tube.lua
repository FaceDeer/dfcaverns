--------------------------------------------------
-- Tunnel tube

-- Magenta
-- curving trunk
-- Max trunk height 	8
-- depth 2-3

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local tunnel_tube_drop = nil

minetest.register_node("dfcaverns:tunnel_tube", {
	description = S("Tunnel Tube"),
	_doc_items_longdesc = dfcaverns.doc.tunnel_tube_desc,
	_doc_items_usagehelp = dfcaverns.doc.tunnel_tube_usage,
	tiles = {"dfcaverns_tunnel_tube.png"},
	paramtype2 = "facedir",
	drawtype = "nodebox",
	paramtype = "light",
	groups = {choppy = 3, tree = 1, oddly_breakable_by_hand=1, flammable = 2},
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

--Wood
minetest.register_craft({
	output = 'dfcaverns:tunnel_tube_wood 4',
	recipe = {
		{'dfcaverns:tunnel_tube'},
	}
})

minetest.register_node("dfcaverns:tunnel_tube_wood", {
	description = S("Tunnel Tube Plies"),
	_doc_items_longdesc = dfcaverns.doc.tunnel_tube_desc,
	_doc_items_usagehelp = dfcaverns.doc.tunnel_tube_usage,
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"dfcaverns_tunnel_tube_wood_top.png", "dfcaverns_tunnel_tube_wood_top.png", "dfcaverns_tunnel_tube_wood_side.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:tunnel_tube_wood",
	burntime = 9,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:tunnel_tube",
	burntime = 36,
})
minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:tunnel_tube_sapling",
	burntime = 3,
})

-- TNT
-----------------------------------------------------------------------------------------------------------
if dfcaverns.config.enable_tnt then

	local tnt_radius = tonumber(minetest.settings:get("tnt_radius") or 3) * 2/3
	local tnt_def = {radius = tnt_radius, damage_radius = tnt_radius * 2}
	
	minetest.register_node("dfcaverns:tunnel_tube_fruiting_body", {
		description = S("Tunnel Tube Fruiting Body"),
		_doc_items_longdesc = dfcaverns.doc.tunnel_tube_desc,
		_doc_items_usagehelp = dfcaverns.doc.tunnel_tube_usage,
		tiles = {"dfcaverns_tunnel_tube.png^[multiply:#b09090"},
		paramtype2 = "facedir",
		groups = {choppy = 3, oddly_breakable_by_hand=1, flammable = 2, tnt = 1,},
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
					items = {'dfcaverns:tunnel_tube_sapling', 'tnt:gunpowder'},
					rarity = 2,
				},
				{
					items = {'dfcaverns:tunnel_tube_sapling', 'tnt:gunpowder 2'},
					rarity = 2,
				},
			},
		},
		
		on_punch = function(pos, node, puncher)
			if puncher:get_wielded_item():get_name() == "default:torch" then
				minetest.swap_node(pos, {name = "dfcaverns:tunnel_tube_fruiting_body_burning"})
				minetest.registered_nodes["dfcaverns:tunnel_tube_fruiting_body_burning"].on_construct(pos)
				minetest.log("action", puncher:get_player_name() .. " ignites " .. node.name .. " at " .. minetest.pos_to_string(pos))
			end
		end,
		on_blast = function(pos, intensity)
			minetest.after(0.1, function()
				tnt.boom(pos, tnt_def)
			end)
		end,
		mesecons = {effector =
			{action_on =
				function(pos)
					tnt.boom(pos, tnt_def)
				end
			}
		},
		on_burn = function(pos)
			minetest.swap_node(pos, {name = "dfcaverns:tunnel_tube_fruiting_body_burning"})
			minetest.registered_nodes["dfcaverns:tunnel_tube_fruiting_body_burning"].on_construct(pos)
		end,
		on_ignite = function(pos, igniter)
			minetest.swap_node(pos, {name = "dfcaverns:tunnel_tube_fruiting_body_burning"})
			minetest.registered_nodes["dfcaverns:tunnel_tube_fruiting_body_burning"].on_construct(pos)
		end,
	})
	
	minetest.register_node("dfcaverns:tunnel_tube_fruiting_body_burning", {
		description = S("Tunnel Tube Fruiting Body"),
		_doc_items_longdesc = dfcaverns.doc.tunnel_tube_desc,
		_doc_items_usagehelp = dfcaverns.doc.tunnel_tube_usage,
		tiles = {"dfcaverns_tunnel_tube.png^[multiply:#b09090"},
		groups = {not_in_creative_inventory = 1,},
		light_source = 5,
		drop = "",
		sounds = default.node_sound_wood_defaults(),
		on_timer = function(pos, elapsed)
			tnt.boom(pos, tnt_def)
		end,
		-- unaffected by explosions
		on_blast = function() end,
		on_construct = function(pos)
			minetest.sound_play("tnt_ignite", {pos = pos})
			minetest.get_node_timer(pos):start(4)
		end,
	})
else
	minetest.register_node("dfcaverns:tunnel_tube_fruiting_body", {
		description = S("Tunnel Tube Fruiting Body"),
		_doc_items_longdesc = dfcaverns.doc.tunnel_tube_desc,
		_doc_items_usagehelp = dfcaverns.doc.tunnel_tube_usage,
		tiles = {"dfcaverns_tunnel_tube.png^[multiply:#b09090"},
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
			},
		},
	})
end
-----------------------------------------------------------------------------------------------------------

minetest.register_node("dfcaverns:tunnel_tube_sapling", {
	description = S("Tunnel Tube Spawn"),
	_doc_items_longdesc = dfcaverns.doc.tunnel_tube_desc,
	_doc_items_usagehelp = dfcaverns.doc.tunnel_tube_usage,
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
		minetest.get_node_timer(pos):start(math.random(
			dfcaverns.config.tunnel_tube_delay_multiplier*dfcaverns.config.tree_min_growth_delay,
			dfcaverns.config.tunnel_tube_delay_multiplier*dfcaverns.config.tree_max_growth_delay))
	end,
	
	on_timer = function(pos)
		minetest.set_node(pos, {name="air"})
		dfcaverns.spawn_tunnel_tube(pos)
	end,
})

local tunnel_tube_directions = {
	{x=1,y=0,z=0},
	{x=-1,y=0,z=0},
	{x=0,y=0,z=1},
	{x=0,y=0,z=-1},
--	{x=1,y=0,z=1}, -- diagonals work, but they don't look as nice as orthogonals
--	{x=-1,y=0,z=1},
--	{x=1,y=0,z=-1},
--	{x=-1,y=0,z=-1},
}

local tunnel_tube_curvature = {0,0,0,0,1,1,1,2,2,3,4}

dfcaverns.spawn_tunnel_tube = function(pos)
	local direction = tunnel_tube_directions[math.random(1,4)]
	local height = math.random(6,10)
	local x, y, z = pos.x, pos.y, pos.z
	local top_pos = vector.add(pos, vector.multiply(direction, tunnel_tube_curvature[height]))
	top_pos.y = y + height - 1

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(pos, top_pos)
	local area = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()
	local param2_data = vm:get_param2_data()

	dfcaverns.spawn_tunnel_tube_vm(area:indexp(pos), area, data, param2_data, height, direction)

	vm:set_data(data)
	vm:set_param2_data(param2_data)
	vm:write_to_map()
	vm:update_map()	
end

local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")
local c_tunnel_tube = minetest.get_content_id("dfcaverns:tunnel_tube")
local c_tunnel_tube_fruiting_body  = minetest.get_content_id("dfcaverns:tunnel_tube_fruiting_body")

dfcaverns.spawn_tunnel_tube_vm = function(vi, area, data, param2_data, height, direction)
	if not height then height = math.random(6, 10) end
	if not direction then direction = tunnel_tube_directions[math.random(1,4)] end
	
	local pos = area:position(vi)
	local y = pos.y
	local previous_vi = vi
	for i = 1, height do
		pos.y = y + i - 1
		vi = area:indexp(vector.add(pos, vector.multiply(direction, tunnel_tube_curvature[i])))
		if data[vi] == c_air or data[vi] == c_ignore then
			previous_vi = vi
			if i ~= height then
				data[vi] = c_tunnel_tube
				param2_data[vi] = 0
			else
				data[vi] = c_tunnel_tube_fruiting_body
			end
		else
			data[previous_vi] = c_tunnel_tube_fruiting_body
			break
		end
	end
end

