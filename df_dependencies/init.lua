df_dependencies = {}
local modpath = minetest.get_modpath(minetest.get_current_modname())

local mods_required = {}

df_dependencies.select_required = function(def)
	local count = 0
	local total = 0
	local ret
	for mod, item in pairs(def) do
		total = total + 1
		mods_required[mod] = true
		if minetest.get_modpath(mod) then
			count = count + 1
			ret = item
		end
	end
	assert(count ~= 0, "Unable to find item for dependency set " .. dump(def))
	assert(count == 1, "Found more than one item for dependency set " .. dump(def))
	--assert(total == 2, "number of options other than two for " .. dump(def))
	return ret
end

df_dependencies.select_optional = function(def)
	for mod, item in pairs(def) do
		if minetest.get_modpath(mod) then
			return item
		end
	end
end

dofile(modpath.."/nodes.lua")
dofile(modpath.."/sounds.lua")
dofile(modpath.."/helper_functions.lua")
dofile(modpath.."/misc.lua")

minetest.debug(dump(mods_required))

-- This mod is meant to only exist at initialization time. Other mods should make copies of anything it points to for their own use.
minetest.after(1, function() df_dependencies = nil end)
