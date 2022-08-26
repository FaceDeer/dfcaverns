local S = minetest.get_translator(minetest.get_current_modname())

local initialize = function(pos, meta)
	if not meta:contains("key") then
		local inv = meta:get_inventory()
		inv:set_size("main", 8)
		local next_seed = math.random() * 2^21
		math.randomseed(pos.x + pos.y^8 + pos.z^16)
		-- Key is consistent with location
		local key = {math.random(0,7), math.random(0,7), math.random(0,7), math.random(0,7)}
		math.randomseed(next_seed)
		local state = {math.random(0,7), math.random(0,7), math.random(0,7), math.random(0,7)}
		meta:set_string("key", minetest.serialize(key))
		meta:set_string("state", minetest.serialize(state))
		meta:mark_as_private("key")
		meta:mark_as_private("state") -- not really necessary, but for consistency
	end
end

-- 1 2
-- 3 4

local sum_square = function(input)
	return {input[1] + input[2], input[3] + input[4], input[1] + input[3], input[2] + input[4]}
end

local formspec_dial = function(identifier, state)
	return "label[0.5,0;"..tostring(state).."]"
		.. "button[0,0.25;0.5,0.5;"..identifier.."-;←]"
		.. "button[1.5,0.25;0.5,0.5;"..identifier.."+;→]"
end

local formspec_bar = function(horizontal, state, key)
	--return "label[0,0;" .. tostring(state) .. "/" .. tostring(key) .. "]"
	if horizontal then
		return "box[0,0;".. tostring(key/14 * 2) ..",1;#222222ff]box[0,0.1;".. tostring(state/14 * 2)..",0.8;#ff00ffff]"
	end
	return "box[0,0;1,".. tostring(key/14 * 2) ..";#222222ff]box[0.1,0;0.8,".. tostring(state/14 * 2)..";#ff00ffff]"
end

local prefix = "df_underworld_items:puzzle_chest"
local prefix_len = string.len("df_underworld_items:puzzle_chest")

local show_formspec = function(pos, node, clicker, itemstack, pointed_thing)
	local meta = minetest.get_meta(pos)
	initialize(pos, meta)
	local key = minetest.deserialize(meta:get_string("key"))
	local state = minetest.deserialize(meta:get_string("state"))
	local key_sum = sum_square(key)
	local state_sum = sum_square(state)
	local solved = key_sum[1] == state_sum[1] and key_sum[2] == state_sum[2] and key_sum[3] == state_sum[3] and key_sum[4] == state_sum[4]
	local playername = clicker:get_player_name()
	local formname = prefix .. minetest.pos_to_string(pos)
	local formspec = "formspec_version[6]"
		.. "size[11,11.5]"
		.. "container[3.5,1]"
		.. "container[0,0]" .. formspec_dial("dial1", state[1]) .. "container_end[]"
		.. "container[2,0]" .. formspec_dial("dial2", state[2]) .. "container_end[]"
		.. "container[0,1]" .. formspec_dial("dial3", state[3]) .. "container_end[]"
		.. "container[2,1]" .. formspec_dial("dial4", state[4]) .. "container_end[]"
		.. "container[4.1,0]" .. formspec_bar(true, state_sum[1], key_sum[1]) .. "container_end[]"		
		.. "container[4.1,1]" .. formspec_bar(true, state_sum[2], key_sum[2]) .. "container_end[]"		
		.. "container[0.5,2.1]" .. formspec_bar(false, state_sum[3], key_sum[3]) .. "container_end[]"		
		.. "container[2.5,2.1]" .. formspec_bar(false, state_sum[4], key_sum[4]) .. "container_end[]"
		.. "container_end[]"
		.. "list[current_player;main;0.6,6.2;8,4;]"
	if solved then
		local nodemeta = "nodemeta:"..pos.x..","..pos.y..","..pos.z
		formspec = formspec
			.. "list["..nodemeta..";main;0.6,4.7;8,1;]"
	end

	minetest.show_formspec(playername, formname, formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if string.sub(formname, 1, prefix_len) ~= prefix then return end
	--minetest.debug(dump(fields))
	if fields.quit then return end
	local pos = minetest.string_to_pos(string.sub(formname, prefix_len+1, -1))
	local meta = minetest.get_meta(pos)
	local state = minetest.deserialize(meta:get_string("state"))
	for i = 1,4 do
		if fields["dial"..tostring(i).."+"] then
			state[i] = (state[i] + 1) % 8
			break
		elseif fields["dial"..tostring(i).."-"] then
			state[i] = (state[i] - 1) % 8
			break
		end
	end
	meta:set_string("state", minetest.serialize(state))
	show_formspec(pos, nil, player)
end)


minetest.register_node("df_underworld_items:puzzle_chest", {
	description = S("Puzzle Chest"),
	_doc_items_longdesc = df_underworld_items.doc.puzzle_chest_desc,
	_doc_items_usagehelp = df_underworld_items.doc.puzzle_chest_usage,
	tiles = {"dfcaverns_glow_amethyst.png"},
	is_ground_content = false,
	groups = {cracky=3, pit_plasma_resistant=1, pickaxey = 4, building_block = 1,}, -- deliberately not in material_stone group to keep pit plasma ABM efficient
	sounds = df_dependencies.sound_glass(),
	light_source = 6,
	paramtype = "light",
	use_texture_alpha = "blend",
	drawtype = "glasslike",
	sunlight_propagates = true,
	_mcl_blast_resistance = 6,
	_mcl_hardness = 2,
	
	on_rightclick = show_formspec,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		initialize(pos, meta)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
})

