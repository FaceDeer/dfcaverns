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

local S = minetest.get_translator(minetest.get_current_modname())

df_trees.sounds = {}

df_trees.sounds.wood = default.node_sound_wood_defaults()
df_trees.sounds.leaves = default.node_sound_leaves_defaults()
df_trees.sounds.nethercap_wood = default.node_sound_wood_defaults({
	footstep = {name = "default_snow_footstep", gain = 0.2},
})
df_trees.sounds.glass = default.node_sound_glass_defaults()

df_trees.node_names = {}

df_trees.node_names.torch = "default:torch"
df_trees.node_names.chest = "default:chest"
df_trees.node_names.furnace = "default:furnace"
df_trees.node_names.apple = "default:apple"
df_trees.node_names.gold_ingot = "default:gold_ingot"
df_trees.node_names.water_source = "default:water_source"
df_trees.node_names.river_water_source = "default:river_water_source"
df_trees.node_names.ice = "default:ice"
df_trees.node_names.water_flowing = "default:water_flowing"
df_trees.node_names.river_water_flowing = "default:river_water_flowing"
df_trees.node_names.snow = "default:snow"
df_trees.node_names.torch_wall = "default:torch_wall"
df_trees.node_names.stone_with_coal = "default:stone_with_coal"
df_trees.node_names.coalblock = "default:coalblock"
df_trees.node_names.paper = "default:paper"


df_trees.textures = {}
df_trees.textures.gold_block = "default_gold_block.png"

df_trees.register = {}

df_trees.register.all_stairs = function(name, override_def)
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

df_trees.register.all_fences = function (name, override_def)
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

-- this stuff is only for during initialization
minetest.after(0, function()
	df_trees.sounds = nil
	df_trees.node_names = nil
	df_trees.textures = nil
	df_trees.register = nil
end)


df_trees.iron_containing_nodes = {"default:stone_with_iron", "default:steelblock"}
df_trees.copper_containing_nodes = {"default:stone_with_copper", "default:copperblock"}
df_trees.mese_containing_nodes = {"default:stone_with_mese", "default:mese"}


df_trees.after_place_leaves = default.after_place_leaves
df_trees.register_leafdecay = default.register_leafdecay

-- This is used by other mods, leave it exposed
df_trees.node_sound_tree_soft_fungus_defaults = function(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "dfcaverns_fungus_footstep", gain = 0.3}
	default.node_sound_wood_defaults(table)
	return table
end
