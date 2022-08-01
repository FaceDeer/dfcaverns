df_mapitems.sounds = {}

df_mapitems.sounds.stone = df_dependencies.sound_stone()
df_mapitems.sounds.floor_fungus = df_dependencies.sound_stone({footstep = {name = "dfcaverns_squish", gain = 0.25},})
df_mapitems.sounds.sandscum = df_dependencies.sound_sand({footstep = {name = "dfcaverns_squish", gain = 0.25},})
df_mapitems.sounds.glass = df_dependencies.sound_glass()
df_mapitems.sounds.dirt = df_dependencies.sound_dirt()
df_mapitems.sounds.dirt_mossy = df_dependencies.sound_dirt({footstep = {name = df_dependencies.soundfile_grass_footstep, gain = 0.25},})

df_mapitems.node_id = {}

df_mapitems.node_id.stone = minetest.get_content_id(df_dependencies.node_name_stone)
df_mapitems.node_id.water = minetest.get_content_id(df_dependencies.node_name_water_source)
df_mapitems.node_id.dirt = minetest.get_content_id(df_dependencies.node_name_dirt)

df_mapitems.texture = {}

df_mapitems.texture.coral_skeleton = df_dependencies.texture_coral_skeleton
df_mapitems.texture.cobble = df_dependencies.texture_cobble
df_mapitems.texture.stone = df_dependencies.texture_stone
df_mapitems.texture.ice = df_dependencies.texture_ice
df_mapitems.texture.sand = df_dependencies.texture_sand
df_mapitems.texture.dirt = df_dependencies.texture_dirt

df_mapitems.node_name = {}

df_mapitems.node_name.coral_skeleton = df_dependencies.node_name_coral_skeleton
df_mapitems.node_name.water = df_dependencies.node_name_water_source
df_mapitems.node_name.mese_crystal = df_dependencies.node_name_mese_crystal
df_mapitems.node_name.cobble = df_dependencies.node_name_cobble
df_mapitems.node_name.sand = df_dependencies.node_name_sand
df_mapitems.node_name.dirt = df_dependencies.node_name_dirt
df_mapitems.node_name.stone = df_dependencies.node_name_stone
df_mapitems.node_name.ice = df_dependencies.node_name_ice

df_mapitems.node_name.farming_soil = df_dependencies.node_name_dirt_furrowed
df_mapitems.node_name.farming_soil_wet = df_dependencies.node_name_dirt_wet

-- This stuff should only be used during initialization
minetest.after(0, function()
	df_mapitems.node_name = nil
	df_mapitems.sounds = nil
	df_mapitems.texture = nil
	df_mapitems.node_id = nil
end)