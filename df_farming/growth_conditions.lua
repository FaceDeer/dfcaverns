df_farming.growth_permitted = {}
-- The defaults here are very boring on account of how the farming code already
-- checks soil conditions. Other mods can insert biome checks and whatnot here.

df_farming.growth_permitted["df_farming:cave_wheat_seed"] = function(pos)
	return true
end

df_farming.growth_permitted["df_farming:dimple_cup_seed"] = function(pos)
	return true
end

df_farming.growth_permitted["df_farming:pig_tail_seed"] = function(pos)
	return true
end

df_farming.growth_permitted["df_farming:quarry_bush_seed"] = function(pos)
	return true
end

df_farming.growth_permitted["df_farming:sweet_pod_seed"] = function(pos)
	return true
end

df_farming.growth_permitted["df_farming:plump_helmet_spawn"] = function(pos)
	return true
end