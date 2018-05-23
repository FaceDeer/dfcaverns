-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("dfcaverns:cave_coral_3", {
	description = S("Cave Coral"),
	_doc_items_longdesc = dfcaverns.doc.cave_coral_desc,
	_doc_items_usagehelp = dfcaverns.doc.cave_coral_usage,
	tiles = {"dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral.png"},
	is_ground_content = true,
	drop = "default:coral_skeleton",
	light_source = 3,
	groups = {cracky = 3, dfcaverns_cave_coral = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dfcaverns:cave_coral_2", {
	description = S("Cave Coral"),
	_doc_items_longdesc = dfcaverns.doc.cave_coral_desc,
	_doc_items_usagehelp = dfcaverns.doc.cave_coral_usage,
	tiles = {"dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral.png"},
	is_ground_content = true,
	drop = "default:coral_skeleton",
	light_source = 2,
	groups = {cracky = 3, dfcaverns_cave_coral = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("dfcaverns:cave_coral_1", {
	description = S("Cave Coral"),
	_doc_items_longdesc = dfcaverns.doc.cave_coral_desc,
	_doc_items_usagehelp = dfcaverns.doc.cave_coral_usage,
	tiles = {"dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral_end.png", "dfcaverns_cave_coral.png"},
	is_ground_content = true,
	drop = "default:coral_skeleton",
	light_source = 1,
	groups = {cracky = 3, dfcaverns_cave_coral = 1},
	sounds = default.node_sound_stone_defaults(),
})

local coral_names = {"dfcaverns:cave_coral_1", "dfcaverns:cave_coral_2", "dfcaverns:cave_coral_3"}
minetest.register_abm{
	label = "dfcaverns:shifting_coral",
	nodenames = {"group:dfcaverns_cave_coral"},
	interval = 2,
	chance = 10,
	action = function(pos)
		minetest.swap_node(pos, {name=coral_names[math.random(1,3)]})
	end,
}

local c_coral_1 = minetest.get_content_id("dfcaverns:cave_coral_1")
local c_coral_2 = minetest.get_content_id("dfcaverns:cave_coral_2")
local c_coral_3 = minetest.get_content_id("dfcaverns:cave_coral_3")
local c_coral_skeleton = minetest.get_content_id("default:coral_skeleton")
local c_dirt = minetest.get_content_id("default:dirt")
local c_stone = minetest.get_content_id("default:stone")

local corals = {c_coral_1, c_coral_2, c_coral_3}
local get_coral = function()
	return corals[math.random(1,3)]
end

dfcaverns.spawn_cave_coral = function(area, data, vi, iterations)
	local run = math.random(2,4)
	local index = vi
	local zstride = area.zstride
	local ystride = area.ystride
	while run > 0 do
		if math.random() > 0.95 or data[index] == c_stone or not area:containsi(index) then return end
		data[index] = get_coral()
		if iterations > 2 then
			data[index + 1] = get_coral()
			data[index - 1] = get_coral()
			data[index + zstride] = get_coral()
			data[index - zstride] = get_coral()
		end
		if iterations > 3 then
			data[index + 2] = get_coral()
			data[index - 2] = get_coral()
			data[index + zstride * 2] = get_coral()
			data[index - zstride * 2] = get_coral()
			data[index + 1 + zstride] = get_coral()
			data[index - 1 + zstride] = get_coral()
			data[index + 1 - zstride] = get_coral()
			data[index - 1 - zstride] = get_coral()
		end
		index = index - ystride
		run = run - 1
	end

	local newiterations = iterations - 1
	if newiterations == 0 then return end
	
	if math.random() > 0.5 then
		dfcaverns.spawn_cave_coral(area, data, index + 1 + ystride, newiterations)
		dfcaverns.spawn_cave_coral(area, data, index - 1 + ystride, newiterations)
	else
		dfcaverns.spawn_cave_coral(area, data, index + zstride + ystride, newiterations)
		dfcaverns.spawn_cave_coral(area, data, index - zstride + ystride, newiterations)
	end
end

dfcaverns.spawn_coral_pile = function(area, data, vi, radius)
	local pos = area:position(vi)
	for li in area:iterp(vector.add(pos, -radius), vector.add(pos, radius)) do
		local adjacent = li + area.ystride
		local node_type = data[li]
		if math.random() < 0.2  and (node_type == c_stone or node_type == c_dirt) and data[adjacent] == c_water then
			data[adjacent] = c_coral_skeleton
		end
	end
end
