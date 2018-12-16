local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local gas_desc
local gas_usage

local seep_desc
local seep_usage

if minetest.get_modpath("doc") then
	gas_desc = S("Gaseous hydrocarbons formed from the detritus of long dead plants and animals processed by heat and pressure deep within the earth.")
	gas_usage = S("Gas is highly hazardous. Heavier than air, it pools in deep caverns and asphyxiates the unwary.")
	if minetest.get_modpath("tnt") then
		gas_usage = gas_usage .. " " .. S("When exposed to air and an ignition source it can produce a deadly explosion.")
	end
	
	seep_desc = S("Some coal deposits have cracks that seep a steady flow of mine gas.")
	seep_usage = S("Mining out such a deposit seals the crack.")
end

minetest.register_node("oil:gas", {
	description = S("Mine Gas"),
	_doc_items_longdesc = gas_desc,
	_doc_items_usagehelp = gas_usage,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "glasslike",
	drowning = 1,
	post_effect_color = {a = 20, r = 20, g = 20, b = 250},
	tiles = {"oil_gas.png^[colorize:#E0E0E033"},
	alpha = 0.1,
	groups = {not_in_creative_inventory=1},
	paramtype = "light",
	drop = {},
	sunlight_propagates = true,
	--on_blast = function() end, -- unaffected by explosions
})

minetest.register_node("oil:gas_seep", {
	description = S("Gas Seep"),
	_doc_items_longdesc = seep_desc,
	_doc_items_usagehelp = seep_usage,
	tiles = {"default_stone.png^default_mineral_coal.png^[combine:16x80:0,-48=crack_anylength.png"},
	groups = {cracky = 3},
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = true,
})

minetest.register_on_dignode(function(pos, oldnode, digger)
	if minetest.get_item_group(oldnode.name, "digtron") > 0 then
		-- skip digtron moved nodes
		return;
	end

	local np = minetest.find_node_near(pos, 1,{"oil:gas"})
	if np ~= nil then
		minetest.set_node(pos, {name = "oil:gas"})
		return
	end
end)

local directions = {
	{x=1, y=0, z=0},
	{x=-1, y=0, z=0},
	{x=0, y=0, z=1},
	{x=0, y=0, z=-1},
}

minetest.register_abm({
    label = "oil:gas movement",
    nodenames = {"oil:gas"},
    neighbors = {"group:liquid", "air"},
    interval = 1.0,
    chance = 1,
    catch_up = true,
    action = function(pos, node)
		local next_pos = {x=pos.x, y=pos.y+1, z=pos.z}
		local next_node = minetest.get_node(next_pos)
		if minetest.get_item_group(next_node.name, "liquid") > 0 then
			minetest.swap_node(next_pos, {name="oil:gas"})
			minetest.swap_node(pos, next_node)
		else
			next_pos = {x=pos.x, y=pos.y-1, z=pos.z}
			next_node = minetest.get_node(next_pos)
			if next_node.name == "air" then
				minetest.swap_node(next_pos, {name="oil:gas"})
				minetest.swap_node(pos, next_node)			
			else
				local dir = directions[math.random(1,4)]
				local next_pos = vector.add(pos, dir)
				local next_node = minetest.get_node(next_pos)
				if next_node.name == "air" or  minetest.get_item_group(next_node.name, "liquid") > 0 then
					if next_node.name == "air" or math.random() < 0.5 then -- gas never "climbs" above air.
						minetest.swap_node(next_pos, {name="oil:gas"})
						minetest.swap_node(pos, next_node)
					else
						-- this can get gas to rise up out of the surface of liquid, preventing it from forming a permanent hole.
						next_pos.y = next_pos.y + 1
						next_node = minetest.get_node(next_pos)
						if next_node.name == "air" then
							minetest.swap_node(next_pos, {name="oil:gas"})
							minetest.swap_node(pos, next_node)
						end
					end
				end
			end
		end
	end,
})

minetest.register_abm({
	label = "oil:gas snuffing torches",
	nodenames = {"group:torch"},
	neighbors = {"oil:gas"},
	interval = 1.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		if not minetest.find_node_near(pos, 1, "air") then
			local torch_node = minetest.get_node(pos)
			local drops = minetest.get_node_drops(torch_node.name, "")
			for _, dropped_item in pairs(drops) do
				minetest.add_item(pos, dropped_item)
	        end
			minetest.set_node(pos, {name="oil:gas"})
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 16, gain = 0.1}
			)
		end	
	end,
})

if minetest.get_modpath("tnt") then
	minetest.register_abm({
		label = "oil:gas ignition",
		nodenames = {"group:torch", "group:igniter"},
		neighbors = {"oil:gas"},
		interval = 1.0,
		chance = 1,
		catch_up = true,
		action = function(pos, node)
			if minetest.find_node_near(pos, 1, "air") then
				tnt.boom(pos, {radius=1, damage_radius=10})
			end	
		end,
	})
end

local orthogonal = {
	{x=0,y=0,z=1},
	{x=0,y=1,z=0},
	{x=1,y=0,z=0},
	{x=0,y=0,z=-1},
	{x=0,y=-1,z=0},
	{x=-1,y=0,z=0},
}

minetest.register_abm({
	label = "oil:gas seep",
	nodenames = {"oil:gas_seep"},
	neighbors = {"air"},
	interval = 1.0,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		local target_pos = vector.add(pos,orthogonal[math.random(1,6)])
		if minetest.get_node(target_pos).name == "air" then
			minetest.swap_node(target_pos, {name="oil:gas"})
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 8, gain = 0.1}
			)
		end	
	end,
})