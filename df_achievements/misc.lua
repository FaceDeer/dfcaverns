local S = minetest.get_translator(minetest.get_current_modname())

-- misc
if df_dependencies.node_name_glass_bottle then
	awards.register_achievement("dfcaverns_captured_ice_sprite", {
		title = S("Capture an Ice Sprite"),
		description = S("You've captured an ice sprite and placed it in a bottle. It dances and sparkles and sheds light through the frosted glass while making a faint tinkling sound. Pretty."),
		--icon =,
		trigger = {
			type = "craft",
			item = "ice_sprites:ice_sprite_bottle",
			target = 1,
		},
	})
end

df_mapitems.on_veinstone_punched = function(pos, node, puncher, pointed_thing)
	awards.unlock(puncher:get_player_name(), "dfcaverns_punched_veinstone")
end
awards.register_achievement("dfcaverns_punched_veinstone", {
	title = S("Punch Veinstone"),
	description = S(""),
	--icon =,
})

if minetest.get_modpath("df_underworld_items") then

	if minetest.get_modpath("hunter_statue") then
		hunter_statue.player_punched = function(node_name, pos, player)
			if node_name ~= "df_underworld_items:hunter_statue" then return end
			awards.unlock(player:get_player_name(), "dfcaverns_attacked_by_guardian_statue")
		end
		awards.register_achievement("dfcaverns_attacked_by_guardian_statue", {
			title = S("Get Attacked by an Underworld Guardian"),
			description = S(""),
			--icon =,
		})
	end

	df_underworld_items.puzzle_seal_solved = function(pos, player)
		if player == nil then return end
		awards.unlock(player:get_player_name(), "dfcaverns_solved_puzzle_seal")
	end 
	awards.register_achievement("dfcaverns_solved_puzzle_seal", {
		title = S("Solve a Puzzle Seal"),
		description = S(""),
		--icon =,
	})
	
	df_underworld_items.slade_breacher_triggered = function(pos, player)
		awards.unlock(player:get_player_name(), "dfcaverns_triggered_slade_breacher")
	end
	awards.register_achievement("dfcaverns_triggered_slade_breacher", {
		title = S("Trigger a Slade Breacher"),
		description = S(""),
		--icon =,
		secret=true,
	})
	
	df_underworld_items.ancient_lantern_fixed = function(pos, player)
		awards.unlock(player:get_player_name(), "dfcaverns_repaired_lantern")
	end
	awards.register_achievement("dfcaverns_repaired_lantern", {
		title = S("Repair an Ancient Lantern"),
		description = S(""),
		--icon =,
	})

--	awards.register_achievement("dfcaverns_repaired_100_lanterns", {
--		title = S("Repair 100 Ancient Lanterns"),
--		description = S(""),
--		--icon =,
--	})

end


-- can't think of an easy way to detect these
--awards.register_achievement("dfcaverns_torch_detonated_mine_gas", {
--	title = S("Detonate Mine Gas"),
--	description = S(""),
--	--icon =,
--})

--awards.register_achievement("dfcaverns_looted_underworld_bones", {
--	title = S("Loot Ancient Warrior Bones"),
--	description = S(""),
--	--icon =,
--})
--
--awards.register_achievement("dfcaverns_looted_100_underworld_bones", {
--	title = S("Loot 100 Ancient Warrior Bones"),
--	description = S(""),
--	--icon =,
--})
