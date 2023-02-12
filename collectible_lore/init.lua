local modpath = minetest.get_modpath(minetest.get_current_modname())
local S = minetest.get_translator(minetest.get_current_modname())
local modmeta =  minetest.get_mod_storage()

collectible_lore = {}

collectible_lore.get_player_unlocks = function(player_name)
	local unlocks_string = modmeta:get("player_" .. player_name)
	if unlocks_string == nil then
		return {}
	else
		return minetest.deserialize(unlocks_string)
	end
end

local set_player_unlocks = function(player_name, unlocks_table)
	modmeta:set_string("player_" .. player_name, minetest.serialize(unlocks_table))
end

collectible_lore.unlock = function(player_name, id)
	local unlocks = collectible_lore.get_player_unlocks(player_name)
	unlocks[id] = true
	set_player_unlocks(player_name, unlocks)
end

dofile(modpath.."/items.lua")

local collectible_lore_sort = function(first, second)
	if (first.sort or 0) < (second.sort or 0) then
		return true
	end
	if first.sort == second.sort then
		return first.id < second.id
	end
	return false
end


collectible_lore.lorebooks = {}

local ids = {}

collectible_lore.register_lorebook = function(def)
	if def.id == nil then
		minetest.log("error", "[collectible_lore] Nil id for def " .. dump(def))		
		return false
	end
	if ids[def.id] then
		minetest.log("error", "[collectible_lore] Duplicate unique lore id for defs " .. dump(def) .. " and " .. dump(ids[def.id]))
		return false
	end
	ids[def.id] = def
	table.insert(collectible_lore.lorebooks, def)
	table.sort(collectible_lore.lorebooks, collectible_lore_sort)
end

