--This file contains references to external dependencies, in hopes of making it easier to make those optional in the future

df_primordial_items.node_names = {}

df_primordial_items.node_names.dirt = df_dependencies.node_name_dirt
df_primordial_items.node_names.dry_shrub = df_dependencies.node_name_dry_shrub
df_primordial_items.node_names.dry_grass_3 = df_dependencies.node_name_dry_grass_3
df_primordial_items.node_names.dry_grass_4 = df_dependencies.node_name_dry_grass_4
df_primordial_items.node_names.junglewood = df_dependencies.node_name_junglewood

df_primordial_items.sounds = {}

df_primordial_items.sounds.leaves = df_dependencies.sound_leaves()
df_primordial_items.sounds.wood = df_dependencies.sound_wood()
df_primordial_items.sounds.glass = df_dependencies.sound_glass()
df_primordial_items.sounds.dirt = df_dependencies.sound_dirt()

df_primordial_items.register_leafdecay = df_dependencies.register_leafdecay
df_primordial_items.after_place_leaves = df_dependencies.after_place_leaves

-- This stuff should only be used during initialization
minetest.after(0, function()
	df_primordial_items.node_names = nil
	df_primordial_items.sounds = nil
end)