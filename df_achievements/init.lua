if not minetest.get_modpath("awards") then
	minetest.log("warning", "[df_achievements] the df_achievements mod was installed but the [awards] mod was not."
		.. " df_achievements depends on awards, but it is listed as an optional dependency so that installing the"
		.. " dfcaverns modpack won't automatically enable it. If you want df_achievements to function please"
		.. " install awards as well, otherwise you should disable df_achievements.")
	return
end

df_achievements = {}

local old_awards_version = false
if awards.run_trigger_callbacks then
	old_awards_version = true
else
	-- used to track the progress of achievements that are based off of other achievements
	awards.register_trigger("dfcaverns_achievements", {
		type="counted_key",
		progress = "@1/@2", -- awards seems to use a conflicting syntax with internationalization, ick. Avoid words here.
		get_key = function(self, def)
			return def.trigger.achievement_name
		end,
	})
end


local achievement_parents = {}
df_achievements.get_child_achievement_count = function(parent_achievement)
	return #achievement_parents[parent_achievement]
end

local register_achievement_old = awards.register_achievement
awards.register_achievement = function(achievement_name, achievement_def, ...)
	if old_awards_version and achievement_def.trigger and achievement_def.trigger.type=="dfcaverns_achievements" then
		-- there's a significant difference between how triggers work
		-- in older versions of the awards mod. The new version of the trigger doesn't
		-- work with the old. For now, strip them out.
		achievement_def.trigger = nil
	end

	if achievement_def._dfcaverns_achievements then
		for _, parent_achievement in pairs(achievement_def._dfcaverns_achievements) do
			local parent_source_list = achievement_parents[parent_achievement] or {}
			achievement_parents[parent_achievement] = parent_source_list
			table.insert(parent_source_list, achievement_name)
		end
	end

	register_achievement_old(achievement_name, achievement_def, ...)
end

local modpath = minetest.get_modpath(minetest.get_current_modname())

awards.register_on_unlock(function(player_name, def)
	local def_dfcaverns_achievements = def._dfcaverns_achievements
	if not def_dfcaverns_achievements then return end
	local player_awards = awards.player(player_name)
	if not player_awards then return end	
	local unlocked = player_awards.unlocked
	if not unlocked then return end
	--local player = minetest.get_player_by_name(player_name)
	--if not player then return end
	
	-- the achievement that just got unlocked had one or more "parent" achievements associated with it.
	for _, achievement_parent in pairs(def_dfcaverns_achievements) do
		minetest.debug("updating achievement type " .. achievement_parent)
		--if unlocked[achievement_parent] ~= achievement_parent then -- this should theoretically never fail
			player_awards.dfcaverns_achievements = player_awards.dfcaverns_achievements or {}
			local source_list = achievement_parents[achievement_parent]
			local total = #source_list
			local count = 0
			for _, source_achievement in pairs(source_list) do
				if unlocked[source_achievement] == source_achievement then count = count + 1 end
			end
			player_awards.dfcaverns_achievements[achievement_parent] = count
			minetest.debug(dump(player_awards))
			awards.save()
			if count >= total then
				minetest.after(4, awards.unlock, player_name, achievement_parent)
			end			
		--end
	end
end)



dofile(modpath.."/travel.lua")
dofile(modpath.."/farming.lua")
dofile(modpath.."/dig.lua")
dofile(modpath.."/food.lua")
dofile(modpath.."/misc.lua")

-- not used outside this mod
df_achievements.test_list = nil