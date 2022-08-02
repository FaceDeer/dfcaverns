local S = minetest.get_translator(minetest.get_current_modname())

local mods_required = {}

local select_required = function(def)
	local count = 0
	local total = 0
	local ret
	for mod, item in pairs(def) do
		total = total + 1
		mods_required[mod] = true
		if minetest.get_modpath(mod) then
			count = count + 1
			ret = item
		end
	end
	assert(count ~= 0, "Unable to find item for dependency set " .. dump(def))
	assert(count == 1, "Found more than one item for dependency set " .. dump(def))
	--assert(total == 2, "number of options other than two for " .. dump(def))
	return ret
end

local select_optional = function(def)
	for mod, item in pairs(def) do
		if minetest.get_modpath(mod) then
			return item
		end
	end
end

--- From "default"
if minetest.get_modpath("default") then
	df_dependencies.sound_dirt = default.node_sound_dirt_defaults
	df_dependencies.sound_glass = default.node_sound_glass_defaults
	df_dependencies.sound_gravel = default.node_sound_gravel_defaults
	df_dependencies.sound_leaves = default.node_sound_leaves_defaults
	df_dependencies.sound_sand = default.node_sound_sand_defaults
	df_dependencies.sound_stone = default.node_sound_stone_defaults
	df_dependencies.sound_water = default.node_sound_water_defaults
	df_dependencies.sound_wood = default.node_sound_wood_defaults
elseif minetest.get_modpath("mcl_sounds") then
	df_dependencies.sound_dirt = mcl_sounds.node_sound_dirt_defaults
	df_dependencies.sound_glass = mcl_sounds.node_sound_glass_defaults
	df_dependencies.sound_gravel = function(table)
		table = table or {}
		table.footstep = table.footstep or {name="default_gravel_footstep", gain=0.45}
		return mcl_sounds.node_sound_dirt_defaults(table)
	end
	df_dependencies.sound_leaves = mcl_sounds.node_sound_leaves_defaults
	df_dependencies.sound_sand = mcl_sounds.node_sound_sand_defaults
	df_dependencies.sound_stone = mcl_sounds.node_sound_stone_defaults
	df_dependencies.sound_water = mcl_sounds.node_sound_water_defaults
	df_dependencies.sound_wood = mcl_sounds.node_sound_wood_defaults
else
	assert(false, "One of [default] or [mcl_sounds] must be active")
end

df_dependencies.soundfile_grass_footstep = select_required({default="default_grass_footstep", mcl_sounds="default_grass_footstep"})
df_dependencies.soundfile_snow_footstep = select_required({default="default_snow_footstep", mcl_sounds="pedology_snow_soft_footstep"})
df_dependencies.soundfile_gravel_footstep = select_required({default="default_gravel_footstep", mcl_sounds="default_gravel_footstep"})
df_dependencies.soundfile_cool_lava = select_required({default="default_cool_lava", mcl_sounds="default_cool_lava"})

df_dependencies.node_name_apple = select_required({default="default:apple", mcl_core="mcl_core:apple"})
df_dependencies.node_name_chest = select_required({default="default:chest", mcl_chests="mcl_chests:chest"})
df_dependencies.node_name_coalblock = select_required({default="default:coalblock", mcl_core="mcl_core:coalblock"})
df_dependencies.node_name_coal_lump = select_required({default="default:coal_lump", mcl_core="mcl_core:coal_lump"})
df_dependencies.node_name_cobble = select_required({default="default:cobble", mcl_core="mcl_core:cobble"})
df_dependencies.node_name_coral_skeleton = select_required({default="default:coral_skeleton", mcl_ocean="mcl_ocean:dead_horn_coral_block"})
df_dependencies.node_name_desert_sand = select_required({default="default:desert_sand", mcl_core="mcl_core:redsand"})
df_dependencies.node_name_dirt = select_required({default="default:dirt", mcl_core="mcl_core:dirt"})
df_dependencies.node_name_dry_grass_3 = select_required({default="default:dry_grass_3", mcl_core="mcl_core:deadbush"})  -- There doesn't seem to be an MCL equivalent of this
df_dependencies.node_name_dry_grass_4 = select_required({default="default:dry_grass_4", mcl_core="mcl_core:deadbush"}) -- There doesn't seem to be an MCL equivalent of this
df_dependencies.node_name_dry_shrub = select_required({default="default:dry_shrub", mcl_core="mcl_core:deadbush"})
df_dependencies.node_name_furnace = select_required({default="default:furnace", mcl_furnaces="mcl_furnaces:furnace"})
df_dependencies.node_name_gold_ingot = select_required({default="default:gold_ingot", mcl_core="mcl_core:gold_ingot"})
df_dependencies.node_name_gravel = select_required({default="default:gravel", mcl_core="mcl_core:gravel"})
df_dependencies.node_name_ice = select_required({default="default:ice", mcl_core="mcl_core:ice"})
df_dependencies.node_name_junglewood = select_required({default="default:junglewood", mcl_core="mcl_core:junglewood"})
df_dependencies.node_name_lava_source = select_required({default="default:lava_source", mcl_core="mcl_core:lava_source"})
df_dependencies.node_name_mese_crystal = select_required({default="default:mese_crystal", mesecons="mesecons:redstone"}) -- TODO make sure this is properly balanced. Also, mesecons mod conflict with non-mcl mesecons?
df_dependencies.node_name_meselamp = select_required({default="default:meselamp", })
df_dependencies.node_name_mossycobble = select_required({default="default:mossycobble", mcl_core="mcl_core:mossycobble"})
df_dependencies.node_name_obsidian = select_required({default="default:obsidian", mcl_core="mcl_core:obsidian"})
df_dependencies.node_name_paper = select_required({default="default:paper", mcl_core="mcl_core:paper"})
df_dependencies.node_name_river_water_flowing = select_required({default="default:river_water_flowing", mclx_core="mclx_core:river_water_flowing"})
df_dependencies.node_name_river_water_source = select_required({default="default:river_water_source", mclx_core="mclx_core:river_water_source"})
df_dependencies.node_name_sand = select_required({default="default:sand", mcl_core="mcl_core:sand"})
df_dependencies.node_name_silver_sand = select_required({default="default:silver_sand", mcl_core="mcl_core:sand"}) -- There doesn't seem to be an MCL equivalent of this
df_dependencies.node_name_snow = select_required({default="default:snow", mcl_core="mcl_core:snow"})
df_dependencies.node_name_stone = select_required({default="default:stone", mcl_core="mcl_core:stone"})
df_dependencies.node_name_stone_with_coal = select_required({default="default:stone_with_coal", mcl_core="mcl_core:stone_with_coal"})
df_dependencies.node_name_stone_with_mese = select_required({default="default:stone_with_mese", })
df_dependencies.node_name_torch = select_required({default="default:torch", mcl_torches="mcl_torches:torch"})
df_dependencies.node_name_torch_wall = select_required({default="default:torch_wall", mcl_torches="mcl_torches:torch_wall"})
df_dependencies.node_name_water_flowing = select_required({default="default:water_flowing", mcl_core="mcl_core:water_flowing"})
df_dependencies.node_name_water_source = select_required({default="default:water_source", mcl_core="mcl_core:water_source"})

df_dependencies.texture_cobble = select_required({default="default_cobble.png", mcl_core="default_cobble.png"})
df_dependencies.texture_coral_skeleton = select_required({default="default_coral_skeleton.png", mcl_ocean="mcl_ocean_dead_horn_coral_block.png"})
df_dependencies.texture_dirt = select_required({default="default_dirt.png", mcl_core="default_dirt.png"})
df_dependencies.texture_gold_block = select_required({default="default_gold_block.png", mcl_core="default_gold_block.png"})
df_dependencies.texture_ice = select_required({default="default_ice.png", mcl_core="default_ice.png"})
df_dependencies.texture_sand = select_required({default="default_sand.png", mcl_core="default_sand.png"})
df_dependencies.texture_stone = select_required({default="default_stone.png", mcl_core="default_stone.png"})
df_dependencies.texture_wood = select_required({default="default_wood.png", mcl_core="default_wood.png"})
df_dependencies.texture_mineral_coal = select_required({default="default_mineral_coal.png",	mcl_core="mcl_core_coal_ore.png"}) -- MCL's coal texture isn't transparent, but is only used with gas seeps and should work fine that way

-- used to determine colour of spindlestem caps
df_dependencies.data_iron_containing_nodes = {"default:stone_with_iron", "default:steelblock"}
df_dependencies.data_copper_containing_nodes = {"default:stone_with_copper", "default:copperblock"}
df_dependencies.data_mese_containing_nodes = {"default:stone_with_mese", "default:mese"}

df_dependencies.register_leafdecay = default.register_leafdecay
df_dependencies.after_place_leaves = default.after_place_leaves

df_dependencies.LIGHT_MAX = default.LIGHT_MAX


-- Note that a circular table reference will result in a crash, TODO: guard against that.
-- Unlikely to be needed, though - it'd take a lot of work for users to get into this bit of trouble.
local function deep_copy(table_in)
	local table_out = {}

	for index, value in pairs(table_in) do
		if type(value) == "table" then
			table_out[index] = deep_copy(value)
		else
			table_out[index] = value
		end
	end
	return table_out
end

df_dependencies.register_all_stairs = function(name, override_def)
	local mod = minetest.get_current_modname()

	local node_def = minetest.registered_nodes[mod..":"..name]
	override_def = override_def or {}
		
	local node_copy = deep_copy(node_def)
	for index, value in pairs(override_def) do
		node_copy[index] = value
	end
		
	if minetest.get_modpath("stairs") then
		stairs.register_stair_and_slab(
			name,
			mod ..":" .. name,
			node_copy.groups,
			node_copy.tiles,
			S("@1 Stair", node_copy.description),
			S("@1 Slab", node_copy.description),
			node_copy.sounds
		)
	end
	if minetest.get_modpath("moreblocks") then
		stairsplus:register_all(mod, name, mod..":"..name, node_copy)
	end
end

df_dependencies.register_all_fences = function (name, override_def)
	local mod = minetest.get_current_modname()

	local material = mod..":"..name
	local node_def = minetest.registered_nodes[material]
	override_def = override_def or {}
	
	local burntime = override_def.burntime
	
	default.register_fence(material .. "_fence", {
		description = S("@1 Fence", node_def.description),
		texture = override_def.texture or node_def.tiles[1],
		material = override_def.material or material,
		groups = deep_copy(node_def.groups or {}), -- the default register_fence function modifies the groups table passed in, so send a copy instead to be on the safe side.
		sounds = node_def.sounds
	})
	if burntime then
		minetest.register_craft({
			type = "fuel",
			recipe = material .. "_fence",
			burntime = burntime, -- ignoring two sticks
		})
	end

	default.register_fence_rail(material .. "_fence_rail", {
		description = S("@1 Fence Rail", node_def.description),
		texture = override_def.texture or node_def.tiles[1],
		material = override_def.material or material,
		groups = deep_copy(node_def.groups or {}), -- the default register_fence_rail function modifies the groups table passed in, so send a copy instead to be on the safe side.
		sounds = node_def.sounds
	})
	if burntime then
		minetest.register_craft({
			type = "fuel",
			recipe = material .. "_fence_rail",
			burntime = burntime * 4/16,
		})
	end

	default.register_mesepost(material .. "_mese_light", {
		description = S("@1 Mese Post Light", node_def.description),
		texture = override_def.texture or node_def.tiles[1],
		material = override_def.material or material,
		groups = deep_copy(node_def.groups or {}), -- the default register_fence_rail function modifies the groups table passed in, so send a copy instead to be on the safe side.
		sounds = node_def.sounds
	})
	
	if minetest.get_modpath("doors") then
		doors.register_fencegate(material .. "_fence_gate", {
			description = S("@1 Fence Gate", node_def.description),
			texture = override_def.texture or node_def.tiles[1],
			material = override_def.material or material,
			groups = deep_copy(node_def.groups or {}), -- the default register_fence_rail function modifies the groups table passed in, so send a copy instead to be on the safe side.
			sounds = node_def.sounds
		})
		
		if burntime then
			minetest.register_craft({
				type = "fuel",
				recipe = material .. "_fence_gate_closed",
				burntime = burntime * 2, -- ignoring four sticks
			})
		end
	end
end

-- from "farming"
if minetest.get_modpath("farming") then

	df_dependencies.node_name_dirt_furrowed = "farming:soil"
	df_dependencies.node_name_dirt_wet = "farming:soil_wet"
	df_dependencies.node_name_mortar_pestle = "farming:mortar_pestle"
	df_dependencies.node_name_string = "farming:string"

	-- If the farming mod is installed, add the "straw" group to farming straw.
	-- This way goblin caps just need to check for group:straw to get cave straw as well
	local straw_def = minetest.registered_items["farming:straw"]
	if straw_def then
		local new_groups = {}
		for group, val in pairs(straw_def.groups) do
			new_groups[group] = val
		end
		new_groups.straw = 1
		minetest.override_item("farming:straw", {
			groups = new_groups
		})
	end
end

-- from "bucket"
df_dependencies.node_name_bucket_empty = select_required({bucket="bucket:bucket_empty", mcl_buckets="mcl_buckets:bucket_empty"})
df_dependencies.bucket_register_liquid = bucket.register_liquid

-- from "wool"

df_dependencies.node_name_wool_white = select_required({wool="wool:white", mcl_wool="mcl_wool:white"})

-- from "fireflies"
if minetest.get_modpath("fireflies") then
	df_dependencies.node_name_fireflies = "fireflies:firefly"
end

-- from "vessels"
df_dependencies.node_name_glass_bottle = select_required({vessels="vessels:glass_bottle", mcl_potions="mcl_potions:glass_bottle"})
df_dependencies.node_name_shelf = select_required({vessels="vessels:shelf", })
df_dependencies.texture_glass_bottle = select_required({vessels="vessels_glass_bottle.png",	mcl_potions="mcl_potions_potion_bottle.png"})

-- from "beds"
df_dependencies.node_name_bed_bottom = select_required({beds="beds:bed_bottom",	mcl_beds="mcl_beds:bed_red_bottom"})
df_dependencies.node_name_bed_top = select_required({beds="beds:bed_top", mcl_beds="mcl_beds:bed_red_top"})

-- from "doors"
df_dependencies.node_name_door_wood_a = select_required({doors="doors:door_wood_a",	mcl_doors="mcl_doors:wooden_door"})
df_dependencies.node_name_door_hidden = select_required({doors="doors:hidden"})

minetest.debug(dump(mods_required))