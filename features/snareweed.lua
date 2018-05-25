-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("dfcaverns:snareweed", {
	description = S("Snareweed"),
	_doc_items_longdesc = dfcaverns.doc.snareweed_desc,
	_doc_items_usagehelp = dfcaverns.doc.snareweed_usage,
	tiles = {"default_dirt.png^dfcaverns_snareweed_roots.png", "default_dirt.png"},
	drawtype="plantlike_rooted",
	paramtype2 = "leveled",
	special_tiles = {{name = "dfcaverns_snareweed.png", tileable_vertical = true}},
	is_ground_content = true,
	drop = 'default:dirt',
	light_source = 6,
	groups = {crumbly = 3, soil = 1},
	sounds = default.node_sound_dirt_defaults(),
})

if minetest.get_modpath("radiant_damage") then
	radiant_damage.register_radiant_damage({
		damage_name = "snareweed", -- a string used in logs to identify the type of damage dealt
		interval = 1, -- number of seconds between each damage check
		range = 5, -- range of the damage. Can be omitted if inverse_square_falloff is true, in that case it defaults to the range at which 1 point of damage is done.
		inverse_square_falloff = false, -- if true, damage falls off with the inverse square of the distance. If false, damage is constant within the range.
		damage = 2, -- number of damage points dealt each interval
		nodenames = {"dfcaverns:snareweed"}, -- nodes that cause this damage. Same format as the nodenames parameter for minetest.find_nodes_in_area
		occlusion = false, -- if true, damaging effect only passes through air. Other nodes will cast "shadows".
		above_only = true, -- if true, damage only propagates directly upward.
		cumulative = false, -- if true, all nodes within range do damage. If false, only the nearest one does damage.
	})
end


local c_water = minetest.get_content_id("default:water_source")
local c_dirt = minetest.get_content_id("default:dirt")
local c_snareweed = minetest.get_content_id("dfcaverns:snareweed")

dfcaverns.place_snareweed = function(area, data, bi, param2_data)
	local max_height = 0
	local index = bi + area.ystride
	while area:containsi(index) and data[index] == c_water and max_height <= 8*16 do
		index = index + area.ystride
		max_height = max_height + 16
	end
	if max_height > 0 then
		data[bi] = c_snareweed
		param2_data[bi] = math.min(math.random(3*16, 8*16), max_height)
	else
		data[bi] = c_dirt
	end
end

dfcaverns.place_snareweed_patch = function(area, data, bi, param2_data, radius)
	local pos = area:position(bi)	
	for li in area:iterp(vector.add(pos, -radius), vector.add(pos, radius)) do
		local adjacent = li + area.ystride
		local node_type = data[li]
		if math.random() < 0.1  and (node_type == c_stone or node_type == c_dirt) and data[adjacent] == c_water then
			dfcaverns.place_snareweed(area, data, li, param2_data)
		end
	end
end