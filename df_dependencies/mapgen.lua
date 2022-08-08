local S = minetest.get_translator(minetest.get_current_modname())

local prefix = "dfcaverns_"
-- NOTE: These defaults are from df_caverns' config. Update them if those change.

local lowest_elevation = tonumber(minetest.settings:get(prefix.."sunless_sea_min")) or -2512
if minetest.settings:get_bool(prefix.."enable_oil_sea", true) then
	lowest_elevation = (tonumber(minetest.settings:get(prefix.."oil_sea_level")) or -2700)
end
if minetest.settings:get_bool(prefix.."enable_lava_sea", true) then
	lowest_elevation = (tonumber(minetest.settings:get(prefix.."lava_sea_level")) or -2900)
end
if minetest.settings:get_bool(prefix.."enable_underworld", true) then
	lowest_elevation = (tonumber(minetest.settings:get(prefix.."underworld_level")) or -3200)
end
if minetest.settings:get_bool(prefix.."enable_primordial", true) then
	lowest_elevation = (tonumber(minetest.settings:get(prefix.."primordial_min")) or -4032)
end
lowest_elevation = lowest_elevation - 193 -- add a little buffer space

df_dependencies.mods_required.mcl_init = true
df_dependencies.mods_required.mcl_worlds = true
df_dependencies.mods_required.mcl_strongholds = true
df_dependencies.mods_required.mcl_compatibility = true
df_dependencies.mods_required.mcl_mapgen = true

local old_overworld_min

if minetest.get_modpath("mcl_init") then -- Mineclone 2
	old_overworld_min = mcl_vars.mg_overworld_min -- remember this for weather control
	
	mcl_vars.mg_overworld_min = lowest_elevation
	mcl_vars.mg_bedrock_overworld_min = mcl_vars.mg_overworld_min
	mcl_vars.mg_lava_overworld_max = mcl_vars.mg_overworld_min + 10
	mcl_vars.mg_end_max = mcl_vars.mg_overworld_min - 2000
	
	-- Important note. This doesn't change the values for the various ores and mobs and biomes and whatnot that have already been registered.
	-- to keep things consistent, add dependencies to

	dofile(minetest.get_modpath(minetest.get_current_modname()).."/ores.lua")
	
	-- never mind - add dependency on mcl_strongholds and these will get generated before overworld_min gets changed.
	--if minetest.get_modpath("mcl_structures") and minetest.get_modpath("mcl_strongholds") then
	--	local elevation_delta = old_overworld_min - lowest_elevation
	--	local strongholds = mcl_structures.get_structure_data("stronghold")
	--	mcl_structures.register_structure_data("stronghold", strongholds)	
	--end
end
if minetest.get_modpath("mcl_compatibility") then -- Mineclone 5
	old_overworld_min = mcl_vars.mg_overworld_min -- remember this for weather control

	mcl_vars.mg_overworld_min = lowest_elevation
	mcl_vars.mg_bedrock_overworld_min = mcl_vars.mg_overworld_min
	mcl_vars.mg_bedrock_overworld_max = mcl_vars.mg_overworld_min+4
	mcl_vars.mg_lava_overworld_max = mcl_vars.mg_overworld_min+6
	mcl_vars.mg_lava = false
	mcl_vars.mg_end_max = mcl_vars.mg_overworld_min - 2000
	mcl_vars.mg_realm_barrier_overworld_end_max = mcl_vars.mg_end_max
	mcl_vars.mg_realm_barrier_overworld_end_min = mcl_vars.mg_end_max-11
end
if minetest.get_modpath("mcl_mapgen") then -- Mineclone 5
	old_overworld_min = mcl_mapgen.overworld.min -- remember this for weather control

	mcl_mapgen.overworld.min = lowest_elevation
	mcl_mapgen.overworld.bedrock_min = mcl_mapgen.overworld.min
	mcl_mapgen.overworld.bedrock_max = mcl_mapgen.overworld.bedrock_min + (mcl_mapgen.bedrock_is_rough and 4 or 0)
	mcl_mapgen.overworld.lava_max = mcl_mapgen.overworld.min+6
	mcl_mapgen.overworld.railcorridors_height_min = -50
	mcl_mapgen.overworld.railcorridors_height_max = -2
	
	mcl_mapgen.end_.max = mcl_mapgen.overworld.min - 2000
	mcl_mapgen.realm_barrier_overworld_end_max = mcl_mapgen.end_.max
	mcl_mapgen.realm_barrier_overworld_end_min = mcl_mapgen.end_.max - 11

	if mcl_mapgen.on_settings_changed then
		mcl_mapgen.on_settings_changed()
	end
end
if minetest.get_modpath("mcl_worlds") then
	local old_has_weather = mcl_worlds.has_weather
	mcl_worlds.has_weather = function(pos)
		-- No weather in the deep caverns
		if pos.y >= lowest_elevation and pos.y <= old_overworld_min then
			return false
		end
		return old_has_weather(pos)
	end
end
