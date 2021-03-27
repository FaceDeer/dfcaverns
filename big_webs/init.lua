local modname = minetest.get_current_modname()
local S = minetest.get_translator(modname)

local default_path = minetest.get_modpath("default")

local get_node_box = function(connector_thickness)
	return {
		type = "connected",
		--fixed = {-hub_thickness,-hub_thickness,-hub_thickness,hub_thickness,hub_thickness,hub_thickness},
		connect_top = {-connector_thickness, 0, -connector_thickness, connector_thickness, 0.5, connector_thickness},
		connect_bottom = {-connector_thickness, -0.5, -connector_thickness, connector_thickness, 0, connector_thickness},
		connect_back = {-connector_thickness, -connector_thickness, 0, connector_thickness, connector_thickness, 0.5},
		connect_right = {0, -connector_thickness, -connector_thickness, 0.5, connector_thickness, connector_thickness},
		connect_front = {-connector_thickness, -connector_thickness, -0.5, connector_thickness, connector_thickness, 0},
		connect_left = {-0.5, -connector_thickness, -connector_thickness, 0, connector_thickness, connector_thickness},
		disconnected = {-connector_thickness, -connector_thickness, -connector_thickness, connector_thickness, connector_thickness, connector_thickness},
	}
end

local in_anchor_group = function(name)
	return
		minetest.get_item_group(name, "soil") > 0 or
		minetest.get_item_group(name, "stone") > 0 or
		minetest.get_item_group(name, "tree") > 0 or
		minetest.get_item_group(name, "leaves") > 0 or
		minetest.get_item_group(name, "sand") > 0 or
		minetest.get_item_group(name, "wood") > 0
end

local cardinal_directions = {
	{x=1,y=0,z=0},
	{x=-1,y=0,z=0},
	{x=0,y=1,z=0},
	{x=0,y=1,z=0},
	{x=0,y=0,z=1},
	{x=0,y=0,z=-1}
}

local insert_if_not_in_hashtable = function(pos, insert_into, if_not_in)
	local hash = minetest.hash_node_position(pos)
	if if_not_in[hash] then
		return
	end
	table.insert(insert_into, pos)
end

-- flood fill through the web to get all web and anchor locations
local get_web_nodes = function(pos, webs, anchors)
	local to_check = {}
	table.insert(to_check, pos)
	while next(to_check) ~= nil do
		local check_pos = table.remove(to_check)
		local check_node = minetest.get_node(check_pos)
		if minetest.get_item_group(check_node.name, "webbing") > 0 then
			webs[minetest.hash_node_position(check_pos)] = true
			for _, dir in pairs(cardinal_directions) do
				insert_if_not_in_hashtable(vector.add(check_pos, dir), to_check, webs)
			end
		elseif in_anchor_group(check_node.name) then
			anchors[minetest.hash_node_position(check_pos)] = true
		end		
	end	
end

local sound
if default_path then
	sound = default.node_sound_leaves_defaults()
end

minetest.register_node("big_webs:webbing", {
	description = S("Big Spiderweb"),
	_doc_items_longdesc = S("Thick ropes of sticky silk, strung between cavern walls in hopes of catching bats and larger beasts."),
	_doc_items_usagehelp = S("Webbing can be collected and re-strung elsewhere to aid in climbing."),
	tiles = {
		{name="big_webs.png"},
	},
	use_texture_alpha = "blend",
    connects_to = {"group:soil", "group:stone", "group:tree", "group:leaves", "group:sand", "group:wood", "group:webbing"},
    connect_sides = { "top", "bottom", "front", "left", "back", "right" },
	drawtype = "nodebox",
	node_box = get_node_box(0.0625),
	collision_box = get_node_box(0.0625),
	paramtype = "light",
	--light_source = 2,
	is_ground_content = false,
	climbable = true,
	walkable = false,
	floodable = true,
	groups = {choppy = 2, webbing = 1, flammable=1},
	sounds = sound,
	on_timer = function(pos, elapsed)
		local webs = {}
		local anchors = {}
		get_web_nodes(pos, webs, anchors)
		local first_anchor = next(anchors)
--		if first_anchor then
--			minetest.chat_send_all("supported")
--		else
--			minetest.chat_send_all("unsupported")
--		end
		for hash, _ in pairs(webs) do
			local web_pos = minetest.get_position_from_hash(hash)
			if first_anchor == nil then
				-- unsupported web
				minetest.set_node(web_pos, {name="air"})
			end
			minetest.get_node_timer(web_pos):stop() -- no need to recheck
		end	
	end,
})