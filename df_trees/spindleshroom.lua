-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local vessels = minetest.get_modpath("vessels")

-- pre-declare
local get_cap_type

-- Copied from subterrane's features.lua
-- Figured that was nicer than adding a dependency for just this little bit
local stem_on_place = function(itemstack, placer, pointed_thing)
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
	description = S("Spindlestem"),
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
	on_place = stem_on_place,
})

minetest.register_craft({
	type = "fuel",
	recipe = "df_trees:spindleshroom_stem",
	burntime = 5,
})

local register_spindleshroom_type = function(item_suffix, colour_name, colour_code, light_level)
	local cap_item = "df_trees:spindleshroom_cap_"..item_suffix
	
	minetest.register_node(cap_item, {
		description = S("@1 Spindlestem Cap", color_name),
		is_ground_content = true,
		groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, spindleshroom = 1},
		sounds = default.node_sound_wood_defaults(),
		tiles = {
			"dfcaverns_tower_cap.png^[multiply:#"..colour_code,
			"dfcaverns_spindlestem_cap.png^[multiply:#"..colour_code,
			"dfcaverns_tower_cap.png^[multiply:#"..colour_code,
			"dfcaverns_tower_cap.png^[multiply:#"..colour_code,
			"dfcaverns_tower_cap.png^[multiply:#"..colour_code,
			"dfcaverns_tower_cap.png^[multiply:#"..colour_code,
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
                    items = {cap_item, "df_trees:spindleshroom_seedling"},  -- Items to drop
                    rarity = 2,  -- Probability of dropping is 1 / rarity
                },
                {
                    items = {cap_item, "df_trees:spindleshroom_seedling", "df_trees:spindleshroom_seedling"},  -- Items to drop
                    rarity = 2,  -- Probability of dropping is 1 / rarity
                },
                {
                    items = {cap_item, "df_trees:spindleshroom_seedling", "df_trees:spindleshroom_seedling", "df_trees:spindleshroom_seedling"},  -- Items to drop
                    rarity = 2,  -- Probability of dropping is 1 / rarity
                },
                {
                    items = {cap_item},  -- Items to drop
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
			minetest.set_node(above, {name=cap_item, param2 = node.param2})
			height = height - 1
			if height > 0 then
				meta = minetest.get_meta(above)
				meta:set_int("spindleshroom_to_grow", height)
				minetest.get_node_timer(above):start(growth_delay())
			end
		end,
	})

	minetest.register_craft({
		type = "fuel",
		recipe = cap_item,
		burntime = 10,
	})

	local c_stem = minetest.get_content_id("df_trees:spindleshroom_stem")
	local c_cap = minetest.get_content_id(cap_item)
	
	if vessels and light_level > 0 then
		local tex = "dfcaverns_vessels_glowing_liquid.png^[multiply:#"..colour_code.."^vessels_glass_bottle.png"
		local new_light = light_level + math.floor((minetest.LIGHT_MAX-light_level)/2)
		minetest.register_node("df_trees:glowing_bottle_"..item_suffix, {
			description = S("@1 Spindlestem Extract", colour_name),
			drawtype = "plantlike",
			tiles = {tex},
			inventory_image = tex,
			wield_image = tex,
			paramtype = "light",
			is_ground_content = false,
			walkable = false,
			selection_box = {
				type = "fixed",
				fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
			},
			groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
			sounds = default.node_sound_glass_defaults(),
			light_source = new_light,
		})
		
		minetest.register_craft( {
			output = "df_trees:glowing_bottle_"..item_suffix.." 3",
			type = "shapeless",
			recipe = {
				"vessels:glass_bottle",
				"vessels:glass_bottle",
				"vessels:glass_bottle",
				cap_item,
			}
		})

		minetest.register_craft( {
			output = "vessels:glass_bottle",
			type = "shapeless",
			recipe = {
				"df_trees:glowing_bottle_"..item_suffix,
			}
		})
	end

	-- mapgen function
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

local seedling_construct = function(pos)
	local below_node = minetest.get_node(vector.add(pos, {x=0,y=-1,z=0}))
	if minetest.get_item_group(below_node.name, "soil") > 0 then
		minetest.get_node_timer(pos):start(growth_delay())
	end
end

minetest.register_node("df_trees:spindleshroom_seedling", {
	description = S("Spindlestem Spawn"),
	_doc_items_longdesc = nil,
	_doc_items_usagehelp = nil,
	tiles = {
		"dfcaverns_tower_cap.png",
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
		local cap_item = "df_trees:spindleshroom_cap_"..get_cap_type(pos)
		local node = minetest.get_node(pos)
		minetest.set_node(pos, {name=cap_item, param2 = node.param2})
		local meta = minetest.get_meta(pos)
		local disp = {x=3, y=3, z=3}
		local nearby = minetest.find_nodes_in_area(vector.add(pos, disp), vector.subtract(pos, disp), {"group:spindleshroom"})
		local count = #nearby
		local height = math.random(1,3)-1
		if count > 10 then height = height + 2 end -- if there are a lot of nearby spindleshrooms, grow taller
		if height > 0 then
			meta:set_int("spindleshroom_to_grow", height)
			minetest.get_node_timer(pos):start(growth_delay())
		end
	end,
})

df_trees.spawn_spindleshroom_white_vm = register_spindleshroom_type("white", S("White"), "FFFFFF", 0)
df_trees.spawn_spindleshroom_red_vm = register_spindleshroom_type("red", S("Red"), "FFC3C3", 3)
df_trees.spawn_spindleshroom_green_vm = register_spindleshroom_type("green", S("Green"), "C3FFC3", 4)
df_trees.spawn_spindleshroom_cyan_vm = register_spindleshroom_type("cyan", S("Cyan"), "C3FFFF", 6)
df_trees.spawn_spindleshroom_red_vm = register_spindleshroom_type("golden", S("Golden"), "FFFFC3", 12)

get_cap_type = function(pos)
	if pos.y > -100 then
		return "white"
	end
	local iron = minetest.find_node_near(pos, 10, {"default:stone_with_iron", "default:steelblock"})
	local copper = minetest.find_node_near(pos, 10, {"default:stone_with_copper", "default:copperblock"})
	local mese = minetest.find_node_near(pos, 10, {"default:stone_with_mese", "default:mese"})
	local possibilities = {}

	if mese then table.insert(possibilities, "golden") end
	if copper then table.insert(possibilities, "green") end
	if iron then table.insert(possibilities, "red") end
	if iron and copper then table.insert(possibilities, "cyan") end
	
	if #possibilities == 0 then
		return "white"
	else
		local pick = math.random(1, #possibilities)
		return possibilities[pick]
	end	
end