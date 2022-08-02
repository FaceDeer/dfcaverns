df_farming.sounds = {}

df_farming.sounds.leaves = df_dependencies.sound_leaves()
df_farming.sounds.syrup = df_dependencies.sound_water()

if minetest.get_modpath("oil") then
	df_farming.sounds.syrup.footstep = {name = "oil_oil_footstep", gain = 0.2}
end

df_farming.node_names = {}

df_farming.node_names.dirt = df_dependencies.node_name_dirt
df_farming.node_names.dirt_wet = df_dependencies.node_name_dirt_wet
df_farming.node_names.mortar_pestle = df_dependencies.node_name_mortar_pestle
df_farming.node_names.bucket = df_dependencies.node_name_bucket_empty
df_farming.node_names.wool_white = df_dependencies.node_name_wool_white
df_farming.node_names.string = df_dependencies.node_name_string

df_farming.node_names.dirt_moss = "df_farming:dirt_with_cave_moss"
df_farming.node_names.floor_fungus = "df_farming:cobble_with_floor_fungus"

df_farming.bucket_register_liquid = df_dependencies.bucket_register_liquid

-- these are only for initialization
minetest.after(0, function()
	df_farming.sounds = nil
	df_farming.node_names = nil
	df_farming.bucket_register_liquid = nil
end)