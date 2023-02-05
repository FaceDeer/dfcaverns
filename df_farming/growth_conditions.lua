df_farming.growth_permitted = {}

local growable = {
	[df_dependencies.node_name_dirt_wet] = 1,
	[df_dependencies.node_name_dirt_furrowed] = 0.2,
	[df_dependencies.node_name_dirt] = 0.2,
}
local sand = {
	[df_dependencies.node_name_desert_sand_soil_wet] = 1,
	[df_dependencies.node_name_desert_sand] = 0.2,
	[df_dependencies.node_name_sand] = 0.2,
	[df_dependencies.node_name_silver_sand] = 0.2,
	[df_dependencies.node_name_desert_sand_soil_dry] = 0.2,
}

local check_farm_plant_soil = function(pos)
	return growable[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name]
end
local check_sand_plant_soil = function(pos)
	return sand[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name]
end

df_farming.growth_permitted["df_farming:cave_wheat_seed"] = check_farm_plant_soil
df_farming.growth_permitted["df_farming:dimple_cup_seed"] = check_farm_plant_soil
df_farming.growth_permitted["df_farming:pig_tail_seed"] = check_farm_plant_soil
df_farming.growth_permitted["df_farming:quarry_bush_seed"] = check_sand_plant_soil
df_farming.growth_permitted["df_farming:sweet_pod_seed"] = check_farm_plant_soil
df_farming.growth_permitted["df_farming:plump_helmet_spawn"] = check_farm_plant_soil

local trunc_to_full = {
	["df_farming:cav"] = "df_farming:cave_wheat_seed",
	["df_farming:dim"] = "df_farming:dimple_cup_seed",
	["df_farming:pig"] = "df_farming:pig_tail_seed",
	["df_farming:qua"] = "df_farming:quarry_bush_seed",
	["df_farming:swe"] = "df_farming:sweet_pod_seed",
	["df_farming:plu"] = "df_farming:plump_helmet_spawn"
}
df_farming.growth_factor = function(plantname, pos)
	local trunc_name = trunc_to_full[string.sub(plantname, 1, 14)]
	if not trunc_name then
		minetest.log("error", "[df_farming] failed to find growth condition function for " .. plantname)
		return
	end
	return df_farming.growth_permitted[trunc_name](pos)
end