-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local pearl_on_place = function(itemstack, placer, pointed_thing)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return itemstack
	end
	if pt.type ~= "node" then
		return itemstack
	end
	
	local under_pos = pt.under
	local above_pos = pt.above

	local under_node = minetest.get_node(under_pos)
	local above_node = minetest.get_node(above_pos)

	if minetest.is_protected(above_pos, placer:get_player_name()) then
		minetest.record_protection_violation(above_pos, placer:get_player_name())
		return
	end

	local under_name = under_node.name
	local above_name = above_node.name
	local under_def = minetest.registered_nodes[under_name]
	local above_def = minetest.registered_nodes[above_name]
	
	-- return if any of the nodes is not registered
	if not under_def or not above_def then
		return itemstack
	end
	-- check if you can replace the node above the pointed node
	if not above_def.buildable_to then
		return itemstack
	end

	local dir = vector.subtract(under_pos, above_pos)
	local param2
	if dir.x > 0 then
		--facing +x: 16, 17, 18, 19,
		param2 = 15 + math.random(1,4)
	elseif dir.x < 0 then
		--facing -x: 12, 13, 14, 15
		param2 = 11 + math.random(1,4)
	elseif dir.z > 0 then
		--facing +z: 8, 9, 10, 11
		param2 = 7 + math.random(1,4)
	elseif dir.z < 0 then
		--facing -z: 4, 5, 6, 7
		param2 = 3 + math.random(1,4)
	elseif dir.y > 0 then
		--facing -y: 20, 21, 22, 23 (ceiling)
		param2 = 19 + math.random(1,4)
	else
		--facing +y: 0, 1, 2, 3 (floor)
		param2 = math.random(1,4) - 1
	end

	-- add the node and remove 1 item from the itemstack
	minetest.add_node(above_pos, {name = itemstack:get_name(), param2 = param2})
	if not minetest.setting_getbool("creative_mode") and not minetest.check_player_privs(placer, "creative") then
		itemstack:take_item()
	end
	return itemstack
end

local valid_mounting_node = function(pos)
	local node = minetest.get_node(pos)
	if not node then return false end
	local def = minetest.registered_nodes[node.name]
	if not def then return false end
	if def.buildable_to then return false end
	return true
end

local add_to_table = function(dest, source)
	for _, val in ipairs(source) do
		table.insert(dest, val)
	end
end

local get_valid_facedirs = function(pos)
	local dirs = {}
	if valid_mounting_node(vector.add(pos, {x=1,y=0,z=0})) then
		add_to_table(dirs, {16, 17, 18, 19})
	end
	if valid_mounting_node(vector.add(pos, {x=-1,y=0,z=0})) then
		add_to_table(dirs, {12, 13, 14, 15})
	end
	if valid_mounting_node(vector.add(pos, {x=0,y=1,z=0})) then
		add_to_table(dirs, {0, 1, 2, 3})
	end
	if valid_mounting_node(vector.add(pos, {x=0,y=-1,z=0})) then
		add_to_table(dirs, {20, 21, 22, 23})
	end
	if valid_mounting_node(vector.add(pos, {x=0,y=0,z=1})) then
		add_to_table(dirs, {8, 9, 10, 11})
	end
	if valid_mounting_node(vector.add(pos, {x=0,y=0,z=-1})) then
		add_to_table(dirs, {4, 5, 6, 7})
	end
end

minetest.register_node("df_mapitems:wall_pearls", {
	description = S("Cave Pearls"),
	tiles = {"dfcaverns_cave_pearl.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},
	walkable = false,
	climbable = true,
	light_source = 4,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, -0.125, -0.3125, -0.125}, -- NodeBox1
			{0.125, -0.5, -0.1875, 0.3125, -0.375, 0}, -- NodeBox2
			{-0.125, -0.5, 0.25, 0.0625, -0.375, 0.4375}, -- NodeBox3
		}
	},
	on_place = pearl_on_place,
})

local c_air = minetest.get_content_id("air")
local c_stone = minetest.get_content_id("default:stone")
local c_pearls = minetest.get_content_id("df_mapitems:wall_pearls")

--facing +x: 16, 17, 18, 19, 
--facing -x: 12, 13, 14, 15
--facing +z: 8, 9, 10, 11
--facing -z: 4, 5, 6, 7
--facing -y: 20, 21, 22, 23, (ceiling)
df_mapitems.place_wall_pearls = function(vi, area, data, data_param2)
	if data[vi] == c_air then
		if data[vi+1] == c_stone then -- positive X
			data[vi] = c_pearls
			data_param2[vi] = 15 + math.random(1,4)
		elseif data[vi-1] == c_stone then -- negative X
			data[vi] = c_pearls
			data_param2[vi] = 11 + math.random(1,4)
		elseif data[vi+area.zstride] == c_stone then -- positive Z
			data[vi] = c_pearls
			data_param2[vi] = 7 + math.random(1,4)
		elseif data[vi-area.zstride] == c_stone then -- negative Z
			data[vi] = c_pearls
			data_param2[vi] = 3 + math.random(1,4)
		end
	end
end

