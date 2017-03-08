--------------------------------------------------
-- Blood thorn

-- Max trunk height 	5
-- red with purple mottling
-- High density wood
-- Depth 3

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("dfcaverns:blood_thorn", {
	description = S("Blood Thorn Trunk"),
	tiles = {"dfcaverns_blood_thorn_top.png", "dfcaverns_blood_thorn_top.png",
		"dfcaverns_blood_thorn_side.png"},
	paramtype2 = "facedir",
	groups = {choppy = 3, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
})

minetest.register_node("dfcaverns:blood_thorn_spike", {
	description = S("Blood Thorn Spike"),
	tiles = {"dfcaverns_blood_thorn_spike_side.png^[transformR90", "dfcaverns_blood_thorn_spike_side.png^[transformR270", "dfcaverns_blood_thorn_spike_side.png", "dfcaverns_blood_thorn_spike_side.png^[transformR180", "dfcaverns_blood_thorn_spike_front.png", "dfcaverns_blood_thorn_spike_front.png"},
	groups = {choppy = 3, flammable = 2, fall_damage_add_percent=100},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	climbable = true,
	damage_per_second = 1,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.1875, 0.1875, 0.1875, 0.1875, 0.5}, -- base
			{-0.125, -0.125, -0.125, 0.125, 0.125, 0.1875}, -- mid
			{-0.0625, -0.0625, -0.5, 0.0625, 0.0625, -0.125}, -- tip
		}
	},
})

local spike_directions = {{x=0,y=0,z=1}, {x=0,y=0,z=-1}, {x=1,y=0,z=0}, {x=-1,y=0,z=0}}

function dfcaverns.grow_blood_thorn(pos, node)
	if node.param2 >= 4 then
		return
	end
	pos.y = pos.y - 1
	if minetest.get_item_group(minetest.get_node(pos).name, "sand") == 0 then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	while node.name == "dfcaverns:blood_thorn" and height < 4 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height == 6 or node.name ~= "air" then
		return
	end
--	if minetest.get_node_light(pos) < 13 then
--		return
--	end
	minetest.set_node(pos, {name = "dfcaverns:blood_thorn"})
	
	local dir = spike_directions[math.random(1,4)]
	local spike_pos = vector.add(pos, dir)
	if minetest.get_node(spike_pos).name == "air" then
		local facedir = minetest.dir_to_facedir(vector.multiply(dir, -1))
		minetest.set_node(spike_pos, {name="dfcaverns:blood_thorn_spike", param2=facedir})
	end
	dir = spike_directions[math.random(1,4)]
	spike_pos = vector.add(pos, dir)
	if minetest.get_node(spike_pos).name == "air" then
		local facedir = minetest.dir_to_facedir(vector.multiply(dir, -1))
		minetest.set_node(spike_pos, {name="dfcaverns:blood_thorn_spike", param2=facedir})
	end
	return true
end

minetest.register_abm({
	label = "Grow Blood Thorn",
	nodenames = {"dfcaverns:blood_thorn"},
	catch_up = true,
	neighbors = {"group:sand"},
	interval = dfcaverns.config.blood_thorn_growth_interval,
	chance = dfcaverns.config.blood_thorn_growth_chance,
	action = function(pos, node)
		dfcaverns.grow_blood_thorn(pos, node)
	end
})

function dfcaverns.spawn_blood_thorn(pos)
	local height = math.random(3,5)
	for i = 0, height do
		if minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, {name="dfcaverns:blood_thorn"})
			
			local dir = spike_directions[math.random(1,4)]
			local spike_pos = vector.add(pos, dir)
			if minetest.get_node(spike_pos).name == "air" then
				local facedir = minetest.dir_to_facedir(vector.multiply(dir, -1))
				minetest.set_node(spike_pos, {name="dfcaverns:blood_thorn_spike", param2=facedir})
			end
			dir = spike_directions[math.random(1,4)]
			spike_pos = vector.add(pos, dir)
			if minetest.get_node(spike_pos).name == "air" then
				local facedir = minetest.dir_to_facedir(vector.multiply(dir, -1))
				minetest.set_node(spike_pos, {name="dfcaverns:blood_thorn_spike", param2=facedir})
			end
		else
			break
		end
		pos.y = pos.y + 1
	end
end
