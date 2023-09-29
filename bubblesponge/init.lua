local S = minetest.get_translator(minetest.get_current_modname())

local print_settingtypes = false
local CONFIG_FILE_PREFIX = "bubblesponge_"
local config = {}

bubblesponge = {}
bubblesponge.config = config

local function setting(stype, name, default, description)
	local value
	if stype == "bool" then
		value = minetest.settings:get_bool(CONFIG_FILE_PREFIX..name)
	elseif stype == "string" then
		value = minetest.settings:get(CONFIG_FILE_PREFIX..name)
	elseif stype == "int" or stype == "float" then
		value = tonumber(minetest.settings:get(CONFIG_FILE_PREFIX..name))
	end
	if value == nil then
		value = default
	end
	config[name] = value

	if print_settingtypes then
		minetest.debug(CONFIG_FILE_PREFIX..name.." ("..description..") "..stype.." "..tostring(default))
	end
end

setting("int", "uses", 30, "Number of uses for a bubblesponge")
setting("int", "growth_seconds", 1000, "Number of seconds between each growth check for bubblesponge stems")
setting("int", "y_max", -300, "Maximum altitude at which bubblesponge will grow")

local function use_airtank(itemstack, user)
	local breath = user:get_breath()
	if breath > 9 then return itemstack end
	breath = math.min(10, breath+5)
	user:set_breath(breath)
	minetest.sound_play("bubblesponge_bubbles", {pos = user:get_pos(), gain = 0.5})

	--if not minetest.settings:get_bool("creative_mode") then
		local wdef = itemstack:get_definition()
		itemstack:add_wear(65535/(wdef._airtanks_uses-1))
		if itemstack:get_count() == 0 then
			if wdef.sound and wdef.sound.breaks then
				minetest.sound_play(wdef.sound.breaks,
					{pos = user:get_pos(), gain = 0.5})
			end
		end
	--end
	return itemstack
end

minetest.register_tool("bubblesponge:tank", {
	description = S("Bubblesponge Frond"),
	_doc_items_longdesc = S("A frond harvested from a bubblesponge."),
	_doc_items_usagehelp = S("If you're underwater and you're running out of breath, wield this item and use it to replenish 5 bubbles on your breath bar. When fully charged this frond has @1 uses before it becomes empty.", config.uses),
	_airtanks_uses = config.uses,
	inventory_image = "bubblesponge_frond.png",
	wield_image = "bubblesponge_frond.png",
	stack_max = 1,
	groups = {bubblesponge_tank = 1},

	on_place = function(itemstack, user, pointed_thing)
		return use_airtank(itemstack, user)
	end,

	on_use = function(itemstack, user, pointed_thing)
		return use_airtank(itemstack, user)
	end,
})

minetest.register_tool("bubblesponge:bundle", {
	description = S("Bubblesponge Bundle"),
	_doc_items_longdesc = S("A bundle of fronds harvested from a bubblesponge."),
	_doc_items_usagehelp = S("If you're underwater and you're running out of breath, wield this item and use it to replenish 5 bubbles on your breath bar. When fully charged this frond has @1 uses before it becomes empty.", config.uses * 9),
	_airtanks_uses = config.uses * 9,
	inventory_image = "bubblesponge_bundle.png",
	wield_image = "bubblesponge_bundle.png",
	stack_max = 1,
	groups = {bubblesponge_tank = 1},

	on_place = function(itemstack, user, pointed_thing)
		return use_airtank(itemstack, user)
	end,

	on_use = function(itemstack, user, pointed_thing)
		return use_airtank(itemstack, user)
	end,
})

minetest.register_craft({
	recipe = {
		{"bubblesponge:tank", "bubblesponge:tank", "bubblesponge:tank"},
		{"bubblesponge:tank", "bubblesponge:tank", "bubblesponge:tank"},
		{"bubblesponge:tank", "bubblesponge:tank", "bubblesponge:tank"},
	},
	output = "bubblesponge:bundle",
})

local water_node = df_dependencies.node_name_water_source

minetest.register_node("bubblesponge:stem", {
	description = S("Bubblesponge Trunk"),
	_doc_items_longdesc = S("The trunk of a massive sponge. Bubblesponges grow deep underwater in caverns and their fronds have uniquely helpful properties for divers."),
	_doc_items_usagehelp = S("If you're underwater and you're running out of breath you can squeeze a lungful of air from a wielded Bubblesponge frond"),
	groups = {oddly_breakable_by_hand = 1, handy = 1},
	sounds = df_trees.node_sound_tree_soft_fungus_defaults(),
	tiles = {"bubblesponge_bubblesponge.png"},
	use_texture_alpha = "clip",
	drop = {
		max_items = 2,
		items = {
			{
				rarity = 10, -- occasionally split the stem to allow farming
                items = {"bubblesponge:stem"},
            },
			{
				rarity = 1,
                items = {"bubblesponge:stem"},
            },
		},
	},
	drawtype = "normal",
	paramtype = "light",
	is_ground_content = false,
	light_source = 6,

	on_timer = function(pos, elapsed)
		local timer = minetest.get_node_timer(pos)
		elapsed = elapsed - config.growth_seconds
		timer:set(config.growth_seconds, elapsed)

		if pos.y > config.y_max then
			return
		end

		pos.y = pos.y + 1

		if minetest.find_node_near(pos, 4, "air", true) then
			return
		end

		local tries = 0
		while tries < 3 do
			local this_node = minetest.get_node(pos).name
			if minetest.get_node(pos).name == water_node then
				minetest.set_node(pos, {name = "bubblesponge:frond"})
				return
			else
				pos = {x = pos.x + math.random(-1, 1), y = pos.y + math.random(0, 1), z = pos.z + math.random(-1, 1)}
				tries = tries + 1
			end
		end
	end,

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(config.growth_seconds + math.random(-0.1, 0.1)*config.growth_seconds)
		--minetest.get_node_timer(pos):set(1, config.growth_seconds * 6) -- immediate growth
	end,
	on_destruct = function(pos)
		minetest.get_node_timer(pos):stop()
	end,
})

minetest.register_node("bubblesponge:frond", {
    description = S("Bubblesponge Frond"),
    drawtype = "plantlike",
    visual_scale = 1.2,
    tiles = {"bubblesponge_growth.png"},
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    buildable_to = true,
    groups = {snappy=3, oddly_breakable_by_hand = 1, handy = 1, not_in_creatove_inventory=1},
    sounds = df_dependencies.sound_leaves(),
	drop = "bubblesponge:tank",
})

local function use_any_airtank_in_hotbar(player)
	local inv = player:get_inventory()
	local hotbar = player:hud_get_hotbar_itemcount()
	for i=1, hotbar do
		local itemstack = inv:get_stack("main", i)
		if minetest.get_item_group(itemstack:get_name(), "bubblesponge_tank") >= 1 then
			itemstack = use_airtank(itemstack, player)
			inv:set_stack("main", i, itemstack)
			return true
		end
	end
	return false
end

local function player_event_handler(player, eventname)
	if player:is_player() and eventname == "breath_changed" and player:get_breath() < 2 then
		use_any_airtank_in_hotbar(player)
	end

	return false
end

minetest.register_playerevent(player_event_handler)
