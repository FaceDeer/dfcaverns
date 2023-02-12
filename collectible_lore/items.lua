local S = minetest.get_translator(minetest.get_current_modname())
local modmeta =  minetest.get_mod_storage()

local get_cairn_looted_by_list = function(pos)
	local loot_list_string = modmeta:get("cairn_" .. minetest.pos_to_string(pos))
	if not loot_list_string then
		return {}
	end
	return minetest.deserialize(loot_list_string)
end

local set_cairn_looted_by_list = function(pos, list)
	modmeta:set_string("cairn_" .. minetest.pos_to_string(pos), minetest.serialize(list))
end

local cairn_loot = function(pos, player_name)
	local list = get_cairn_looted_by_list(pos)
	if list[player_name] then
		return false
	end
	list[player_name] = true
	local lore_id = collectible_lore.lorebooks[math.random(#(collectible_lore.lorebooks))].id
	collectible_lore.unlock(player_name, lore_id)
	minetest.debug("unlocked " .. lore_id)
	list[player_name] = true
	set_cairn_looted_by_list(pos, list)
	return true
end


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
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local player_name = clicker:get_player_name()
		if player_name then
			cairn_loot(pos, player_name)
		end
	end,
})

local player_state = {}


local get_formspec_for_player = function(player_name)
	local selected
	local state = player_state[player_name] or 1
	local unlocks = collectible_lore.get_player_unlocks(player_name)

	local form = {}
	table.insert(form, "formspec_version[6]size[10,8]")
	table.insert(form, "textlist[0,0;4,7;list;")
	local count = 1
	for index, value in pairs(collectible_lore.lorebooks) do
		local unlocked = unlocks[value.id]
		if unlocked and state == count then
			selected = value
		end
		count = count + 1
		if unlocked then
			table.insert(form, minetest.formspec_escape(value.title))
		else
			table.insert(form, S("<Locked>"))
		end
		table.insert(form, ",")
	end
	table.remove(form) -- removes trailing comma
	table.insert(form, ";" .. state .. "]")
	
	table.insert(form, "textarea[4.5,0;5.5,7;;text;")
	
	if selected then
		local str = selected.text
		table.insert(form, minetest.formspec_escape(str))
	else
		table.insert(form, " ")
	end
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
