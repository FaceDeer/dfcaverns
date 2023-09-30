local modpath = minetest.get_modpath(minetest.get_current_modname())

local torch_node = {name=df_dependencies.node_name_torch, param2=1}
collectible_lore.get_light_node = function()
	local selection = math.random()
	if selection < 0.25 then
		return torch_node
	elseif selection < 0.5 then
		return {name="df_trees:glowing_bottle_red", param2=0}
	elseif selection < 0.8 then
		return {name="df_trees:glowing_bottle_green", param2=0}
	elseif selection < 0.9 then
		return {name="df_trees:glowing_bottle_cyan", param2=0}
	else
		return {name="df_trees:glowing_bottle_golden", param2=0}
	end
end

dofile(modpath.."/introductions.lua")
dofile(modpath.."/ecology_flora.lua")
dofile(modpath.."/ecology_trees.lua")
dofile(modpath.."/geology_the_great_caverns.lua")
dofile(modpath.."/underworld_and_primordial.lua")
dofile(modpath.."/art.lua")
