local n1 = { name = "air", prob = 0 } -- external air
local n2 = { name = "stairs:stair_goblin_cap_stem_wood" }
local n3 = { name = "air", force_place=true } -- internal air
local n4 = { name = "df_trees:goblin_cap" }
local n5 = { name = "df_trees:goblin_cap_stem_wood" } -- porch filler
local n6 = { name = "df_trees:goblin_cap_gills", param2 = 1 }
local n7 = { name = "df_trees:goblin_cap_stem", force_place=true  }
local n8 = { name = "df_trees:goblin_cap_stem_wood", force_place=true } -- internal floor
local n9 = { name = "doors:door_wood_a", force_place=true  }
local n10 = { name = "doors:hidden", force_place=true  }
local n11 = { name = "beds:bed_bottom", force_place=true  }
local n12 = { name = "df_trees:goblin_cap_stem", prob = 198, force_place=true } -- possible window holes
local n13 = { name = "default:chest", force_place=true  }
local n14 = { name = "beds:bed_top", force_place=true  }
local n15 = { name = "default:torch_wall", param2 = 4, force_place=true}
local n16 = { name = "df_trees:goblin_cap_stem" } -- ground filler
local n17 = { name = "df_trees:goblin_cap_wood", force_place=true } -- internal ceiling

if minetest.get_modpath("vessels") then
	n15 = { name = "df_trees:glowing_bottle_red", force_place=true}
end

if not minetest.get_modpath("doors") then
	-- replace the door with air
	n9 = n3
	n10 = n3
end
if not minetest.get_modpath("beds") then
	--replace the bed with air
	n11 = n3
	n14 = n3
end

return {
	yslice_prob = {	},
	size = {y = 8, x = 9, z = 9},
	center_pos = {x = 4, y = 2, z = 4},
	data = {
		-- z=0, y=0
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=0, y=1
		n1, n1, n1, n1, n2, n1, n1, n1, n1, 
		-- z=0, y=2
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=0, y=3
		n1, n1, n1, n1, n3, n1, n1, n1, n1, 
		-- z=0, y=4
		n1, n1, n1, n1, n3, n1, n1, n1, n1, 
		-- z=0, y=5
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=0, y=6
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=0, y=7
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 

		-- z=1, y=0
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=1, y=1
		n1, n1, n1, n1, n5, n1, n1, n1, n1, 
		-- z=1, y=2
		n1, n1, n1, n1, n2, n1, n1, n1, n1, 
		-- z=1, y=3
		n1, n1, n1, n1, n3, n1, n1, n1, n1, 
		-- z=1, y=4
		n1, n1, n1, n1, n3, n1, n1, n1, n1, 
		-- z=1, y=5
		n1, n4, n4, n6, n6, n6, n4, n4, n1, 
		-- z=1, y=6
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=1, y=7
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 

		-- z=2, y=0
		n1, n1, n1, n16, n16, n16, n1, n1, n1, 
		-- z=2, y=1
		n1, n1, n1, n16, n16, n16, n1, n1, n1, 
		-- z=2, y=2
		n1, n1, n1, n7, n8, n7, n1, n1, n1, 
		-- z=2, y=3
		n1, n1, n1, n7, n9, n7, n1, n1, n1, 
		-- z=2, y=4
		n1, n1, n1, n7, n10, n7, n1, n1, n1, 
		-- z=2, y=5
		n1, n4, n6, n7, n7, n7, n6, n4, n1, 
		-- z=2, y=6
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=2, y=7
		n1, n1, n1, n1, n4, n1, n1, n1, n1, 

		-- z=3, y=0
		n1, n1, n16, n16, n16, n16, n16, n1, n1, 
		-- z=3, y=1
		n1, n1, n16, n16, n16, n16, n16, n1, n1, 
		-- z=3, y=2
		n1, n1, n7, n8, n8, n8, n7, n1, n1, 
		-- z=3, y=3
		n1, n1, n7, n3, n3, n3, n7, n1, n1, 
		-- z=3, y=4
		n1, n1, n7, n3, n3, n3, n7, n1, n1, 
		-- z=3, y=5
		n4, n6, n7, n3, n3, n3, n7, n6, n4, 
		-- z=3, y=6
		n1, n4, n4, n17, n17, n17, n4, n4, n1, 
		-- z=3, y=7
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 

		-- z=4, y=0
		n1, n1, n16, n16, n16, n16, n16, n1, n1, 
		-- z=4, y=1
		n1, n1, n16, n16, n16, n16, n16, n1, n1, 
		-- z=4, y=2
		n1, n1, n7, n8, n8, n8, n7, n1, n1, 
		-- z=4, y=3
		n1, n1, n7, n3, n3, n11, n7, n1, n1, 
		-- z=4, y=4
		n1, n1, n12, n3, n3, n3, n12, n1, n1, 
		-- z=4, y=5
		n4, n6, n7, n3, n3, n3, n7, n6, n4, 
		-- z=4, y=6
		n1, n4, n4, n17, n17, n17, n4, n4, n1, 
		-- z=4, y=7
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 

		-- z=5, y=0
		n1, n1, n16, n16, n16, n16, n16, n1, n1, 
		-- z=5, y=1
		n1, n1, n16, n16, n16, n16, n16, n1, n1, 
		-- z=5, y=2
		n1, n1, n7, n8, n8, n8, n7, n1, n1, 
		-- z=5, y=3
		n1, n1, n7, n13, n3, n14, n7, n1, n1, 
		-- z=5, y=4
		n1, n1, n7, n15, n3, n3, n7, n1, n1, 
		-- z=5, y=5
		n4, n6, n7, n3, n3, n3, n7, n6, n4, 
		-- z=5, y=6
		n1, n4, n4, n17, n17, n17, n4, n4, n1, 
		-- z=5, y=7
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 

		-- z=6, y=0
		n1, n1, n1, n16, n16, n16, n1, n1, n1, 
		-- z=6, y=1
		n1, n1, n1, n16, n16, n16, n1, n1, n1, 
		-- z=6, y=2
		n1, n1, n1, n7, n7, n7, n1, n1, n1, 
		-- z=6, y=3
		n1, n1, n1, n7, n7, n7, n1, n1, n1, 
		-- z=6, y=4
		n1, n1, n1, n7, n12, n7, n1, n1, n1, 
		-- z=6, y=5
		n1, n4, n6, n7, n7, n7, n6, n4, n1, 
		-- z=6, y=6
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=6, y=7
		n1, n1, n1, n1, n4, n1, n1, n1, n1, 

		-- z=7, y=0
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=7, y=1
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=7, y=2
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=7, y=3
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=7, y=4
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=7, y=5
		n1, n4, n4, n6, n6, n6, n4, n4, n1, 
		-- z=7, y=6
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=7, y=7
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 

		-- z=8, y=0
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=8, y=1
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=8, y=2
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=8, y=3
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=8, y=4
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=8, y=5
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=8, y=6
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=8, y=7
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
}
}
