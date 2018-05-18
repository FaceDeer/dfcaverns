-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--glowing mese crystal blocks
minetest.register_node("dfcaverns:glow_mese", {
	description = S("Flawless Mese Block"),
	tiles = {"dfcaverns_glow_mese.png"},
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
	light_source = 13,
	paramtype = "light",
	use_texture_alpha = true,
	drawtype = "glasslike",
	sunlight_propagates = true,
})

minetest.register_craft({
	output = 'default:mese_crystal 12',
	recipe = {
		{'dfcaverns:glow_mese'},
	}
})