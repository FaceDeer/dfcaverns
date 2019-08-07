if not minetest.get_modpath("dungeon_loot") then
	return
end

if df_caverns.config.enable_underworld then
	dungeon_loot.register({
		{name = "df_underworld_items:glow_amethyst", chance = 0.3, count = {1, 12}, y = {-32768, df_caverns.config.lava_sea_level}},
	})
end

if df_caverns.config.enable_oil_sea and minetest.get_modpath("bucket") then
	dungeon_loot.register({
		{name = "oil:oil_bucket", chance = 0.5, count = {1, 3}, y = {-32768, df_caverns.config.ymax}},
	})
end

if df_caverns.config.enable_lava_sea then
	dungeon_loot.register({
		{name = "df_mapitems:mese_crystal", chance = 0.25, count = {1, 5}, y = {-32768, df_caverns.config.sunless_sea_min}},
		{name = "df_mapitems:glow_mese", chance = 0.1, count = {1, 3}, y = {-32768, df_caverns.config.sunless_sea_min}},
	})
end

dungeon_loot.register({
	{name = "df_farming:cave_wheat_seed", chance = 0.5, count = {1, 10}, y = {-32768, df_caverns.config.ymax}},
	{name = "df_farming:cave_bread", chance = 0.8, count = {1, 10}, y = {-32768, df_caverns.config.ymax}},
	{name = "df_farming:pig_tail_thread", chance = 0.7, count = {1, 10}, y = {-32768, df_caverns.config.ymax}},
	{name = "df_farming:plump_helmet_spawn", chance = 0.4, count = {1, 8}, y = {-32768, df_caverns.config.ymax}},
	{name = "df_farming:plump_helmet_4_picked", chance = 0.8, count = {1, 15}, y = {-32768, df_caverns.config.ymax}},
	{name = "df_trees:glowing_bottle_red", chance = 0.6, count = {1, 20}, y = {-32768, df_caverns.config.ymax}},
	{name = "df_trees:glowing_bottle_green", chance = 0.5, count = {1, 20}, y = {-32768, df_caverns.config.ymax}},
	{name = "df_trees:glowing_bottle_cyan", chance = 0.4, count = {1, 15}, y = {-32768, df_caverns.config.ymax}},
	{name = "df_trees:glowing_bottle_golden", chance = 0.3, count = {1, 5}, y = {-32768, df_caverns.config.ymax}},

	{name = "df_farming:pig_tail_seed", chance = 0.5, count = {1, 10}, y = {-32768, df_caverns.config.level1_min}},
	{name = "df_mapitems:med_crystal", chance = 0.2, count = {1, 2}, y = {-32768, df_caverns.config.level1_min}},

	{name = "df_farming:dimple_cup_seed", chance = 0.3, count = {1, 10}, y = {-32768, df_caverns.config.level2_min}},
	{name = "df_farming:quarry_bush_seed", chance = 0.3, count = {1, 5}, y = {-32768, df_caverns.config.level2_min}},
	{name = "df_farming:sweet_pod_seed", chance = 0.3, count = {1, 5}, y = {-32768, df_caverns.config.level2_min}},
	{name = "df_mapitems:big_crystal", chance = 0.1, count = {1, 1}, y = {-32768, df_caverns.config.level2_min}},
	{name = "df_trees:torchspine_ember", chance = 0.3, count = {1, 3}, y = {-32768, df_caverns.config.level2_min}},
	{name = "ice_sprites:ice_sprite_bottle", chance = 0.1, count = {1, 1}, y = {-32768, df_caverns.config.level2_min}},
})
