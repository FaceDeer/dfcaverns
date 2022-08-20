if not minetest.get_modpath("awards") then
	minetest.log("warning", "[df_achievements] the df_achievements mod was installed but the [awards] mod was not."
		.. " df_achievements depends on awards, but it is listed as an optional dependency so that installing the"
		.. " dfcaverns modpack won't automatically enable it. If you want df_achievements to function please"
		.. " install awards as well, otherwise you should disable df_achievements.")
	return
end

df_achievements = {}

local S = minetest.get_translator(minetest.get_current_modname())
local nethercap_name = df_dependencies.nethercap_name

local modpath = minetest.get_modpath(minetest.get_current_modname())

-- used in a few places in this mod
df_achievements.test_list = function(player_name, target_achievement, unlocked, target_list)
	if unlocked[target_achievement] == target_achievement then
		return
	end
	local none_missing = true
	for _, achievement in pairs(target_list) do
		if unlocked[achievement] ~= achievement then
			none_missing = false
			break
		end
	end
	if none_missing then
		minetest.after(4, function() awards.unlock(player_name, target_achievement) end)
	end
end

dofile(modpath.."/travel.lua")
dofile(modpath.."/farming.lua")
dofile(modpath.."/dig.lua")
dofile(modpath.."/food.lua")
dofile(modpath.."/misc.lua")

-- not used outside this mod
df_achievements.test_list = nil