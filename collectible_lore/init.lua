local modpath = minetest.get_modpath(minetest.get_current_modname())
local S = minetest.get_translator(minetest.get_current_modname())

collectible_lore = {}

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