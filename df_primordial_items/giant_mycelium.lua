-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local hub_thickness = 0.1875--0.25
local connector_thickness = 0.25--0.375
local node_box = {
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


minetest.register_node("df_primordial_items:giant_hypha_root", {
	description = S("Giant Hypha"),
	tiles = {
		{name="dfcaverns_mush_stalk_side.png"},
	},
    connects_to = {"group:soil", "group:hypha"},
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },
	drawtype = "nodebox",
	node_box = node_box,
	paramtype = "light",
	light_source = 2,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha =1},
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_node("df_primordial_items:giant_hypha", {
	description = S("Giant Hypha"),
	tiles = {
		{name="dfcaverns_mush_stalk_side.png"},
	},
    connects_to = {"group:hypha"},
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },
	drawtype = "nodebox",
	node_box = node_box,
	paramtype = "light",
	light_source = 2,
	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha =1},
	sounds = default.node_sound_wood_defaults(),
})

local grow_mycelium = function(pos)
	local nodes = {}
	for x = -1, 1 do
		nodes[x] = {}
		for y = -1, 1 do
			nodes[x][y] = {}
			for z = -1, 1 do
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

	--TODO there's probably some clever way to turn this into a subroutine, but I'm tired right now and
	--copy and pasting is easy and nobody's going to decide whether to hire or fire me based on this
	--particular snippet of code so what the hell. I'll fix it later when that clever way comes to me.
	local valid_targets = {}
	if nodes[-1][0][0].buildable then
		if 
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
	end
	if nodes[1][0][0].buildable then
		if 
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
	end
	if nodes[0][-1][0].buildable then
			if 
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
	end
	if nodes[0][1][0].buildable then
			if 
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
	end
	if nodes[0][0][-1].buildable then
		if 
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
	end
	if nodes[0][0][1].buildable then
		if 
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
	end
	
	return valid_targets
end


minetest.register_node("df_primordial_items:giant_hypha_apical_meristem", {
	description = S("Giant Hypha Apical Meristem"),
	tiles = {
		{name="dfcaverns_mush_stalk_side.png^[brighten"},
	},
    connects_to = {"group:hypha"},
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },
	drawtype = "nodebox",
	light_source = 6,
	node_box = {
        type = "connected",
        fixed = {-0.25,-0.25,-0.25,0.25,0.25,0.25},
        connect_top = {-0.375, 0, -0.375, 0.375, 0.5, 0.375},
        connect_bottom = {-0.375, -0.5, -0.375, 0.375, 0, 0.375},
        connect_back = {-0.375, -0.375, 0, 0.375, 0.375, 0.5},
        connect_right = {0, -0.375, -0.375, 0.5, 0.375, 0.375},
        connect_front = {-0.375, -0.375, -0.5, 0.375, 0.375, 0},
        connect_left = {-0.5, -0.375, -0.375, 0, 0.375, 0.375},
        disconnected = {-0.375,-0.375,-0.375,0.375,0.375,0.375},
    },
	paramtype = "light",

	is_ground_content = false,
	groups = {oddly_breakable_by_hand = 1, choppy = 2, hypha =1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_timer = function(pos, elapsed)
		--if math.random() < 0.99 then
			local targets = grow_mycelium(pos)
			local target_count = #targets
			if target_count > 0 then
				minetest.set_node(targets[math.random(1,target_count)], {name="df_primordial_items:giant_hypha_apical_meristem"})
			end
		--end
		if math.random() < 0.05 then
			minetest.get_node_timer(pos):start(1.0) -- branch
		elseif math.random() < 0.5 then
			minetest.set_node(pos, {name="df_primordial_items:giant_hypha_root"})
		else
			minetest.set_node(pos, {name="df_primordial_items:giant_hypha"})
		end
	end,
})
