df_underworld_items.abm_neighbors = {}

-- common nodes that can be found next to pit plasma, triggering matter degradation
-- don't trigger on air, that's for sparkle generation
df_underworld_items.abm_neighbors.pit_plasma = {"group:stone", "df_underworld_items:glow_amethyst", "group:lava", "group:water"}

df_underworld_items.sounds = {}
df_underworld_items.sounds.glass = df_dependencies.sound_glass

df_underworld_items.sounds.stone = df_dependencies.sound_stone
df_underworld_items.sounds.slade = df_dependencies.sound_stone({ footstep = { name = "bedrock2_step", gain = 1 } })
df_underworld_items.sounds.slade_gravel = df_dependencies.sound_gravel({footstep = {name = df_dependencies.soundfile_gravel_footstep, gain = 0.45},})

df_underworld_items.nodes = {}
df_underworld_items.nodes.lava_source = df_dependencies.node_name_lava_source
df_underworld_items.nodes.meselamp = df_dependencies.node_name_meselamp

-- This stuff should only be used during initialization
minetest.after(0, function()
	df_underworld_items.abm_neighbors = nil
	df_underworld_items.sounds = nil
	df_underworld_items.nodes = nil
end)