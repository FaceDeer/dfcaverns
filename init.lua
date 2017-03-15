dfcaverns = {}

subterrane.get_param2_data = true

--grab a shorthand for the filepath of the mod
local modpath = minetest.get_modpath(minetest.get_current_modname())

--load companion lua files
dofile(modpath.."/config.lua")

dofile(modpath.."/ground_cover.lua")
dofile(modpath.."/plants.lua")

-- Trees
dofile(modpath.."/blood_thorn.lua")
dofile(modpath.."/fungiwood.lua")
dofile(modpath.."/tunnel_tube.lua")
dofile(modpath.."/spore_tree.lua")
dofile(modpath.."/black_cap.lua")
dofile(modpath.."/nether_cap.lua")
dofile(modpath.."/goblin_cap.lua")
dofile(modpath.."/tower_cap.lua")


minetest.register_abm({
	label = "dfcaverns:kill_light_sensitive_fungus",
	nodenames = {"group:light_sensitive_fungus"},
	catch_up = true,
	interval = 30,
	chance = 5,
	action = function(pos, node)
		local node_def = minetest.registered_nodes[node.name]
		local dead_node = node_def._dfcaverns_dead_node or "dfcaverns:dead_fungus"
		-- 11 is the value adjacent to a torch		
		if minetest.get_node_light(pos) > node_def.groups.light_sensitive_fungus then
			minetest.set_node(pos, {name=dead_node, param2 = node.param2})
		end
	end
})