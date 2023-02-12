local modpath = minetest.get_modpath(minetest.get_current_modname())
local S = minetest.get_translator(minetest.get_current_modname())
local modmeta =  minetest.get_mod_storage()

collectible_lore = {}
collectible_lore.lorebooks = {}

collectible_lore.get_player_collected = function(player_name)
	local collected_string = modmeta:get("player_" .. player_name)
	if collected_string == nil then
		return {}
	else
		return minetest.deserialize(collected_string)
	end
end

collectible_lore.get_player_uncollected_list = function(player_name)
	local collected = collectible_lore.get_player_collected(player_name)
	--minetest.debug(dump(collected))
	local uncollected = {}
	for index, def in pairs(collectible_lore.lorebooks) do
		if not collected[def.id] then
			table.insert(uncollected, index)
		end
	end
	return uncollected
end

local set_collected = function(player_name, id, state)
	local collected = collectible_lore.get_player_collected(player_name)
	collected[id] = state
	modmeta:set_string("player_" .. player_name, minetest.serialize(collected))
end

collectible_lore.collect = function(player_name, id)
	set_collected(player_name, id, true)
end

collectible_lore.uncollect = function(player_name, id)
	set_collected(player_name, id, nil)
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
        params = "[collect|uncollect|clear|show] <player_name> <id>",  -- Short parameter description
        description = S("Administrative control of collectibles"),
        privs = {server=true},
        func = function(name, param)
			local first, second, third = param:match("^([^%s]+)%s+(%S+)%s*(.*)")
			if third == "" then third = nil end
			if first == "uncollect" and second and third then
				collectible_lore.uncollect(second, third)
				return
			elseif first == "collect" and second and third then
				collectible_lore.collect(second, third)
				return
			elseif first == "clear" and second then
				modmeta:set_string("player_" .. second, minetest.serialize({}))
				return
			elseif first == "show" and second then
				minetest.chat_send_player(name, dump(collectible_lore.get_player_collected(second)))
				return
			end
			
			minetest.chat_send_player(name, S("error parsing command"))
		end,
    })


dofile(modpath.."/items.lua")
