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
		disconnected = {-connector_thickness,-connector_thickness,-connector_thickness,connector_thickness,connector_thickness,connector_thickness},
	}
end


minetest.register_node("df_primordial_items:giant_hypha_root", {
	description = S("Giant Hypha"),
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
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha =1},
	sounds = default.node_sound_wood_defaults(),
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
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha =1},
	sounds = default.node_sound_wood_defaults(),
})

local find_mycelium_growth_targets = function(pos)
	local nodes = {}
	for x = -1, 1 do
		nodes[x] = {}
		for y = -1, 1 do
			nodes[x][y] = {}
			for z = -1, 1 do
				if not (x == y and y == z) then -- we don't care about the diagonals or the center node
					local node = minetest.get_node({x=pos.x+x, y=pos.y+y, z=pos.z+z})
					local state = {}
					if minetest.get_item_group(node.name, "soil") > 0 then
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

	if math.random() < 0.05 then
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

local min_growth_delay = minetest.settings:get_key("dfcaverns_mycelium_min_growth_delay") or 240
local max_growth_delay = minetest.settings:get_key("dfcaverns_mycelium_max_growth_delay") or 400

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
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(min_growth_delay,max_growth_delay))
	end,
	on_timer = function(pos, elapsed)
		local new_meristems = grow_mycelium(pos, "df_primordial_items:giant_hypha_apical_meristem")
		for _, newpos in ipairs(new_meristems) do
			minetest.get_node_timer(newpos):start(math.random(min_growth_delay,max_growth_delay))
		end
	end,
})

-- this version grows instantly via ABM, is meant for mapgen usage
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
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha = 1, light_sensitive_fungus = 13},
	sounds = default.node_sound_wood_defaults(),
})

df_primordial_items.grow_mycelium_immediately = function(pos)
	local stack = {pos}
	while #stack > 0 do
		local pos = table.remove(stack)
		local new_poses = grow_mycelium(pos, "df_primordial_items:giant_hypha_apical_meristem")
		for _, new_pos in ipairs(new_poses) do
			table.insert(stack, new_pos)
		end
	end	
end

minetest.register_abm({
	label = "Mycelium mapgen growth",
	nodenames = {"df_primordial_items:giant_hypha_apical_mapgen"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		df_primordial_items.grow_mycelium_immediately(pos)
	end
})
