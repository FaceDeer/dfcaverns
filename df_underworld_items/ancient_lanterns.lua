local S = minetest.get_translator(minetest.get_current_modname())

local lantern_nodebox = {
	{-0.5, -0.5, -0.5, -0.3125, 0.5, -0.3125},
	{-0.5, -0.5, 0.3125, -0.3125, 0.5, 0.5},
	{0.3125, -0.5, 0.3125, 0.5, 0.5, 0.5},
	{0.3125, -0.5, -0.5, 0.5, 0.5, -0.3125},
	{-0.3125, 0.3125, -0.5, 0.3125, 0.5, -0.3125},
	{-0.3125, 0.3125, 0.3125, 0.3125, 0.5, 0.5},
	{0.3125, 0.3125, -0.3125, 0.5, 0.5, 0.3125},
	{-0.5, 0.3125, -0.3125, -0.3125, 0.5, 0.3125},
	{-0.5, -0.5, -0.3125, -0.3125, -0.3125, 0.3125},
	{0.3125, -0.5, -0.3125, 0.5, -0.3125, 0.3125},
	{-0.3125, -0.5, 0.3125, 0.3125, -0.3125, 0.5},
	{-0.3125, -0.5, -0.5, 0.3125, -0.3125, -0.3125},
	{-0.375, -0.375, -0.375, 0.375, 0.375, 0.375},
}

local mese_crystal_node = df_underworld_items.nodes.mese_crystal
local brick_texture = "dfcaverns_slade_brick.png"--df_underworld_items.textures.stone_brick
local lantern_texture = df_underworld_items.textures.meselamp
local ancient_lantern_sound = df_underworld_items.sounds.slade

local invulnerable = df_underworld_items.config.invulnerable_slade and not minetest.settings:get_bool("creative_mode")

local can_dig
if invulnerable then
	can_dig = function(pos, player)
		return minetest.check_player_privs(player, "server")
	end
end

local slade_groups = {stone=1, level=3, slade=1, pit_plasma_resistant=1, mese_radiation_shield=1, cracky = 3}
if invulnerable then
	slade_groups.immortal = 1
end

local punch_fix = function(pos, node, puncher, pointed_thing)
	local wielded = puncher:get_wielded_item()
	if wielded:get_name() == mese_crystal_node then
		minetest.set_node(pos, {name="df_underworld_items:stonebrick_light"})
		minetest.get_node_timer(pos):stop()
		if not (creative and creative.is_enabled_for and creative.is_enabled_for(puncher:get_player_name())) then
			wielded:take_item()
			puncher:set_wielded_item(wielded)
		end
		return
	end
	minetest.node_punch(pos, node, puncher, pointed_thing)
end

minetest.register_node("df_underworld_items:stonebrick_light", {
	description = S("Ancient Lantern"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {brick_texture .. "^(" .. lantern_texture .. "^[mask:dfcaverns_lantern_mask.png)"},
	is_ground_content = false,
	groups = slade_groups,
	sounds = ancient_lantern_sound,
	drawtype= "nodebox",
	light_source = minetest.LIGHT_MAX,
	node_box = {
		type = "fixed",
		fixed = lantern_nodebox,
	},
	can_dig = can_dig,
})

minetest.register_node("df_underworld_items:stonebrick_light_worn", {
	description = S("Ancient Lantern"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {brick_texture .. "^(" .. lantern_texture .. "^[multiply:#FF8888^[mask:dfcaverns_lantern_mask.png)"},
	is_ground_content = false,
	groups = slade_groups,
	sounds = ancient_lantern_sound,
	drawtype= "nodebox",
	light_source = 6,
	node_box = {
		type = "fixed",
		fixed = lantern_nodebox,
	},
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(100, 200))
	end,
	on_timer = function(pos, elapsed)
		minetest.swap_node(pos, {name="df_underworld_items:stonebrick_light_burnt_out"})
		if math.random() < 0.1 then
			minetest.get_node_timer(pos):start(math.random(30, 60))
		else
			minetest.get_node_timer(pos):start(0.25)
		end
	end,
	on_punch = punch_fix,
	can_dig = can_dig,
})

minetest.register_node("df_underworld_items:stonebrick_light_burnt_out", {
	description = S("Ancient Lantern"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {brick_texture .. "^(" .. lantern_texture .. "^[multiply:#884444^[mask:dfcaverns_lantern_mask.png)"},
	is_ground_content = false,
	groups = slade_groups,
	sounds = ancient_lantern_sound,
	drawtype= "nodebox",
	light_source = 0,
	node_box = {
		type = "fixed",
		fixed = lantern_nodebox,
	},
	drops = "df_underworld_items:stonebrick_light_worn",
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(100, 200))
	end,
	on_timer = function(pos, elapsed)
		minetest.swap_node(pos, {name="df_underworld_items:stonebrick_light_worn"})
		if math.random() < 0.1 then
			minetest.get_node_timer(pos):start(math.random(300, 600))
		else
			minetest.get_node_timer(pos):start(0.25)
		end
	end,
	on_punch = punch_fix,
	can_dig = can_dig,
})

--minetest.register_craft({
--	output = "df_underworld_items:stonebrick_light",
--	type = "shapeless",
--	recipe = {
--		"group:df_underworld_items_ancient_lantern",
--		mese_crystal_node,
--	}
--})