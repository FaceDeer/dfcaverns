df_dependencies = {}
local modpath = minetest.get_modpath(minetest.get_current_modname())
local debug_dump = false

if minetest.get_modpath("default") then
	dofile(modpath.."/default.lua")
end

if debug_dump then
	local file = io.open(minetest.get_worldpath().."/df_dependencies.json", "w")
	if file then
		local items = {}
		for item, _ in pairs(df_dependencies) do
			table.insert(items, item)
		end
		table.sort(items)
		file:write(minetest.serialize(items))
		file:close()
	end
end

-- This mod is meant to only exist at initialization time. Other mods should make copies of anything it points to for their own use.
minetest.after(1, function() df_dependencies = nil end)
