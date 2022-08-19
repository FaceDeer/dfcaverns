local S = minetest.get_translator(minetest.get_current_modname())
local nethercap_name = df_dependencies.nethercap_name

local lava_node = df_dependencies.node_name_lava_source

local node_types = {}
node_types.fungiwood = {"df_trees:fungiwood", "df_trees:fungiwood_shelf"}
node_types.towercap = {"df_trees:tower_cap_stem", "df_trees:tower_cap_gills", "df_trees:tower_cap"}
node_types.goblincap = {"df_trees:goblin_cap_stem", "df_trees:goblin_cap", "df_trees:goblin_cap_gills"}
node_types.sporetree = {"df_trees:spore_tree", "df_trees:spore_tree_hyphae", "df_trees:spore_tree_fruiting_body"}
node_types.tunneltube = {"df_trees:tunnel_tube", "df_trees:tunnel_tube_slant_bottom", "df_trees:tunnel_tube_slant_top", "df_trees:tunnel_tube_slant_full", "df_trees:tunnel_tube_fruiting_body"}
node_types.nethercap = {"df_mapitems:icicle_1", "df_mapitems:icicle_2", "df_mapitems:icicle_3", "df_mapitems:icicle_4", "ice_sprites:ice_sprite", "ice_sprites:hidden_ice_sprite", "df_trees:nether_cap", "df_trees:nether_cap_gills", "df_trees:nether_cap_stem"}
node_types.bloodthorn = {"df_trees:blood_thorn", "df_trees:blood_thorn_spike"}
node_types.blackcap = {"df_trees:black_cap", "df_trees:black_cap_stem", "df_trees:black_cap_gills", "df_trees:torchspine_1", "df_trees:torchspine_1_lit", "df_trees:torchspine_2", "df_trees:torchspine_3", "df_trees:torchspine_4"}
node_types.primordial_jungle = {"df_primordial_items:giant_fern_leaves", "df_primordial_items:giant_fern_tree", "df_primordial_items:giant_fern_tree_slant_bottom", "df_primordial_items:giant_fern_tree_slant_full", "df_primordial_items:giant_fern_tree_slant_top", "df_primordial_items:jungle_leaves", "df_primordial_items:jungle_leaves_glowing", "df_primordial_items:jungle_mushroom_cap_1", "df_primordial_items:jungle_mushroom_cap_2", "df_primordial_items:jungle_mushroom_trunk",  "df_primordial_items:jungle_tree", "df_primordial_items:jungle_tree_glowing", "df_primordial_items:jungle_tree_mossy", "df_primordial_items:packed_roots", "df_primordial_items:plant_matter", }
node_types.primordial_fungus = {"df_primordial_items:giant_hypha_root", "df_primordial_items:giant_hypha", "df_primordial_items:mushroom_cap", "df_primordial_items:mushroom_gills", "df_primordial_items:mushroom_gills_glowing", "df_primordial_items:mushroom_trunk", "df_primordial_items:glownode", "df_primordial_items:glownode_stalk",}
node_types.other = {"oil:oil_source", "df_underworld_items:slade", lava_node, "df_underworld_items:glow_amethyst"}

local all_nodes = {}
for _, nodes in pairs(node_types) do
	for _, node in pairs(nodes) do
		table.insert(all_nodes, node)
	end
end

local radius = 6
local get_player_data = function(player)
	-- get head level node at player position
	local pos = player:get_pos()
	if not pos then return end
	
	-- get all set nodes around player
	local ps, cn = minetest.find_nodes_in_area(
		{x = pos.x - radius, y = pos.y - radius, z = pos.z - radius},
		{x = pos.x + radius, y = pos.y + radius, z = pos.z + radius}, all_nodes)
		
	return {
		pos = pos,
		biome = df_caverns.get_biome(pos) or "",
		totals = cn
	}
end

local check_nodes = function(nodes, totals)
	for _, node in pairs(nodes) do
		if (totals[node] or 0) > 1 then
			return true
		end
	end
	return false
end

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer < 10 then return end
	timer = 0

	local player_name
	local player_awards
	local player_data

	-- loop through players
	for _, player in pairs(minetest.get_connected_players()) do
		player_name = player:get_player_name()
		player_awards = awards.player(player_name)
		if player_awards.unlocked["dfcaverns_visit_all_caverns"] ~= "dfcaverns_visit_all_caverns" or
			player_awards.unlocked["dfcaverns_visit_glowing_pit"] ~= "dfcaverns_visit_glowing_pit" then
			player_data = get_player_data(player)
			biome = player_data.biome
			totals = player_data.totals
			
			if biome == "towercap" and check_nodes(node_types.towercap, totals) then
				awards.unlock(player_name, "dfcaverns_visit_tower_cap")
			elseif biome == "fungiwood" and check_nodes(node_types.fungiwood, totals) then
				awards.unlock(player_name, "dfcaverns_visit_fungiwood")
			elseif biome == "goblincap" and check_nodes(node_types.goblincap, totals) then
				awards.unlock(player_name, "dfcaverns_visit_goblin_cap")
			elseif biome == "sporetree" and check_nodes(node_types.sporetree, totals) then
				awards.unlock(player_name, "dfcaverns_visit_spore_tree")
			elseif biome == "tunneltube" and check_nodes(node_types.tunneltube, totals) then
				awards.unlock(player_name, "dfcaverns_visit_tunnel_tube")
			elseif biome == "nethercap" and check_nodes(node_types.nethercap, totals) then
				awards.unlock(player_name, "dfcaverns_visit_nethercap")
			elseif biome == "bloodthorn" and check_nodes(node_types.bloodthorn, totals) then
				awards.unlock(player_name, "dfcaverns_visit_blood_thorn")
			elseif biome == "blackcap" and check_nodes(node_types.blackcap, totals) then
				awards.unlock(player_name, "dfcaverns_visit_black_cap")
			elseif (biome == "fungispore" and (check_nodes(node_types.fungiwood, totals) or check_nodes(node_types.sporetree, totals))) or 
				(biome == "towergoblin" and (check_nodes(node_types.towercap, totals) or check_nodes(node_types.goblincap, totals)))
				then
					awards.unlock(player_name, "dfcaverns_visit_sunless_sea")
			elseif biome == "oil_sea" and (totals["oil:oil_source"] or 0) > 1 then
				awards.unlock(player_name, "dfcaverns_visit_oil_sea")			
			elseif biome == "underworld" then
				if (totals["df_underworld_items:slade"] or 0) > 1 then
					awards.unlock(player_name, "dfcaverns_visit_underworld")
				end
				if (totals["df_underworld_items:glow_amethyst"] or 0) > 1 and
					player_awards.unlocked["dfcaverns_visit_glowing_pit"] ~= "dfcaverns_visit_glowing_pit" then
					local player_pos = player:get_pos()
					local pit = df_caverns.get_nearest_glowing_pit(player_pos)
					pit.location.y = player_pos.y
					if vector.distance(player_pos, pit.location) <= pit.radius+10 then
						awards.unlock(player_name, "dfcaverns_visit_glowing_pit")
					end					
				end
			elseif biome == "lava_sea" and (totals[lava_node] or 0) > 1 then
				awards.unlock(player_name, "dfcaverns_visit_lava_sea")			
			elseif biome == "primordial fungus" and check_nodes(node_types.primordial_fungus, totals) then
				awards.unlock(player_name, "dfcaverns_visit_primordial_fungal")
			elseif biome == "primordial jungle" and check_nodes(node_types.primordial_jungle, totals) then
				awards.unlock(player_name, "dfcaverns_visit_primordial_jungle")
			end
		end
		if player_awards.unlocked["dfcaverns_visit_chasm"] ~= "dfcaverns_visit_chasm" and chasms.is_in_chasm(player:get_pos()) then
			awards.unlock(player_name, "dfcaverns_visit_chasm")
		end
		if player_awards.unlocked["dfcaverns_visit_pit"] ~= "dfcaverns_visit_pit" then
			local pos = player:get_pos()
			local pos_y = pos.y
			if pos_y < -30 then -- ignore pits when near the surface
				local nearest_pit = pit_caves.get_nearest_pit(pos)
				nearest_pit.location.y = pos_y -- for the distance check
				if pos_y >= nearest_pit.depth and pos_y <= nearest_pit.top and vector.distance(pos, nearest_pit.location) <= 30 then
					awards.unlock(player_name, "dfcaverns_visit_pit")
				end
			end	
		end
	end
end)

local upper_biome_achievements = {"dfcaverns_visit_tower_cap", "dfcaverns_visit_fungiwood", "dfcaverns_visit_goblin_cap", "dfcaverns_visit_spore_tree", "dfcaverns_visit_tunnel_tube", "dfcaverns_visit_nethercap", "dfcaverns_visit_blood_thorn", "dfcaverns_visit_black_cap", "dfcaverns_visit_sunless_sea"}

local middle_biome_achievements = {"dfcaverns_visit_oil_sea", "dfcaverns_visit_lava_sea", "dfcaverns_visit_underworld"}

local primordial_biome_achievements = {"dfcaverns_visit_primordial_jungle", "dfcaverns_visit_primordial_fungal"}

local all_caverns = {"dfcaverns_visit_all_upper_biomes", "dfcaverns_visit_all_middle_biomes", "dfcaverns_visit_all_primordial_biomes", "dfcaverns_visit_chasm", "dfcaverns_visit_pit"}

local test_list = df_achievements.test_list

--    name is the player name
--    def is the award def.
awards.register_on_unlock(function(player_name, def)
	local player_awards = awards.player(player_name)
	if not player_awards or not player_awards.unlocked then
		return
	end
	local unlocked = player_awards.unlocked
	test_list(player_name, "dfcaverns_visit_all_upper_biomes", unlocked, upper_biome_achievements)
	test_list(player_name, "dfcaverns_visit_all_middle_biomes", unlocked, middle_biome_achievements)
	test_list(player_name, "dfcaverns_visit_all_primordial_biomes", unlocked, primordial_biome_achievements)
	test_list(player_name, "dfcaverns_visit_all_caverns", unlocked, all_caverns)
end)


--awards.unlock(name, award)
--	local data  = awards.players[name]
--	local awdef = awards.def[award]
-- 	data.unlocked[award] == award

-- travelogue

--biomes

awards.register_achievement("dfcaverns_visit_tower_cap", {
	title = S("Discover Tower Caps"),
	description = S("Discover a cavern where Tower Caps grow in the wild."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_fungiwood", {
	title = S("Discover Fungiwood"),
	description = S("Discover a cavern where Fungiwoods grow in the wild."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_goblin_cap", {
	title = S("Discover Goblin Caps"),
	description = S("Discover a cavern where Goblin Caps grow in the wild."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_spore_tree", {
	title = S("Discover Spore Trees"),
	description = S("Discover a cavern where Spore Trees grow in the wild."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_tunnel_tube", {
	title = S("Discover Tunnel Tubes"),
	description = S("Discover a cavern where Tunnel Tubes grow in the wild."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_nethercap", {
	title = S("Discover @1s", nethercap_name),
	description = S("Discover a cavern where @1s grow in the wild.", nethercap_name),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_blood_thorn", {
	title = S("Discover Bloodthorns"),
	description = S("Discover a cavern where Bloodthorns grow in the wild."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_black_cap", {
	title = S("Discover Black Caps"),
	description = S("Discover a cavern where Black Caps grow in the wild."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_sunless_sea", {
	title = S("Discover the Sunless Sea"),
	description = S("Discover the giant caverns to which all water from the surface ultimately drain."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_all_upper_biomes", {
	title = S("Discover All Fungal Cavern Types"),
	description = S("Discover examples of all of the fungal cavern biomes."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_oil_sea", {
	title = S("Discover the Oil Sea"),
	description = S("Discover a cavern containing oil deep underground."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_lava_sea", {
	title = S("Discover the Magma Sea"),
	description = S("Discover the sea of magma that volcanoes draw from."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_underworld", {
	title = S("Discover the Underworld"),
	description = S("Discover the ancient caverns at the foundations of the world."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_all_middle_biomes", {
	title = S("Discover All Overworld Cavern Types"),
	description = S("Discover all of the major types of cavern environments between the Sunless Sea and the foundations of the world."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_primordial_jungle", {
	title = S("Discover the Primordial Jungle"),
	description = S("Discover the lost jungles below the foundations of the world."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_primordial_fungal", {
	title = S("Discover the Primordial Fungus"),
	description = S("Discover the fungus-ridden caverns below the foundations of the world."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_all_primordial_biomes", {
	title = S("Discover all Primordial Cavern Types"),
	description = S("Discover all of the major types of cavern below the foundations of the world."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_chasm", {
	title = S("Discover a Deep Chasm"),
	description = S("Discover a gigantic underground natural chasm."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_pit", {
	title = S("Discover a Deep Sinkhole"),
	description = S("Discover a deep natural sinkhole."),
	--icon =,
})

awards.register_achievement("dfcaverns_visit_all_caverns", {
	title = S("Discover All Underground Cavern Types"),
	description = S("Discover all major kinds of giant cavern environment."),
	--icon =,
})

-- other places

awards.register_achievement("dfcaverns_visit_glowing_pit", {
	title = S("Discover a Glowing Pit"),
	description = S("Discover a glowing pit in the slade foundations of the world."),
	--icon =,
})
