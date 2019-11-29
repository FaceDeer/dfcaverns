-- This file defines a type of root-like growth that spreads over the surface of the ground in a random web-like pattern

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- hub_thickness -- the bit in the middle that's seen at the ends and corners of long hypha runs
-- connector_thickness
local get_node_box = function(hub_thickness, connector_thickness)
	return {
		type = "connected",
		fixed = {-hub_thickness,-hub_thickness,-hub_thickness,hub_thickness,hub_thickness,hub_thickness},
		connect_top = {-connector_thickness, 0, -connector_thickness, connector_thickness, 0.5, connector_thickness},
		connect_bottom = {-connector_thickness, -0.5, -connector_thickness, connector_thickness, 0, connector_thickness},
		connect_back = {-connector_thickness, -connector_thickness, 0, connector_thickness, connector_thickness, 0.5},
		connect_right = {0, -connector_thickness, -connector_thickness, 0.5, connector_thickness, connector_thickness},
		connect_front = {-connector_thickness, -connector_thickness, -0.5, connector_thickness, connector_thickness, 0},
		connect_left = {-0.5, -connector_thickness, -connector_thickness, 0, connector_thickness, connector_thickness},
		disconnected = {-connector_thickness, -connector_thickness, -connector_thickness, connector_thickness, connector_thickness, connector_thickness},
	}
end

minetest.register_node("df_primordial_items:giant_hypha_root", {
	description = S("Rooted Giant Hypha"),
	tiles = {
		{name="dfcaverns_mush_giant_hypha.png"},
	},
    connects_to = {"group:soil", "group:hypha"},
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },
	drawtype = "nodebox",
	node_box = get_node_box(0.1875, 0.25),
	paramtype = "light",
	light_source = 2,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha = 1},
	sounds = df_trees.node_sound_tree_soft_fungus_defaults(),
	drop = {
		max_items = 1,
		items = {
			{
				items = {"df_primordial_items:mycelial_fibers","df_primordial_items:giant_hypha_apical_meristem"},
				rarity = 100,
			},
			{
				items = {"df_primordial_items:mycelial_fibers"},
			},
		},
	},
})
minetest.register_node("df_primordial_items:giant_hypha", {
	description = S("Giant Hypha"),
	tiles = {
		{name="dfcaverns_mush_giant_hypha.png"},
	},
    connects_to = {"group:hypha"},
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },
	drawtype = "nodebox",
	node_box = get_node_box(0.1875, 0.25),
	paramtype = "light",
	light_source = 2,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha = 1},
	sounds = df_trees.node_sound_tree_soft_fungus_defaults(),
	drop = {
		max_items = 1,
		items = {
			{
				items = {"df_primordial_items:mycelial_fibers","df_primordial_items:giant_hypha_apical_meristem"},
				rarity = 100,
			},
			{
				items = {"df_primordial_items:mycelial_fibers"},
			},
		},
	},
})

minetest.register_craftitem("df_primordial_items:mycelial_fibers", {
	description = S("Giant Mycelial Fibers"),
	groups = {wool = 1},
	inventory_image = "dfcaverns_mush_mycelial_fibers.png",
})

minetest.register_craftitem("df_primordial_items:mycelial_thread", {
	description = S("Mycelial thread"),
	inventory_image = "dfcaverns_pig_tail_thread.png",
	groups = {flammable = 1, thread = 1},
})

minetest.register_craft({
	output = "df_primordial_items:mycelial_thread 4",
	type = "shapeless",
	recipe = { "df_primordial_items:mycelial_fibers"},
})

-- Check each of the six cardinal directions to see if it's buildable-to,
-- if it has an adjacent "soil" node (or if it's going out over the corner of an adjacent soil node),
-- and does *not* have an adjacent hypha already.
-- By growing with these conditions hyphae will hug the ground and will not immediately loop back on themselves
-- (though they can run into other pre-existing growths, forming larger loops - which is fine, large loops are nice)

local find_mycelium_growth_targets = function(pos)
	local nodes = {}
	for x = -1, 1 do
		nodes[x] = {}
		for y = -1, 1 do
			nodes[x][y] = {}
			for z = -1, 1 do
				if not (x == y and y == z) then -- we don't care about the diagonals or the center node
					local node = minetest.get_node({x=pos.x+x, y=pos.y+y, z=pos.z+z})
					if node.name == "ignore" then
						-- Pause growth! We're at the edge of the known world.
						return nil
					end
					local state = {}
					if minetest.get_item_group(node.name, "soil") > 0 or
						minetest.get_item_group(node.name, "stone") > 0 and math.random() < 0.5 then -- let hyphae explore out over stone
						state.soil = true
					elseif minetest.get_item_group(node.name, "hypha") > 0 then
						state.hypha = true
					elseif minetest.registered_nodes[node.name] and minetest.registered_nodes[node.name].buildable_to then
						state.buildable = true
					end
					nodes[x][y][z] = state
				end
			end
		end
	end

	--TODO there's probably some clever way to turn this into a subroutine, but I'm tired right now and
	--copy and pasting is easy and nobody's going to decide whether to hire or fire me based on this
	--particular snippet of code so what the hell. I'll fix it later when that clever way comes to me.
	local valid_targets = {}
	if nodes[-1][0][0].buildable and
		-- test for soil to directly support new growth
		(nodes[-1][-1][0].soil or
		nodes[-1][1][0].soil or
		nodes[-1][0][-1].soil or
		nodes[-1][0][1].soil or
		-- test for soil "around the corner" to allow for growth over an edge
		nodes[0][-1][0].soil or
		nodes[0][1][0].soil or
		nodes[0][0][-1].soil or
		nodes[0][0][1].soil)
		and not -- no adjacent hypha
		(nodes[-1][-1][0].hypha or
		nodes[-1][1][0].hypha or
		nodes[-1][0][-1].hypha or
		nodes[-1][0][1].hypha)
	then
		table.insert(valid_targets, {x=pos.x-1, y=pos.y, z=pos.z})
	end
	if nodes[1][0][0].buildable and
		-- test for soil to directly support new growth
		(nodes[1][-1][0].soil or
		nodes[1][1][0].soil or
		nodes[1][0][-1].soil or
		nodes[1][0][1].soil or
		-- test for soil "around the corner" to allow for growth over an edge
		nodes[0][-1][0].soil or
		nodes[0][1][0].soil or
		nodes[0][0][-1].soil or
		nodes[0][0][1].soil)
		and not -- no adjacent hypha
		(nodes[1][-1][0].hypha or
		nodes[1][1][0].hypha or
		nodes[1][0][-1].hypha or
		nodes[1][0][1].hypha)
	then
		table.insert(valid_targets, {x=pos.x+1, y=pos.y, z=pos.z})
	end
	if nodes[0][-1][0].buildable and
		-- test for soil to directly support new growth
		(nodes[-1][-1][0].soil or
		nodes[1][-1][0].soil or
		nodes[0][-1][-1].soil or
		nodes[0][-1][1].soil or
		-- test for soil "around the corner" to allow for growth over an edge
		nodes[-1][0][0].soil or
		nodes[1][0][0].soil or
		nodes[0][0][-1].soil or
		nodes[0][0][1].soil)
		and not -- no adjacent hypha
		(nodes[-1][-1][0].hypha or
		nodes[1][-1][0].hypha or
		nodes[0][-1][-1].hypha or
		nodes[0][-1][1].hypha)
	then
		table.insert(valid_targets, {x=pos.x, y=pos.y-1, z=pos.z})
	end
	if nodes[0][1][0].buildable and
		-- test for soil to directly support new growth
		(nodes[-1][1][0].soil or
		nodes[1][1][0].soil or
		nodes[0][1][-1].soil or
		nodes[0][1][1].soil or
		-- test for soil "around the corner" to allow for growth over an edge
		nodes[-1][0][0].soil or
		nodes[1][0][0].soil or
		nodes[0][0][-1].soil or
		nodes[0][0][1].soil)
		and not -- no adjacent hypha
		(nodes[-1][1][0].hypha or
		nodes[1][1][0].hypha or
		nodes[0][1][-1].hypha or
		nodes[0][1][1].hypha)
	then
		table.insert(valid_targets, {x=pos.x, y=pos.y+1, z=pos.z})
	end
	if nodes[0][0][-1].buildable and
		-- test for soil to directly support new growth
		(nodes[-1][0][-1].soil or
		nodes[1][0][-1].soil or
		nodes[0][-1][-1].soil or
		nodes[0][1][-1].soil or
		-- test for soil "around the corner" to allow for growth over an edge
		nodes[-1][0][0].soil or
		nodes[1][0][0].soil or
		nodes[0][-1][0].soil or
		nodes[0][1][0].soil)
		and not -- no adjacent hypha
		(nodes[-1][0][-1].hypha or
		nodes[1][0][-1].hypha or
		nodes[0][-1][-1].hypha or
		nodes[0][1][-1].hypha)
	then
		table.insert(valid_targets, {x=pos.x, y=pos.y, z=pos.z-1})
	end
	if nodes[0][0][1].buildable and
		-- test for soil to directly support new growth
		(nodes[-1][0][1].soil or
		nodes[1][0][1].soil or
		nodes[0][-1][1].soil or
		nodes[0][1][1].soil or
		-- test for soil "around the corner" to allow for growth over an edge
		nodes[-1][0][0].soil or
		nodes[1][0][0].soil or
		nodes[0][-1][0].soil or
		nodes[0][1][0].soil)
		and not -- no adjacent hypha
		(nodes[-1][0][1].hypha or
		nodes[1][0][1].hypha or
		nodes[0][-1][1].hypha or
		nodes[0][1][1].hypha)
	then
		table.insert(valid_targets, {x=pos.x, y=pos.y, z=pos.z+1})
	end
	
	return valid_targets
end

local grow_mycelium = function(pos, meristem_name)
	local new_meristems = {}
	-- Can we grow? If so, pick a random direction and add a new meristem there
	local targets = find_mycelium_growth_targets(pos)
	
	if targets == nil then
		return nil -- We hit the edge of the known world, pause!
	end
	
	local target_count = #targets
	if target_count > 0 then
		local target = targets[math.random(1,target_count)]
		minetest.set_node(target, {name=meristem_name})
		table.insert(new_meristems, target)
	else
		--nowhere to grow, turn into a rooted hypha and we're done
		minetest.set_node(pos, {name="df_primordial_items:giant_hypha_root"})
		return new_meristems
	end

	if math.random() < 0.06 then -- Note: hypha growth pattern is very sensitive to this branching factor. Higher than about 0.06 will blanket the landscape with fungus.
		-- Split - try again from here next time
		table.insert(new_meristems, pos)
	-- Otherwise, just turn into a hypha and we're done
	elseif math.random() < 0.333 then
		minetest.set_node(pos, {name="df_primordial_items:giant_hypha_root"})
	else
		minetest.set_node(pos, {name="df_primordial_items:giant_hypha"})
	end
	return new_meristems
end

local min_growth_delay = tonumber(minetest.settings:get("dfcaverns_mycelium_min_growth_delay")) or 240
local max_growth_delay = tonumber(minetest.settings:get("dfcaverns_mycelium_max_growth_delay")) or 400
local avg_growth_delay = (min_growth_delay + max_growth_delay) / 2

minetest.register_node("df_primordial_items:giant_hypha_apical_meristem", {
	description = S("Giant Hypha Apical Meristem"),
	tiles = {
		{name="dfcaverns_mush_giant_hypha.png^[brighten"},
	},
    connects_to = {"group:hypha"},
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },
	drawtype = "nodebox",
	light_source = 6,
	node_box = get_node_box(0.25, 0.375),
	paramtype = "light",

	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha = 1, light_sensitive_fungus = 13},
	_dfcaverns_dead_node = "df_primordial_items:giant_hypha_root",
	sounds = df_trees.node_sound_tree_soft_fungus_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(min_growth_delay, max_growth_delay))
	end,
	on_destruct = function(pos)
		minetest.get_node_timer(pos):stop()
	end,
	on_timer = function(pos, elapsed)
		if elapsed > max_growth_delay then
			-- We've been unloaded for a while, need to do multiple growth iterations.
			local iterations = math.floor(elapsed / avg_growth_delay) -- the number of iterations we've missed
			local stack = {pos} -- initialize with the current location
			for i = 1, iterations do
				local new_stack = {} -- populate this with new node output.
				for _, stackpos in ipairs(stack) do -- for each currently growing location
					local ret = grow_mycelium(stackpos, "df_primordial_items:giant_hypha_apical_meristem")
					if ret == nil then
						-- We hit the edge of the known world, stop and retry later
						minetest.get_node_timer(stackpos):start(math.random(min_growth_delay,max_growth_delay))
					else
						for _, retpos in ipairs(ret) do
							-- put the new locations into new_stack
							table.insert(new_stack, retpos)
						end
					end
				end
				stack = new_stack -- replace the old stack with the new
			end
			for _, donepos in ipairs(stack) do
				-- After all the iterations are done, if there's any leftover growing positions set a timer for each of them
				minetest.get_node_timer(donepos):start(math.random(min_growth_delay,max_growth_delay))
			end
		else
			-- just do one iteration.
			local new_meristems = grow_mycelium(pos, "df_primordial_items:giant_hypha_apical_meristem")
			if new_meristems == nil then
				-- We hit the end of the known world, try again later. Unlikely in this case, but theoretically possible I guess.
				minetest.get_node_timer(pos):start(math.random(min_growth_delay,max_growth_delay))
			else
				for _, newpos in ipairs(new_meristems) do
					minetest.get_node_timer(newpos):start(math.random(min_growth_delay,max_growth_delay))
				end
			end
		end		
	end,
})

-- this version grows instantly via ABM, it is meant for mapgen usage
minetest.register_node("df_primordial_items:giant_hypha_apical_mapgen", {
	description = S("Giant Hypha Apical Meristem"),
	tiles = {
		{name="dfcaverns_mush_giant_hypha.png^[brighten"},
	},
    connects_to = {"group:hypha"},
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },
	drawtype = "nodebox",
	light_source = 6,
	node_box = get_node_box(0.25, 0.375),
	paramtype = "light",

	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha = 1, not_in_creative_inventory = 1},
	sounds = df_trees.node_sound_tree_soft_fungus_defaults(),
})

local grow_mycelium_immediately = function(pos)
	local stack = {pos}
	while #stack > 0 do
		local pos = table.remove(stack)
		local new_poses = grow_mycelium(pos, "df_primordial_items:giant_hypha_apical_mapgen")
		if new_poses then -- if we hit the end of the world, just stop. There'll be a mapgen meristem left here, the abm will re-trigger it when the player gets close.
			for _, new_pos in ipairs(new_poses) do
				table.insert(stack, new_pos)
			end
		end
	end	
end

minetest.register_abm({
	label = "Mycelium mapgen growth",
	nodenames = {"df_primordial_items:giant_hypha_apical_mapgen"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		grow_mycelium_immediately(pos)
	end
})
