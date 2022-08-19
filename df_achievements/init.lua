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