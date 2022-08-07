local S = minetest.get_translator(minetest.get_current_modname())

if minetest.get_modpath("default") then
	df_dependencies.register_leafdecay = default.register_leafdecay
	df_dependencies.after_place_leaves = default.after_place_leaves
elseif ("mcl_core") then
	-- Mineclone does leaf decay differently, it uses the "leafdecay" group to require that leaves remain
	-- within the group value distance of any node of group "tree".
	-- make sure to add place_param2 = 1 to leaves to prevent decay of player-placed leaves
	df_dependencies.register_leafdecay = function() end
	df_dependencies.after_place_leaves = function() end
end


df_dependencies.mods_required.bucket = true
if minetest.get_modpath("bucket") then
	df_dependencies.bucket_register_liquid = bucket.register_liquid
else
	-- TODO
end


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

df_dependencies.mods_required.stairs = true
df_dependencies.mods_required.moreblocks = true
df_dependencies.mods_required.doors = true
df_dependencies.mods_required.mcl_stairs = true


local node_name_to_stair_properties = function(name, override)
	local mod = minetest.get_current_modname()

	local node_def = minetest.registered_nodes[mod..":"..name]
	override_def = override_def or {}
		
	local node_copy = deep_copy(node_def)
	for index, value in pairs(override_def) do
		node_copy[index] = value
	end
	return mod, node_copy
end

df_dependencies.register_stairs = function(name, override_def)
	local mod, node_copy = node_name_to_stair_properties(name, override_def)
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
	if minetest.get_modpath("mcl_stairs") then
		mcl_stairs.register_stair_and_slab_simple(
			name,
			mod ..":" .. name,
			S("@1 Stair", node_copy.description),
			S("@1 Slab", node_copy.description),
			S("Double @1 Slab", node_copy.description)
		)
	end
end

df_dependencies.register_more_stairs = function(name, override_def)
	local mod, node_copy = node_name_to_stair_properties(name, override_def)
	if minetest.get_modpath("moreblocks") then
		stairsplus:register_all(mod, name, mod..":"..name, node_copy)
	end
end

df_dependencies.register_all_fences = function (name, override_def)
	local mod, node_def = node_name_to_stair_properties(name, override_def)

	override_def = override_def or {}
	
	local material = override_def.material or mod..":"..name
	local burntime = override_def.burntime
	local texture = override_def.texture or node_def.tiles[1]
	
	if minetest.get_modpath("default") then
		default.register_fence(material .. "_fence", {
			description = S("@1 Fence", node_def.description),
			texture = texture,
			material = material,
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
			texture = texture,
			material = material,
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
			texture = texture,
			material = material,
			groups = deep_copy(node_def.groups or {}), -- the default register_fence_rail function modifies the groups table passed in, so send a copy instead to be on the safe side.
			sounds = node_def.sounds
		})
	end
	
	if minetest.get_modpath("doors") then
		doors.register_fencegate(material .. "_fence_gate", {
			description = S("@1 Fence Gate", node_def.description),
			texture = texture,
			material = material,
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

df_dependencies.register_all_stairs_and_fences = function(name, override_def)
	df_dependencies.register_stairs(name, override_def)
	df_dependencies.register_more_stairs(name, override_def)
	df_dependencies.register_all_fences(name, override_def)
end