local S = df_mapitems.S

minetest.register_node("df_mapitems:veinstone", {
	description = S("Veinstone"),
	_doc_items_longdesc = df_mapitems.doc.veinstone_desc,
	_doc_items_usagehelp = df_mapitems.doc.veinstone_usage,
	tiles = {df_mapitems.texture.stone .. "^dfcaverns_veins.png"},
	groups = {cracky = 3, stone = 1, lava_heatable = 1},
	_magma_conduits_heats_to = df_mapitems.node_name.cobble,
	is_ground_content = false,
	light_source = 2,
	drop = "df_mapitems:veinstone",
	sounds = df_mapitems.sounds.stone,
	on_punch = function(pos, node, puncher, pointed_thing)
        minetest.node_punch(pos, node, puncher, pointed_thing)
		minetest.swap_node(pos, {name="df_mapitems:veinstone_pulse"})
		minetest.get_node_timer(pos):start(2)
	end,
})

minetest.register_node("df_mapitems:veinstone_pulse", {
	description = S("Veinstone"),
	_doc_items_longdesc = df_mapitems.doc.veinstone_desc,
	_doc_items_usagehelp = df_mapitems.doc.veinstone_usage,
	tiles = {df_mapitems.texture.stone .. "^dfcaverns_veins.png"},
	groups = {cracky = 3, stone = 1, lava_heatable = 1, not_in_creative_inventory = 1},
	_magma_conduits_heats_to = df_mapitems.node_name.cobble,
	is_ground_content = false,
	light_source = 8,
	drop = "df_mapitems:veinstone",
	sounds = df_mapitems.sounds.stone,
	on_timer = function(pos, elapsed)
		local positions, count = minetest.find_nodes_in_area(vector.add(pos,1), vector.subtract(pos,1), "df_mapitems:veinstone")
		if count["df_mapitems:veinstone"] == 0 then
			positions, count = minetest.find_nodes_in_area(vector.add(pos,2), vector.subtract(pos,2), "df_mapitems:veinstone")
		end
		if count["df_mapitems:veinstone"] == 0 then
			positions = {[1] = minetest.find_node_near(pos, 3, "df_mapitems:veinstone")}
		end
		if positions[1] == nil then
			positions = {[1] = minetest.find_node_near(pos, 4, "df_mapitems:veinstone")}
		end
		for _, neighbor_pos in pairs(positions) do
			minetest.swap_node(neighbor_pos, {name="df_mapitems:veinstone_pulse"})
			minetest.get_node_timer(neighbor_pos):start(2)
		end		
		minetest.swap_node(pos, {name="df_mapitems:veinstone_refractory"})
		minetest.get_node_timer(pos):start(12)
	end,
})

minetest.register_node("df_mapitems:veinstone_refractory", {
	description = S("Veinstone"),
	_doc_items_longdesc = df_mapitems.doc.veinstone_desc,
	_doc_items_usagehelp = df_mapitems.doc.veinstone_usage,
	tiles = {df_mapitems.texture.stone .. "^dfcaverns_veins.png"},
	groups = {cracky = 3, stone = 1, lava_heatable = 1, not_in_creative_inventory = 1},
	_magma_conduits_heats_to = df_mapitems.node_name.cobble,
	is_ground_content = false,
	light_source = 1,
	drop = "df_mapitems:veinstone",
	sounds = df_mapitems.sounds.stone,
	on_timer = function(pos, elapsed)
		minetest.swap_node(pos, {name="df_mapitems:veinstone"})
	end,
})