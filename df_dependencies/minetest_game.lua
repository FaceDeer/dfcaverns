local S = minetest.get_translator(minetest.get_current_modname())

--- From "default"

df_dependencies.sound_dirt = default.node_sound_dirt_defaults
df_dependencies.sound_glass = default.node_sound_glass_defaults
df_dependencies.sound_leaves = default.node_sound_leaves_defaults
df_dependencies.sound_sand = default.node_sound_sand_defaults
df_dependencies.sound_stone = default.node_sound_stone_defaults
df_dependencies.sound_water = default.node_sound_water_defaults
df_dependencies.sound_wood = default.node_sound_wood_defaults

df_dependencies.soundfile_grass_footstep = "default_grass_footstep"
df_dependencies.soundfile_snow_footstep = "default_snow_footstep"

df_dependencies.node_name_apple = "default:apple"
df_dependencies.node_name_chest = "default:chest"
df_dependencies.node_name_coalblock = "default:coalblock"
df_dependencies.node_name_cobble = "default:cobble"
df_dependencies.node_name_coral_skeleton = 	"default:coral_skeleton"
df_dependencies.node_name_desert_sand = "default:desert_sand"
df_dependencies.node_name_dirt = "default:dirt"
df_dependencies.node_name_dry_grass_3 = "default:dry_grass_3"
df_dependencies.node_name_dry_grass_4 = "default:dry_grass_4"
df_dependencies.node_name_dry_shrub = "default:dry_shrub"
df_dependencies.node_name_furnace = "default:furnace"
df_dependencies.node_name_gold_ingot = "default:gold_ingot"
df_dependencies.node_name_gravel = "default:gravel"
df_dependencies.node_name_ice = "default:ice"
df_dependencies.node_name_junglewood = "default:junglewood"
df_dependencies.node_name_lava_source = "default:lava_source"
df_dependencies.node_name_mese_crystal = "default:mese_crystal"
df_dependencies.node_name_mossycobble = "default:mossycobble"
df_dependencies.node_name_obsidian = "default:obsidian"
df_dependencies.node_name_paper = "default:paper"
df_dependencies.node_name_river_water_flowing = "default:river_water_flowing"
df_dependencies.node_name_river_water_source = "default:river_water_source"
df_dependencies.node_name_sand = "default:sand"
df_dependencies.node_name_sand = "default:sand"
df_dependencies.node_name_silver_sand = "default:silver_sand"
df_dependencies.node_name_snow = "default:snow"
df_dependencies.node_name_stone = "default:stone"
df_dependencies.node_name_stone_with_coal = "default:stone_with_coal"
df_dependencies.node_name_stone_with_mese = "default:stone_with_mese"
df_dependencies.node_name_torch = "default:torch"
df_dependencies.node_name_torch_wall = "default:torch_wall"
df_dependencies.node_name_water_flowing = "default:water_flowing"
df_dependencies.node_name_water_source = "default:water_source"


df_dependencies.texture_cobble = "default_cobble.png"
df_dependencies.texture_coral_skeleton = "default_coral_skeleton.png"
df_dependencies.texture_dirt = "default_dirt.png"
df_dependencies.texture_gold_block = "default_gold_block.png"
df_dependencies.texture_ice = "default_ice.png"
df_dependencies.texture_sand = "default_sand.png"
df_dependencies.texture_stone = "default_stone.png"

df_dependencies.data_iron_containing_nodes = {"default:stone_with_iron", "default:steelblock"}
df_dependencies.data_copper_containing_nodes = {"default:stone_with_copper", "default:copperblock"}
df_dependencies.data_mese_containing_nodes = {"default:stone_with_mese", "default:mese"}

df_dependencies.register_leafdecay = default.register_leafdecay
df_dependencies.after_place_leaves = default.after_place_leaves

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

df_dependencies.node_name_bucket_empty = "bucket:bucket_empty"

-- from "wool"

df_dependencies.node_name_wool_white = "wool:white"

-- from "fireflies"
df_dependencies.node_name_fireflies = "fireflies:firefly"
