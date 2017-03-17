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
	groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:dead_fungus",
	burntime = 2
})

-- not DF canon
minetest.register_node("dfcaverns:cavern_fungi", {
	description = S("Cavern Fungi"),
	drawtype = "plantlike",
	tiles = {"dfcaverns_fungi.png"},
	inventory_image = "dfcaverns_fungi.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, light_sensitive_fungus = 11},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5},
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "dfcaverns:cavern_fungi",
	burntime = 2
})

-----------------------------------------------------------------------------------------

local place_seed = function(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return itemstack
	end
	if pt.type ~= "node" then
		return itemstack
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	if minetest.is_protected(pt.under, placer:get_player_name()) then
		minetest.record_protection_violation(pt.under, placer:get_player_name())
		return
	end
	if minetest.is_protected(pt.above, placer:get_player_name()) then
		minetest.record_protection_violation(pt.above, placer:get_player_name())
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return itemstack
	end
	if not minetest.registered_nodes[above.name] then
		return itemstack
	end

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return itemstack
	end

	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name = plantname, param2 = 1})
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end

dfcaverns.register_seed = function(name, description, image, stage_one)
	local def = {
		description = description,
		tiles = {image},
		inventory_image = image,
		wield_image = image,
		drawtype = "signlike",
		paramtype2 = "wallmounted",
		groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 2},
		_dfcaverns_next_stage = stage_one,
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
		on_place = function(itemstack, placer, pointed_thing)
			return place_seed(itemstack, placer, pointed_thing, "dfcaverns:"..name)
		end,
	}
	
	minetest.register_node("dfcaverns:"..name, def)
	minetest.register_craft({
		type = "fuel",
		recipe = "dfcaverns:"..name,
		burntime = 1
	})
end

local grow_underground_plant = function(pos, node)
	local node_def = minetest.registered_nodes[node.name]
	local next_stage = node_def._dfcaverns_next_stage
	if next_stage then
		local next_def = minetest.registered_nodes[next_stage]
		minetest.swap_node(pos, {name=next_stage, param2 = next_def.place_param2 or node.param2})
	end
end

dfcaverns.register_grow_abm = function(names, interval, chance)
	minetest.register_abm({
		nodenames = names,
		interval = interval,
		chance = chance,
		catch_up = true,
		neighbors = {"farming:soil_wet"},
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			pos.y = pos.y+1
			grow_underground_plant(pos, node)
		end
	})
	
	minetest.register_abm({
		nodenames = names,
		interval = interval * 10,
		chance = chance,
		catch_up = true,
		neighbors = {"default:dirt", "dfcaverns:dirt_with_cave_moss", "dfcaverns:cobble_with_floor_fungus"},
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.get_node(pos).name == "default:dirt" or
				minetest.get_node(pos).name == "dfcaverns:dirt_with_cave_moss" or
				minetest.get_node(pos).name == "dfcaverns:cobble_with_floor_fungus" then
				pos.y = pos.y+1
				grow_underground_plant(pos, node)
			end
		end
	})
end

if dfcaverns.config.light_kills_fungus then
	minetest.register_abm({
		label = "dfcaverns:kill_light_sensitive_fungus",
		nodenames = {"group:light_sensitive_fungus"},
		catch_up = true,
		interval = 30,
		chance = 5,
		action = function(pos, node)
			local node_def = minetest.registered_nodes[node.name]
			local dead_node = node_def._dfcaverns_dead_node or "dfcaverns:dead_fungus"
			-- 11 is the value adjacent to a torch
			local light_level = minetest.get_node_light(pos)
			if light_level and light_level > node_def.groups.light_sensitive_fungus then
				minetest.set_node(pos, {name=dead_node, param2 = node.param2})
			end
		end
	})
end
