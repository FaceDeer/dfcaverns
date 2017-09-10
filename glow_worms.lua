-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("dfcaverns:glow_worm", {
	description = S("Glow Worms"),
	_doc_items_longdesc = dfcaverns.doc.glow_worms_desc,
	_doc_items_usagehelp = dfcaverns.doc.glow_worms_usage,
	tiles = {"dfcaverns_glow_worm.png"},
	inventory_image = "dfcaverns_glow_worm.png",
	wield_image = "dfcaverns_glow_worm.png",
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=3, light_sensitive_fungus = 12},
	_dfcaverns_dead_node = "air",
	light_source = 9,
	paramtype = "light",
	drawtype = "plantlike",
	walkable = false,
	buildable_to = true,
	visual_scale = 1.0,
	after_place_node = function(pos, placer) 
		if dfcaverns.config.glow_worm_delay_multiplier > 0 then
			minetest.get_node_timer(pos):start(math.random(
				dfcaverns.config.glow_worm_delay_multiplier * dfcaverns.config.plant_growth_time * 0.75,
				dfcaverns.config.glow_worm_delay_multiplier * dfcaverns.config.plant_growth_time * 1.25))
		end
	end,
	on_timer = function(pos, elapsed)
		local below = {x=pos.x, y=pos.y-1, z=pos.z}
		if minetest.get_node(below).name == "air" then
			minetest.set_node(below, {name="dfcaverns:glow_worm"})
			if math.random() > 0.5 then
				minetest.get_node_timer(below):start(math.random(
				dfcaverns.config.glow_worm_delay_multiplier * dfcaverns.config.plant_growth_time * 0.75,
				dfcaverns.config.glow_worm_delay_multiplier * dfcaverns.config.plant_growth_time * 1.25))			
			end
		end
	end,
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

minetest.register_abm({
	label = "dfcaverns:water_destroys_glow_worms",
	nodenames = {"dfcaverns:glow_worm"},
	neighbors = {"default:water_source"},
	interval = 1,
	chance = 10,
	action = function (pos)
		minetest.set_node(pos, {name="air"})
	end,	
})

