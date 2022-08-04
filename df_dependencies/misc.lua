local S = minetest.get_translator(minetest.get_current_modname())

local select_required = df_dependencies.select_required
local select_optional = df_dependencies.select_optional

-- If the farming mod is installed, add the "straw" group to farming straw.
-- This way goblin caps just need to check for group:straw to get cave straw as well
local straw_def = minetest.registered_items["farming:straw"]
if straw_def then
	local new_groups = {}
	for group, val in pairs(straw_def.groups) do
		new_groups[group] = val
	end
	new_groups.straw = 1
	minetest.override_item("farming:straw", {
		groups = new_groups
	})
end

-- used to determine colour of spindlestem caps
if minetest.get_modpath("default") then
	df_dependencies.data_iron_containing_nodes = {"default:stone_with_iron", "default:steelblock"}
	df_dependencies.data_copper_containing_nodes = {"default:stone_with_copper", "default:copperblock"}
	df_dependencies.data_mese_containing_nodes = {"default:stone_with_mese", "default:mese"}
elseif minetest.get_modpath("mcl_core") then
	df_dependencies.data_iron_containing_nodes = {"mcl_core:stone_with_iron", "mcl_core:ironblock"}
	df_dependencies.data_copper_containing_nodes = {"mcl_core:stone_with_copper", "mcl_copper:block", "mcl_copper:block_raw", "mcl_copper:block_exposed", "mcl_copper:block_oxidized", "mcl_copper:block_weathered"}
	df_dependencies.data_mese_containing_nodes = {} -- TODO
end

df_dependencies.texture_cobble = select_required({default="default_cobble.png", mcl_core="default_cobble.png"})
df_dependencies.texture_coral_skeleton = select_required({default="default_coral_skeleton.png", mcl_ocean="mcl_ocean_dead_horn_coral_block.png"})
df_dependencies.texture_dirt = select_required({default="default_dirt.png", mcl_core="default_dirt.png"})
df_dependencies.texture_gold_block = select_required({default="default_gold_block.png", mcl_core="default_gold_block.png"})
df_dependencies.texture_ice = select_required({default="default_ice.png", mcl_core="default_ice.png"})
df_dependencies.texture_sand = select_required({default="default_sand.png", mcl_core="default_sand.png"})
df_dependencies.texture_stone = select_required({default="default_stone.png", mcl_core="default_stone.png"})
df_dependencies.texture_wood = select_required({default="default_wood.png", mcl_core="default_wood.png"})
df_dependencies.texture_mineral_coal = select_required({default="default_mineral_coal.png",	mcl_core="mcl_core_coal_ore.png"}) -- MCL's coal texture isn't transparent, but is only used with gas seeps and should work fine that way
df_dependencies.texture_glass_bottle = select_required({vessels="vessels_glass_bottle.png",	mcl_potions="mcl_potions_potion_bottle.png"})

df_dependencies.mods_required.mcl_init = true
df_dependencies.mods_required.mcl_worlds = true
df_dependencies.mods_required.mcl_strongholds = true
if minetest.get_modpath("mcl_init") then

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

	local old_overworld_min = mcl_vars.mg_overworld_min -- rememeber this for weather control
	
	mcl_vars.mg_overworld_min = lowest_elevation
	mcl_vars.mg_bedrock_overworld_min = mcl_vars.mg_overworld_min
	mcl_vars.mg_lava_overworld_max = mcl_vars.mg_overworld_min + 10
	mcl_vars.mg_end_max = mcl_vars.mg_overworld_min - 2000
	
	-- Important note. This doesn't change the values for the various ores and mobs and biomes and whatnot that have already been registered.
	-- to keep things consistent, add dependencies to
	
	if minetest.get_modpath("mcl_worlds") then
		mcl_worlds.has_weather = function(pos)
			-- Weather in the Overworld. No weather in the deep caverns
			return pos.y <= mcl_vars.mg_overworld_max and pos.y >= old_overworld_min
		end
	end

--	minetest.debug(dump(mcl_vars))
	
	dofile(minetest.get_modpath(minetest.get_current_modname()).."/ores.lua")
	
	-- never mind - add dependency on mcl_strongholds and these will get generated before overworld_min gets changed.
	--if minetest.get_modpath("mcl_structures") and minetest.get_modpath("mcl_strongholds") then
	--	local elevation_delta = old_overworld_min - lowest_elevation
	--	local strongholds = mcl_structures.get_structure_data("stronghold")
	--	mcl_structures.register_structure_data("stronghold", strongholds)	
	--end
end
