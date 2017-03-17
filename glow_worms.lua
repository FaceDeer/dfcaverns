-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("dfcaverns:glow_worm", {
	description = S("Glow Worms"),
	tiles = {"dfcaverns_glow_worm.png"},
	inventory_image = "dfcaverns_glow_worm.png",
	wield_image = "dfcaverns_glow_worm.png",
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=3},
	light_source = 9,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
	},
})

local c_air = minetest.get_content_id("air")
local c_worm = minetest.get_content_id("dfcaverns:glow_worm")

dfcaverns.glow_worm_ceiling = function(area, data, ai, vi, bi)
	if data[vi] == c_air and data[bi] == c_air then
		data[vi] = c_worm
		data[bi] = c_worm
		if math.random(2) == 1 then
			local pos = area:position(vi)
			pos.y = pos.y-2
			local bbi = area:indexp(pos)
			if data[bbi] == c_air then
				data[bbi] = c_worm
				if math.random(2) == 1 then
					pos.y = pos.y-1
					local bbbi = area:indexp(pos)
					if data[bbbi] == c_air then
						data[bbbi] = c_worm
					end
				end
			end
		end
	end
end