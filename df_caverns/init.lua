df_caverns = {}

df_caverns.stats = {}

--grab a shorthand for the filepath of the mod
local modpath = minetest.get_modpath(minetest.get_current_modname())

--load companion lua files
dofile(modpath.."/config.lua")

dofile(modpath.."/shared.lua")
dofile(modpath.."/surface_tunnels.lua")
dofile(modpath.."/level1.lua")
dofile(modpath.."/level2.lua")
dofile(modpath.."/level3.lua")
dofile(modpath.."/sunless_sea.lua")
dofile(modpath.."/oil_sea.lua")
dofile(modpath.."/lava_sea.lua")
dofile(modpath.."/underworld.lua")

minetest.register_on_shutdown(function()
	local text
	for k, v in pairs(df_caverns.stats) do
		if text == nil then text = "" else text = text .. "\n" end
		text = text .. k .. ": " .. tostring(v)
	end
	minetest.log("warning", "[df_caverns] generation statistics since last server startup:\n" .. text)
end)
