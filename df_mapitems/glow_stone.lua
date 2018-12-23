-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local glowstone_def = {
	light_source = minetest.LIGHT_MAX,
	description = S("Lightseam"),
	tiles = {"dfcaverns_glowstone.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
	--use_texture_alpha = true,
	drawtype = "glasslike",
	drop = "",
	sunlight_propagates = true,
}
if minetest.get_modpath("tnt") then
	glowstone_def.on_dig = function(pos, node, digger)
		tnt.boom(pos, {radius=3})
	end
end
minetest.register_node("df_mapitems:glowstone", glowstone_def)