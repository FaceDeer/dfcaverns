local S = minetest.get_translator(minetest.get_current_modname())

local steel_pick = df_dependencies.texture_tool_steelpick
local steel_shovel = df_dependencies.texture_tool_steelshovel

local crossed_pick_and_shovel = "((("..steel_shovel.."^[transformFX)^"..steel_pick..")^[resize:32x32)"

awards.register_achievement("dfcaverns_destroyed_gas_seep", {
	title = S("Destroy a Gas Seep"),
	description = S(""),
	--icon =,
	trigger = {
		type = "dig",
		node = "mine_gas:gas_seep",
		target = 1
	},
})

awards.register_achievement("dfcaverns_giant_web", {
	title = S("Collect Giant Webbing"),
	description = S(""),
	icon ="dfcaverns_awards_backgroundx32.png^big_webs_item.png^dfcaverns_awards_foregroundx32.png",
	trigger = {
		type = "dig",
		node = "big_webs:webbing",
		target = 1
	},
})

-- too common
--awards.register_achievement("dfcaverns_glow_worms", {
--	title = S("Collect Glow Worms"),
--	description = S(""),
--	icon =,
--	trigger = {
--		type = "dig",
--		node = "df_mapitems:glow_worm",
--		target = 1
--	},
--})

---------------------------------------------------------------

awards.register_achievement("dfcaverns_cave_pearls", {
	title = S("Collect Cave Pearls"),
	description = S(""),
	icon = "dfcaverns_awards_backgroundx32.png^dfcaverns_cave_pearls_achievement.png^dfcaverns_awards_foregroundx32.png",
	trigger = {
		type = "dig",
		node = "df_mapitems:cave_pearls",
		target = 1
	},
})

awards.register_achievement("dfcaverns_castle_coral", {
	title = S("Collect Castle Coral"),
	description = S(""),
	icon ="dfcaverns_awards_backgroundx32.png^dfcaverns_castle_coral_achievement.png^dfcaverns_awards_foregroundx32.png",
	trigger = {
		type = "dig",
		node = "df_mapitems:castle_coral",
		target = 1
	},
})

awards.register_achievement("dfcaverns_ruby_crystals", {
	title = S("Collect Giant Red Crystal"),
	description = S(""),
	--icon =,
	trigger = {
		type = "dig",
		node = "group:dfcaverns_big_crystal",
		target = 1
	},
})

awards.register_achievement("dfcaverns_cave_coral", {
	title = S("Collect Cave Coral"),
	description = S(""),
	icon ="dfcaverns_awards_backgroundx32.png^dfcaverns_cave_coral_achievement.png^dfcaverns_awards_foregroundx32.png",
	trigger = {
		type = "dig",
		node = "group:dfcaverns_cave_coral",
		target = 1
	},
})

awards.register_achievement("dfcaverns_flawless_mese", {
	title = S("Collect Flawless Mese Crystal Block"),
	description = S(""),
	icon ="dfcaverns_awards_backgroundx32.png^dfcaverns_glowmese_achievement.png^dfcaverns_awards_foregroundx32.png",
	trigger = {
		type = "dig",
		node = "df_mapitems:glow_mese",
		target = 1
	},
})

awards.register_achievement("dfcaverns_luminous_salt", {
	title = S("Collect Luminous Salt Crystal"),
	description = S(""),
	icon ="dfcaverns_awards_backgroundx32.png^dfcaverns_salt_achievement.png^dfcaverns_awards_foregroundx32.png",
	trigger = {
		type = "dig",
		node = "df_mapitems:salt_crystal",
		target = 1
	},
})

awards.register_achievement("dfcaverns_glow_amethyst", {
	title = S("Collect Glowing Amethyst"),
	description = S(""),
	icon ="dfcaverns_awards_backgroundx32.png^dfcaverns_amethyst_achievement.png^dfcaverns_awards_foregroundx32.png",
	trigger = {
		type = "dig",
		node = "df_underworld_items:glow_amethyst",
		target = 1
	},
})

awards.register_achievement("dfcaverns_glow_stone", {
	title = S('"Collect" Lightseam Stone'),
	description = S(""),
	icon ="dfcaverns_awards_backgroundx32.png^dfcaverns_glowstone_achievement.png^dfcaverns_awards_foregroundx32.png",
	trigger = {
		type = "dig",
		node = "df_underworld_items:glowstone",
		target = 1
	},
})

awards.register_achievement("dfcaverns_prospector", {
	title = S("Deep Prospector"),
	description = S(""),
	icon = "dfcaverns_awards_backgroundx32.png^"..crossed_pick_and_shovel.."^dfcaverns_awards_foregroundx32.png",
})


------------------------------------------------------------------

--"dfcaverns_prospector"
local prospector_achievements = {"dfcaverns_castle_coral", "dfcaverns_cave_coral", "dfcaverns_cave_pearls", "dfcaverns_flawless_mese", "dfcaverns_glow_amethyst", "dfcaverns_glow_stone", "dfcaverns_luminous_salt", "dfcaverns_ruby_crystals"}

local test_list = df_achievements.test_list

--    name is the player name
--    def is the award def.
awards.register_on_unlock(function(player_name, def)
	local player_awards = awards.player(player_name)
	if not player_awards or not player_awards.unlocked then
		return
	end
	local unlocked = player_awards.unlocked
	test_list(player_name, "dfcaverns_prospector", unlocked, prospector_achievements)
end)