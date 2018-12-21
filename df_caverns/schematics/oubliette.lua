local n1 = { name = "df_mapitems:slade_block" }
local n2 = { name = "stairs:stair_outer_slade_brick", param2 = 1 }
local n3 = { name = "stairs:stair_slade_brick" }
local n4 = { name = "stairs:stair_outer_slade_brick" }
local n5 = { name = "air" }
local n6 = { name = "df_mapitems:slade_seal" }
local n7 = { name = "stairs:stair_slade_brick", param2 = 1 }
local n8 = { name = "stairs:stair_slade_brick", param2 = 3 }
local n9 = { name = "stairs:stair_outer_slade_brick", param2 = 2 }
local n10 = { name = "stairs:stair_slade_brick", param2 = 2 }
local n11 = { name = "stairs:stair_outer_slade_brick", param2 = 3 }

return {
	name="df_caverns:oubliette",
	size = {
		y = 9,
		x = 3,
		z = 3
	},
	data = {
		n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		n1, n1, n1, n1, n1, n1, n1, n2, n3, n4, n1, n1, n1, n1, n5, n1, n1, 
		n5, n1, n1, n5, n1, n1, n5, n1, n1, n5, n1, n1, n5, n1, n1, n6, n1, 
		n7, n5, n8, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
		n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n9, n10, n11, 
	},
}
