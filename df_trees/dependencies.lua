local S = minetest.get_translator(minetest.get_current_modname())

df_trees.sounds = {}

df_trees.sounds.wood = df_dependencies.sound_wood()
df_trees.sounds.leaves = df_dependencies.sound_leaves()
df_trees.sounds.nethercap_wood = df_dependencies.sound_wood({
	footstep = {name = df_dependencies.soundfile_snow_footstep, gain = 0.2},
})
df_trees.sounds.glass = df_dependencies.sound_glass()

df_trees.node_names = {}

df_trees.node_names.apple = df_dependencies.node_name_apple
df_trees.node_names.bed_bottom = df_dependencies.node_name_bed_bottom
df_trees.node_names.bed_top = df_dependencies.node_name_bed_top
df_trees.node_names.chest = df_dependencies.node_name_chest
df_trees.node_names.coalblock = df_dependencies.node_name_coalblock
df_trees.node_names.furnace = df_dependencies.node_name_furnace
df_trees.node_names.gold_ingot = df_dependencies.node_name_gold_ingot
df_trees.node_names.ice = df_dependencies.node_name_ice
df_trees.node_names.paper = df_dependencies.node_name_paper
df_trees.node_names.river_water_flowing = df_dependencies.node_name_river_water_flowing
df_trees.node_names.river_water_source = df_dependencies.node_name_river_water_source
df_trees.node_names.snow = df_dependencies.node_name_snow
df_trees.node_names.stone_with_coal = df_dependencies.node_name_stone_with_coal
df_trees.node_names.torch = df_dependencies.node_name_torch
df_trees.node_names.torch_wall = df_dependencies.node_name_torch_wall
df_trees.node_names.water_flowing = df_dependencies.node_name_water_flowing
df_trees.node_names.water_source = df_dependencies.node_name_water_source
df_trees.node_names.door_wood_a = df_dependencies.node_name_door_wood_a
df_trees.node_names.door_hidden = df_dependencies.node_name_door_hidden
df_trees.node_names.shelf = df_dependencies.node_name_shelf

df_trees.textures = {}
df_trees.textures.gold_block = df_dependencies.texture_gold_block

df_trees.register = {}

df_trees.register.all_stairs_and_fences = df_dependencies.register_all_stairs_and_fences

-- this stuff is only for during initialization
minetest.after(0, function()
	df_trees.sounds = nil
	df_trees.node_names = nil
	df_trees.textures = nil
	df_trees.register = nil
end)

df_trees.iron_containing_nodes = df_dependencies.data_iron_containing_nodes
df_trees.copper_containing_nodes = df_dependencies.data_copper_containing_nodes
df_trees.mese_containing_nodes = df_dependencies.data_mese_containing_nodes

df_trees.after_place_leaves = df_dependencies.after_place_leaves
df_trees.register_leafdecay = df_dependencies.register_leafdecay

-- This is used by other mods, leave it exposed
df_trees.node_sound_tree_soft_fungus_defaults = function(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "dfcaverns_fungus_footstep", gain = 0.3}
	df_dependencies.sound_wood(table)
	return table
end
