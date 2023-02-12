local modpath = minetest.get_modpath(minetest.get_current_modname())
local S = minetest.get_translator(minetest.get_current_modname())
local modmeta =  minetest.get_mod_storage()

collectible_lore = {}
collectible_lore.lorebooks = {}

collectible_lore.get_player_unlocks = function(player_name)
	local unlocks_string = modmeta:get("player_" .. player_name)
	if unlocks_string == nil then
		return {}
	else
		return minetest.deserialize(unlocks_string)
	end
end

local set_lock = function(player_name, id, state)
	local unlocks = collectible_lore.get_player_unlocks(player_name)
	unlocks[id] = state
	modmeta:set_string("player_" .. player_name, minetest.serialize(unlocks))
end

collectible_lore.unlock = function(player_name, id)
	set_lock(player_name, id, true)
end

collectible_lore.lock = function(player_name, id)
	set_lock(player_name, id, nil)
end

local collectible_lore_sort = function(first, second)
	if (first.sort or 0) < (second.sort or 0) then
		return true
	end
	if first.sort == second.sort then
		return first.id < second.id
	end
	return false
end

local ids = {}

collectible_lore.register_lorebook = function(def)
	if def.id == nil then
		minetest.log("error", "[collectible_lore] nil id for def " .. dump(def))		
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


minetest.register_chatcommand("collectible", {
        params = "[lock|unlock|clear|show] <player_name> <id>",  -- Short parameter description
        description = "Remove privilege from player",
        privs = {server=true},
        func = function(name, param)
			local first, second, third = param:match("^([^%s]+)%s+(%S+)%s*(.*)")
			if third == "" then third = nil end
			if first == "lock" and second and third then
				collectible_lore.lock(second, third)
				return
			elseif first == "unlock" and second and third then
				collectible_lore.unlock(second, third)
				return
			elseif first == "clear" and second then
				modmeta:set_string("player_" .. second, minetest.serialize({}))
				return
			elseif first == "show" and second then
				minetest.chat_send_player(name, dump(collectible_lore.get_player_unlocks(second)))
				return
			end
			
			minetest.chat_send_player(name, "error parsing command")
		end,
    })


dofile(modpath.."/items.lua")
