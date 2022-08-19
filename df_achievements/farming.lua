local S = minetest.get_translator(minetest.get_current_modname())
local nethercap_name = df_dependencies.nethercap_name

-- forestry

local plant_node_achievements =
{
	["df_trees:black_cap_sapling"] = {achievement="dfcaverns_plant_black_cap", title=S("Plant Black Cap"), desc=S(""), icon=""},
	["df_trees:fungiwood_sapling"] = {achievement="dfcaverns_plant_fungiwood", title=S("Plant Fungiwood"), desc=S(""), icon=""},
	["df_trees:goblin_cap_sapling"] = {achievement="dfcaverns_plant_goblin_cap", title=S("Plant Goblin Cap"), desc=S(""), icon=""},
	["df_trees:nether_cap_sapling"] = {achievement="dfcaverns_plant_nethercap", title=S("Plant @1", nethercap_name), desc=S(""), icon=""},
	["df_trees:spore_tree_sapling"] = {achievement="dfcaverns_plant_spore_tree", title=S("Plant Spore Tree"), desc=S(""), icon=""},
	["df_trees:tower_cap_sapling"] = {achievement="dfcaverns_plant_tower_cap", title=S("Plant Tower Cap"), desc=S(""), icon=""},
	["df_trees:tunnel_tube_sapling"] = {achievement="dfcaverns_plant_tunnel_tube", title=S("Plant Tunnel Tube"), desc=S(""), icon=""},
	["df_trees:torchspine_ember"] = {achievement="dfcaverns_plant_torchspine", title=S("Plant Torchspine"), desc=S(""), icon=""},
	["df_trees:spindlestem_seedling"] = {achievement="dfcaverns_plant_spindlestem", title=S("Plant Spindlestem"), desc=S(""), icon=""},
	["df_trees:blood_thorn"] = {achievement="dfcaverns_plant_bloodthorn", title=S("Plant Bloodthorn"), desc=S(""), icon=""},
	["df_primordial_items:giant_hypha_apical_meristem"] = {achievement="dfcaverns_plant_giant_mycelium", title=S("Plant Primordial Mycelium"), desc=S(""), icon=""},
	["df_primordial_items:fern_sapling"] = {achievement="dfcaverns_plant_primordial_fern", title=S("Plant Primordial Fern"), desc=S(""), icon=""},
	["df_primordial_items:jungle_mushroom_sapling"] = {achievement="dfcaverns_plant_primordial_jungle_mushroom", title=S("Plant Primordial Jungle Mushroom"), desc=S(""), icon=""},
	["df_primordial_items:jungletree_sapling"] = {achievement="dfcaverns_plant_primordial_jungletree", title=S("Plant Primordial Jungle Tree"), desc=S(""), icon=""},
	["df_primordial_items:mush_sapling"] = {achievement="dfcaverns_plant_primordial_mushroom", title=S("Plant Primordial Mushroom"), desc=S(""), icon=""},
	["df_farming:cave_wheat_seed"] = {achievement="dfcaverns_plant_cave_wheat", title=S("Plant Cave Wheat"), desc=S(""), icon=""},
	["df_farming:dimple_cup_seed"] = {achievement="dfcaverns_plant_dimple_cup", title=S("Plant Dimple Cup"), desc=S(""), icon=""},
	["df_farming:pig_tail_seed"] = {achievement="dfcaverns_plant_pig_tail", title=S("Plant Pig Tail"), desc=S(""), icon=""},
	["df_farming:plump_helmet_spawn"] = {achievement="dfcaverns_plant_plump_helmet", title=S("Plant Plump Helmet"), desc=S(""), icon=""},
	["df_farming:quarry_bush_seed"] = {achievement="dfcaverns_plant_quarry_bush", title=S("Plant Quarry Bush"), desc=S(""), icon=""},
	["df_farming:sweet_pod_seed"] = {achievement="dfcaverns_plant_sweet_pod", title=S("Plant Sweet Pod"), desc=S(""), icon=""},
}

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	local player_name = placer:get_player_name()
	if player_name == nil then return end
	local player_awards = awards.player(player_name)
	local achievement = plant_node_achievements[newnode.name]
	if not achievement then return end
	local achievement_name = achievement.achievement
	if not player_awards or player_awards.unlocked[achievement_name] ~= achievement_name then
		-- all of the growable plants in DFCaverns are timer-based. If you place
		-- a seedling or seed and the resulting node has a timer running, then
		-- it's passed the checks to see if it was placed in a growable area.
		if minetest.get_node_timer(pos):is_started() then
			awards.unlock(player_name, achievement_name)
		end
	end
end)

--"dfcaverns_plant_all_farmables",
local all_farmable_achievements = {"dfcaverns_plant_cave_wheat", "dfcaverns_plant_dimple_cup", "dfcaverns_plant_pig_tail", "dfcaverns_plant_plump_helmet", "dfcaverns_plant_quarry_bush", "dfcaverns_plant_sweet_pod",}
--"dfcaverns_plant_all_primordial",
local all_primordial_achievements = {"dfcaverns_plant_giant_mycelium", "dfcaverns_plant_primordial_fern", "dfcaverns_plant_primordial_jungle_mushroom", "dfcaverns_plant_primordial_jungletree", "dfcaverns_plant_primordial_mushroom",}
--"dfcaverns_plant_all_underground_trees",
local all_underground_trees_achievements = {"dfcaverns_plant_all_upper_trees", "dfcaverns_plant_all_primordial"}
--"dfcaverns_plant_all_upper_trees",
local all_upper_trees = {"dfcaverns_plant_black_cap", "dfcaverns_plant_fungiwood", "dfcaverns_plant_goblin_cap", "dfcaverns_plant_nethercap", "dfcaverns_plant_spore_tree", "dfcaverns_plant_tower_cap", "dfcaverns_plant_tunnel_tube", "dfcaverns_plant_torchspine","dfcaverns_plant_spindlestem"}

local test_list = df_achievements.test_list

--    name is the player name
--    def is the award def.
awards.register_on_unlock(function(player_name, def)
	local player_awards = awards.player(player_name)
	if not player_awards or not player_awards.unlocked then
		return
	end
	local unlocked = player_awards.unlocked
	test_list(player_name, "dfcaverns_plant_all_farmables", unlocked, all_farmable_achievements)
	test_list(player_name, "dfcaverns_plant_all_primordial", unlocked, all_primordial_achievements)
	test_list(player_name, "dfcaverns_plant_all_underground_trees", unlocked, all_underground_trees_achievements)
	test_list(player_name, "dfcaverns_plant_all_upper_trees", unlocked, all_upper_trees)
end)

for achievement, def in pairs(plant_node_achievements) do
	awards.register_achievement(achievement, {
		title = def.title,
		description = def.desc,
		--icon = def.icon,
	})
end

awards.register_achievement("dfcaverns_plant_all_upper_trees", {
	title = S("Plant All Fungal Tree Types"),
	description = S(""),
	--icon =,
})

awards.register_achievement("dfcaverns_plant_all_primordial", {
	title = S("Plant All Primordial Tree Types"),
	description = S(""),
	--icon =,
})

awards.register_achievement("dfcaverns_plant_all_underground_trees", {
	title = S("Plant All Underground Tree Types"),
	description = S(""),
	--icon =,
})

awards.register_achievement("dfcaverns_plant_all_farmables", {
	title = S("Plant All Farmable Underground Plants"),
	description = S(""),
	--icon =,

})