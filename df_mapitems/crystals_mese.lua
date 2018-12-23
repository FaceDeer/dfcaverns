-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--glowing mese crystal blocks
minetest.register_node("df_mapitems:glow_mese", {
	description = S("Flawless Mese Block"),
	_doc_items_longdesc = df_mapitems.doc.glow_mese_desc,
	_doc_items_usagehelp = df_mapitems.doc.glow_mese_usage,
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
		{'df_mapitems:glow_mese'},
	}
})

if minetest.get_modpath("radiant_damage") and radiant_damage.override_radiant_damage and radiant_damage.config.enable_mese_damage then
	radiant_damage.override_radiant_damage("mese", {emitted_by={["df_mapitems:glow_mese"] = radiant_damage.config.mese_damage*12}})
end
