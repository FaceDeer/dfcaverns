-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Copied from subterrane's features.lua
-- Figured that was nicer than adding a dependency for just this little bit
local stal_on_place = function(itemstack, placer, pointed_thing)
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

	if minetest.is_protected(pt.above, placer:get_player_name()) then
		minetest.record_protection_violation(pt.above, placer:get_player_name())
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] or not minetest.registered_nodes[above.name] then
		return itemstack
	end
	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	local new_param2
	-- check if pointing at an existing stalactite
	if minetest.get_item_group(under.name, "spindleshroom") ~= 0 then
		new_param2 = under.param2
	else
		new_param2 = math.random(0,3)
	end

	-- add the node and remove 1 item from the itemstack
	minetest.add_node(pt.above, {name = itemstack:get_name(), param2 = new_param2})
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end

local growth_delay = function()
	return math.random(
		df_trees.config.tower_cap_delay_multiplier*df_trees.config.tree_min_growth_delay,
		df_trees.config.tower_cap_delay_multiplier*df_trees.config.tree_max_growth_delay)
end

local disp = 0.0625 -- adjusting position a bit

minetest.register_node("df_trees:spindleshroom_stem", {
	description = S("Spindleshroom Stem"),
	is_ground_content = true,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, spindleshroom = 1},
	sounds = default.node_sound_wood_defaults(),
	tiles = {
		"dfcaverns_tower_cap.png",
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625+disp, -0.5, -0.125+disp, 0.1875+disp, 0.5, 0.25+disp},
			{-0.125+disp, -0.5, -0.0625+disp, 0.25+disp, 0.5, 0.1875+disp},
		}
	},
	on_place = stal_on_place,
})

minetest.register_craft({
	type = "fuel",
	recipe = "df_trees:spindleshroom_stem",
	burntime = 5,
})

local cap_def = function(item_name, seedling_item, color_name, color_code, light_level)
	return {
		description = S("@1 Spindleshroom Cap", color_name),
		is_ground_content = true,
		groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, spindleshroom = 1},
		sounds = default.node_sound_wood_defaults(),
		tiles = {
			"dfcaverns_tower_cap.png^[multiply:#"..color_code,
		},
		light_source = light_level,
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1875+disp, -0.5, -0.3125+disp, 0.3125+disp, -0.3125, 0.4375+disp},
				{-0.3125+disp, -0.5, -0.1875+disp, 0.4375+disp, -0.3125, 0.3125+disp},
				{-0.0625+disp, -0.1875, -0.0625+disp, 0.1875+disp, -0.125, 0.1875+disp},
				{-0.1875+disp, -0.3125, -0.1875+disp, 0.3125+disp, -0.1875, 0.3125+disp},
			}
		},
		
		drop = {
            -- Maximum number of items to drop
            max_items = 1,
            -- Choose max_items randomly from this list
            items = {
                {
                    items = {item_name, seedling_item},  -- Items to drop
                    rarity = 2,  -- Probability of dropping is 1 / rarity
                },
                {
                    items = {item_name, seedling_item, seedling_item},  -- Items to drop
                    rarity = 2,  -- Probability of dropping is 1 / rarity
                },
                {
                    items = {item_name, seedling_item, seedling_item, seedling_item},  -- Items to drop
                    rarity = 2,  -- Probability of dropping is 1 / rarity
                },
                {
                    items = {item_name},  -- Items to drop
                    rarity = 1,  -- Probability of dropping is 1 / rarity
                },
            },
        },
		
		on_place = stal_on_place,
		on_timer = function(pos, elapsed)
			local above = vector.add(pos, {x=0,y=1,z=0})
			local node_above = minetest.get_node(above)
			local above_def = minetest.registered_nodes[node_above.name]
			if not above_def or not above_def.buildable_to then
				-- can't grow any more, exit
				return
			end
			local meta = minetest.get_meta(pos)
			local height = meta:get_int("spindleshroom_to_grow")
			local node = minetest.get_node(pos)
			minetest.set_node(pos, {name="df_trees:spindleshroom_stem", param2 = node.param2})
			minetest.set_node(above, {name=item_name, param2 = node.param2})
			height = height - 1
			if height > 0 then
				meta = minetest.get_meta(above)
				meta:set_int("spindleshroom_to_grow", height)
				minetest.get_node_timer(above):start(growth_delay())
			end
		end,
	}
end

local seedling_construct = function(pos)
	local below_node = minetest.get_node(vector.add(pos, {x=0,y=-1,z=0}))
	if minetest.get_item_group(below_node.name, "soil") > 0 then
		minetest.get_node_timer(pos):start(growth_delay())
	end
end

local seedling_def = function(item_name, color_name, color_code)
	return {
		description = S("@1 Spindleshroom Spawn", color_name),
		_doc_items_longdesc = nil,
		_doc_items_usagehelp = nil,
		tiles = {
			"dfcaverns_tower_cap.png^[multiply:#"..color_code,
		},
		groups = {snappy = 3, flammable = 2, plant = 1, attached_node = 1, light_sensitive_fungus = 11, digtron_on_place=1},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		floodable = true,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.0625 + 0.125, -0.5, -0.125 + 0.125, 0.125 + 0.125, -0.375, 0.0625 + 0.125},
			}
		},
		
		on_place = stal_on_place,
		on_construct = seedling_construct,
		
		on_timer = function(pos, elapsed)
			local node = minetest.get_node(pos)
			minetest.set_node(pos, {name=item_name, param2 = node.param2})
			local meta = minetest.get_meta(pos)
			local height = math.random(1,5)-1
			if height > 0 then
				meta:set_int("spindleshroom_to_grow", height)
				minetest.get_node_timer(pos):start(growth_delay())
			end
		end,
	}
end

local register_spindleshroom_type = function(item_suffix, colour_name, colour_code, light_level)
	local cap_item = "df_trees:spindleshroom_cap"..item_suffix
	local seedling_item = "df_trees:spindleshroom_seedling"..item_suffix
	minetest.register_node(cap_item,
		cap_def(cap_item, seedling_item, colour_name, colour_code, light_level)
	)
	minetest.register_node(seedling_item,
		seedling_def(cap_item, colour_name, colour_code)
	)

	minetest.register_craft({
		type = "fuel",
		recipe = cap_item,
		burntime = 10,
	})
	minetest.register_craft({
		type = "fuel",
		recipe = seedling_item,
		burntime = 3,
	})
	
	local c_stem = minetest.get_content_id("df_trees:spindleshroom_stem")
	local c_cap = minetest.get_content_id(cap_item)

	return function(vi, area, data, data_param2)
		local stem_height = math.random(1,5)-1
		local param2 = math.random(1,4)-1
		local i = 0
		while i < stem_height do
			index = vi + i * area.ystride
			data[index] = c_stem
			data_param2[index] = param2
			i = i + 1
		end
		index = vi + i * area.ystride
		data[index] = c_cap
		data_param2[index] = param2	
	end
end

df_trees.spawn_spindleshroom_white_vm = register_spindleshroom_type("_white", S("White"), "FFFFFF", 0)
df_trees.spawn_spindleshroom_cyan_vm = register_spindleshroom_type("_cyan", S("Cyan"), "C3FFFF", 2)
df_trees.spawn_spindleshroom_red_vm = register_spindleshroom_type("_red", S("Red"), "FFC3C3", 4)
df_trees.spawn_spindleshroom_green_vm = register_spindleshroom_type("_green", S("Green"), "C3FFC3", 2)
df_trees.spawn_spindleshroom_red_vm = register_spindleshroom_type("_golden", S("Golden"), "FFFFC3", 12)
