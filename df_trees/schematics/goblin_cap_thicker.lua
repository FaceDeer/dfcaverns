local n1 = { name = "air", prob=0 }
local n2 = { name = "df_trees:goblin_cap" }
local n3 = { name = "df_trees:goblin_cap_gills", param2 = 1 }
local n4 = { name = "df_trees:goblin_cap_stem" }

return {
	yslice_prob = {},
	size = {y = 8, x = 9, z = 9},
	center_pos = {x = 4, y = 2, z = 4},
	data = {
		-- z=-8, y=-7
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-8, y=-6
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-8, y=-5
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-8, y=-4
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-8, y=-3
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-8, y=-2
		n1, n1, n1, n2, n2, n2, n1, n1, n1, 
		-- z=-8, y=-1
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-8, y=0
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 

		-- z=-7, y=-7
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-7, y=-6
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-7, y=-5
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-7, y=-4
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-7, y=-3
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-7, y=-2
		n1, n2, n2, n3, n3, n3, n2, n2, n1, 
		-- z=-7, y=-1
		n1, n1, n1, n2, n2, n2, n1, n1, n1, 
		-- z=-7, y=0
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 

		-- z=-6, y=-7
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-6, y=-6
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-6, y=-5
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-6, y=-4
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-6, y=-3
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-6, y=-2
		n1, n2, n3, n4, n4, n4, n3, n2, n1, 
		-- z=-6, y=-1
		n1, n1, n2, n2, n2, n2, n2, n1, n1, 
		-- z=-6, y=0
		n1, n1, n1, n1, n2, n1, n1, n1, n1, 

		-- z=-5, y=-7
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-5, y=-6
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-5, y=-5
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-5, y=-4
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-5, y=-3
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-5, y=-2
		n2, n3, n4, n4, n4, n4, n4, n3, n2, 
		-- z=-5, y=-1
		n1, n2, n2, n4, n4, n4, n2, n2, n1, 
		-- z=-5, y=0
		n1, n1, n1, n2, n2, n2, n1, n1, n1, 

		-- z=-4, y=-7
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-4, y=-6
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-4, y=-5
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-4, y=-4
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-4, y=-3
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-4, y=-2
		n2, n3, n4, n4, n4, n4, n4, n3, n2, 
		-- z=-4, y=-1
		n1, n2, n2, n4, n4, n4, n2, n2, n1, 
		-- z=-4, y=0
		n1, n1, n2, n2, n2, n2, n2, n1, n1, 

		-- z=-3, y=-7
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-3, y=-6
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-3, y=-5
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-3, y=-4
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-3, y=-3
		n1, n1, n4, n4, n4, n4, n4, n1, n1, 
		-- z=-3, y=-2
		n2, n3, n4, n4, n4, n4, n4, n3, n2, 
		-- z=-3, y=-1
		n1, n2, n2, n4, n4, n4, n2, n2, n1, 
		-- z=-3, y=0
		n1, n1, n1, n2, n2, n2, n1, n1, n1, 

		-- z=-2, y=-7
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-2, y=-6
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-2, y=-5
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-2, y=-4
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-2, y=-3
		n1, n1, n1, n4, n4, n4, n1, n1, n1, 
		-- z=-2, y=-2
		n1, n2, n3, n4, n4, n4, n3, n2, n1, 
		-- z=-2, y=-1
		n1, n1, n2, n2, n2, n2, n2, n1, n1, 
		-- z=-2, y=0
		n1, n1, n1, n1, n2, n1, n1, n1, n1, 

		-- z=-1, y=-7
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-1, y=-6
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-1, y=-5
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-1, y=-4
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-1, y=-3
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=-1, y=-2
		n1, n2, n2, n3, n3, n3, n2, n2, n1, 
		-- z=-1, y=-1
		n1, n1, n1, n2, n2, n2, n1, n1, n1, 
		-- z=-1, y=0
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 

		-- z=0, y=-7
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=0, y=-6
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=0, y=-5
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=0, y=-4
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=0, y=-3
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=0, y=-2
		n1, n1, n1, n2, n2, n2, n1, n1, n1, 
		-- z=0, y=-1
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		-- z=0, y=0
		n1, n1, n1, n1, n1, n1, n1, n1, n1, 
}
}
