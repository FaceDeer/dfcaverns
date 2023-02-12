local S = minetest.get_translator(minetest.get_current_modname())
local modmeta =  minetest.get_mod_storage()

local cairn_spacing = tonumber(minetest.settings:get("collectible_lore_cairn_spacing")) or 500
local torch_node = {name=df_dependencies.node_name_torch, param2=1}
collectible_lore.get_light_node = function()
	return torch_node
end

local cairn_area = AreaStore()
local existing_area = modmeta:get("areastore_cairn")
if existing_area then
	cairn_area:from_string(existing_area)
end

local get_itemslot_bg = df_dependencies.get_itemslot_bg

function get_cairn_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,9]"
		.."list[nodemeta:" .. spos .. ";main;0,0.3;8,4;]"
		.."list[current_player;main;0,4.85;8,1;]"
		.."list[current_player;main;0,6.08;8,3;8]"
		.."listring[nodemeta:" .. spos .. ";main]"
		.."listring[current_player;main]"
		..get_itemslot_bg(0,0.3,8,4)
		..get_itemslot_bg(0,4.85,8,1)
		..get_itemslot_bg(0,6.08,8,3)
	if minetest.get_modpath("default") then
		formspec = formspec .. default.get_hotbar_bg(0,4.85)
	end
	return formspec
end

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

local cairn_last_collected_index

local cairn_loot = function(pos, player)
	local player_name = player:get_player_name()
	if not player_name then return end

	local list = get_cairn_looted_by_list(pos)
	if list[player_name] then
		minetest.chat_send_player(player_name, S("You've already collected the lore hidden in this cairn."))
		minetest.show_formspec(player_name, "collectible_lore:cairn_inventory", get_cairn_formspec(pos))
		return false
	end
	list[player_name] = true
	
	local uncollected = collectible_lore.get_player_uncollected_list(player_name)
	--minetest.debug(dump(uncollected))
	if next(uncollected) then
		local random_lorebook = uncollected[math.random(#uncollected)]
		cairn_last_collected_index = random_lorebook
		collectible_lore.collect(player_name, collectible_lore.lorebooks[random_lorebook].id)
		minetest.show_formspec(player_name, "collectible_lore:collected",
			"formspec_version[6]size[8,2]label[0.5,0.5;"
			.. S("You've found a collectible item of lore titled:\n@1", collectible_lore.lorebooks[random_lorebook].title)
			.. "]button_exit[1,1.5;2,0.4;exit;"..S("Exit")
			.. "]button[5,1.5;2,0.4;view;"..S("View") .. "]")
		list[player_name] = true
		set_cairn_looted_by_list(pos, list)
	else
		minetest.chat_send_player(player_name, S("You've found all of the collectible items contained in cairns like this one"))
		minetest.show_formspec(player_name, "collectible_lore:cairn_inventory", get_cairn_formspec(pos))
		return false
	end	
	
	local leftover = player:get_inventory():add_item("main", "collectible_lore:satchel")
	if not leftover:is_empty() then
		minetest.item_drop(leftover, player, vector.add(pos, vector.new(0,1,0)))
	end	
	return true
end

minetest.register_node("collectible_lore:cairn", {
	description = S("Cairn"),
	_doc_items_longdesc = S("A cairn of rocks constructed by a previous explorer to protect documents and supplies."),
	_doc_items_usagehelp = S("The first time you discover a cairn like this, it may reveal to you some new record or piece of lore. Afterward it can be used as a public storage location."),
	drawtype = "nodebox",
	tiles = {df_dependencies.texture_cobble, df_dependencies.texture_cobble, df_dependencies.texture_cobble .. "^(collectible_lore_cairn_marker.png^[opacity:100)"},
	is_ground_content = true,
	groups = {cracky = 3, container=2},
	_mcl_hardness = 1.5,
	_mcl_blast_resistance = 6,
	drop = df_dependencies.node_name_cobble,
	sounds = df_dependencies.sound_stone(),
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			{-0.4375, 0, -0.4375, 0.4375, 0.5, 0.4375},
			--{-0.25, 0.5, -0.25, 0.25, 1, 0.25}
		}
	},
--	collision_box = {
--		type = "fixed",
--		fixed = {
--			{-0.5, -0.5, -0.5, 0.5, 1, 0.5}
--		}
--	},
--	selection_box = {
--		type = "fixed",
--		fixed = {
--			{-0.5, -0.5, -0.5, 0.5, 1, 0.5}
--		}
--	},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		cairn_loot(pos, clicker)
	end,
	can_dig = function(pos, player)
		local inv = minetest.get_meta(pos):get_inventory()
		return minetest.check_player_privs(player, {server = true}) and inv:is_empty("main")
	end,
	on_destruct = function(pos)
		modmeta:set_string("cairn_" .. minetest.pos_to_string(pos), "")
		local this_cairn = cairn_area:get_areas_for_pos(pos)
		for index, data in pairs(this_cairn) do
			--minetest.debug("removing " .. dump(index))
			cairn_area:remove_area(index)
			modmeta:set_string("areastore_cairn", cairn_area:to_string())
		end
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)

		local nearby = collectible_lore.are_cairns_close_to_pos(pos)
		if nearby then
			minetest.log("error", "Cairn placed too close to other cairns. Placed at: " .. minetest.pos_to_string(pos))
			for _,data in pairs(nearby) do
				minetest.log("error", "nearby: " .. minetest.pos_to_string(data.min))
			end
		end
		cairn_area:insert_area(pos, pos, "")
		modmeta:set_string("areastore_cairn", cairn_area:to_string())
		local above_pos = {x=pos.x, y=pos.y+1, z=pos.z}
		local above_node = minetest.get_node(above_pos)
		if minetest.registered_nodes[above_node.name].buildable_to then
			minetest.set_node(above_pos, collectible_lore.get_light_node())
		end
	end,
	on_blast = function(pos, intensity)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		for i = 1, inv:get_size("main") do
			drop_item_stack(pos, inv:get_stack("main", i))
		end
		meta:from_table()
		minetest.remove_node(pos)
	end,

})

collectible_lore.get_nearby_cairns = function(pos, spacing)
	local nearby = cairn_area:get_areas_in_area(vector.subtract(pos, spacing/2), vector.add(pos, spacing/2))
	if next(nearby) then
		return nearby
	end
	return nil
end

collectible_lore.are_cairns_close_to_pos = function(pos)
	local nearby = collectible_lore.get_nearby_cairns(pos, cairn_spacing)
	if nearby then return nearby end
	return false
end

collectible_lore.place_cairn = function(pos)
	if collectible_lore.are_cairns_close_to_pos(pos) then return end
	minetest.set_node(pos, {name="collectible_lore:cairn"})
	--minetest.debug("placed " .. minetest.pos_to_string(pos))
end

local player_state = {}

local get_formspec_for_player = function(player_name)
	local selected
	local state = player_state[player_name] or 1
	local collected = collectible_lore.get_player_collected(player_name)
	local collected_count = 0
	for index, val in pairs(collected) do
		collected_count = collected_count + 1
	end

	local form = {}
	table.insert(form, "formspec_version[6]size[14,8]")
	table.insert(form, "textlist[0.5,0.5;5,6.5;list;")
	if collected_count > 0 then
		local count = 1
		for index, value in pairs(collectible_lore.lorebooks) do
			local iscollected = collected[value.id]
			if iscollected and state == count then
				selected = value
			end
			count = count + 1
			if iscollected then
				table.insert(form, minetest.formspec_escape(value.title))
			else
				table.insert(form, "\t"..S("<not found yet>"))
			end
			table.insert(form, ",")
		end
		table.remove(form) -- removes trailing comma
	end
	table.insert(form, ";" .. state .. "]")
	if selected then
		table.insert(form, "label[6,0.5;" .. minetest.formspec_escape(selected.title) .. "]")
		if selected.text then
			table.insert(form, "textarea[6,1;7.5,6.5;;;" .. minetest.formspec_escape(selected.text) .. "]")
		elseif selected.image then
			table.insert(form, "image[6.5,1;6.5,6.5;" .. selected.image .. "]")
		end
	end
	table.insert(form, "label[0.5,7.5;" .. S("Collected: @1/@2", collected_count, #(collectible_lore.lorebooks)) .. "]")
	table.insert(form, "button_exit[2.75,7.3;2,0.4;exit;"..S("Exit") .. "]")
	
	return table.concat(form)
end

minetest.register_craftitem("collectible_lore:satchel", {
	description = S("Collectibles Satchel"),
	_doc_items_longdesc = S("A satchel containing various documents you've recovered in your travels."),
	_doc_items_usagehelp = S("The documents and lore you've unlocked are not tied to a specific satchel, any satchel will let you view your personal collection."),
	inventory_image = "collectible_lore_satchel.png",
	stack_max = 99,
	on_use = function(itemstack, user, pointed_thing)
		local player_name = user:get_player_name()
		minetest.show_formspec(player_name, "collectible_lore:formspec", get_formspec_for_player(player_name))
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "collectible_lore:formspec" then
		if fields.list then
			local exploded = minetest.explode_textlist_event(fields.list)
			if exploded.type == "CHG" then
				local player_name = player:get_player_name()
				player_state[player_name] = exploded.index
				minetest.show_formspec(player_name, "collectible_lore:formspec", get_formspec_for_player(player_name))
			end
		end
	elseif formname == "collectible_lore:collected" then
		if fields.view then
			local player_name = player:get_player_name()
			player_state[player_name] = cairn_last_collected_index
			minetest.show_formspec(player_name, "collectible_lore:formspec", get_formspec_for_player(player_name))
		end
	end
end)

minetest.register_chatcommand("cairn_locations", {
        params = "<range>",  -- Short parameter description
        description = S("Administrative control of collectibles"),
        privs = {server=true},
        func = function(name, param)
			local range = tonumber(param) or 1000
			local player = minetest.get_player_by_name(name)
			local player_pos = player:get_pos()
			local cairn_locations = cairn_area:get_areas_in_area(vector.subtract(player_pos, range), vector.add(player_pos, range))
			for _, data in pairs(cairn_locations) do
				minetest.chat_send_player(name, minetest.pos_to_string(data.min))			
			end
		end,
    })
