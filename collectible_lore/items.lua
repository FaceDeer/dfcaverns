local S = minetest.get_translator(minetest.get_current_modname())

minetest.register_node("collectible_lore:cairn", {
	description = S("Cairn"),
	drawtype = "nodebox",
	tiles = {df_dependencies.texture_cobble},
	drop = df_dependencies.node_name_cobble,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.4375, 0, -0.4375, 0.4375, 0.5, 0.4375},
			{-0.25, 0.5, -0.25, 0.25, 1, 0.25}
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 1, 0.5}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 1, 0.5}
		}
	},
})

local player_state = {}

local get_formspec_for_player = function(player_name)
	local selected
	local state = player_state[player_name] or 1

	local form = {}
	table.insert(form, "formspec_version[6]size[10,8]")
	table.insert(form, "textlist[0,0;4,7;list;")
	local count = 1
	for index, value in pairs(collectible_lore.lorebooks) do
		if state == count then
			selected = value
		end
		count = count + 1
		table.insert(form, minetest.formspec_escape(value.title))
		table.insert(form, ",")
	end
	table.remove(form) -- removes trailing comma
	table.insert(form, ";" .. state .. "]")
	
	table.insert(form, "textarea[4.5,0;5.5,7;;text;")
	
	local str = selected.text
	table.insert(form, minetest.formspec_escape(str))
	table.insert(form, "]")
	
	return table.concat(form)
end

minetest.register_craftitem("collectible_lore:ledger", {
	description = S("Collectible Ledger"),
	inventory_image = "df_lorebooks_ledger.png",
	stack_max = 99,
	on_use = function(itemstack, user, pointed_thing)
		local player_name = user:get_player_name()
		minetest.show_formspec(player_name, "collectible_lore:formspec", get_formspec_for_player(player_name))
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "collectible_lore:formspec" then return end
	
	if fields.list then
		local exploded = minetest.explode_textlist_event(fields.list)
		if exploded.type == "CHG" then
			local player_name = player:get_player_name()
			player_state[player_name] = exploded.index
			minetest.show_formspec(player_name, "collectible_lore:formspec", get_formspec_for_player(player_name))
		end
	end
end)
