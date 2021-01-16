df_underworld_items.abm_neighbors = {}

-- common nodes that can be found next to pit plasma, triggering matter degradation
-- don't trigger on air, that's for sparkle generation
df_underworld_items.abm_neighbors.pit_plasma = {"group:stone", "df_underworld_items:glow_amethyst", "group:lava", "group:water"}

-- This stuff should only be used during initialization
minetest.after(0, function()
	df_underworld_items.node_name = nil
end)