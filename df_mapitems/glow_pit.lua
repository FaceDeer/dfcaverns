-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("df_mapitems:pit_plasma", {
	description = S("Glowing Pit Plasma"),
	tiles = {
		{
			name = "dfcaverns_pit_plasma.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 0.5,
			},
		},
	},
	
	groups={pit_plasma=1},
	walkable = false,
	pointable = false,
	diggable = false,
	sunlight_propagates = false,
	drop = "",
	drowning = 1,
	liquid_viscosity = 7,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 200, r = 245, g = 211, b = 251},
	drawtype="liquid",
	liquidtype="source",
	liquid_alternative_flowing = "df_mapitems:pit_plasma_flowing",
	liquid_alternative_source = "df_mapitems:pit_plasma",
	liquid_renewable = false,
	is_ground_content = true,
	light_source = minetest.LIGHT_MAX,
	paramtype = "light",
})

minetest.register_node("df_mapitems:pit_plasma_flowing", {
	description = S("Glowing Pit Plasma"),
	tiles = {"dfcaverns_pit_plasma_static.png"},
	special_tiles = {
		{
			name = "dfcaverns_pit_plasma.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 0.5,
			},
		},
		{
			name = "dfcaverns_pit_plasma.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 0.5,
			},
		},
	},
	groups={pit_plasma=1},
	walkable = false,
	pointable = false,
	diggable = false,
	sunlight_propagates = false,
	drop = "",
	drowning = 1,
	liquid_viscosity = 7,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 200, r = 245, g = 211, b = 251},
	liquidtype = "flowing",
	drawtype = "flowingliquid",
	paramtype2 = "flowingliquid",
	liquid_alternative_flowing = "df_mapitems:pit_plasma_flowing",
	liquid_alternative_source = "df_mapitems:pit_plasma",
	liquid_renewable = false,
	is_ground_content = true,
	light_source = minetest.LIGHT_MAX,
	paramtype = "light",
})


minetest.register_abm{
	label = "glowing pit sparkling",
	nodenames = {"group:pit_plasma"},
	neighbors = {"air"},
	interval = 1,
	chance = 30,
	catch_up = false,
	action = function(pos)
		local air_pos = minetest.find_node_near(pos, 1, "air")
		if air_pos then
			minetest.add_particlespawner({
				amount = 10,
				time = 1,
				minpos = {x=air_pos.x-5, y=air_pos.y-0.5, z=air_pos.z-5},
				maxpos = {x=air_pos.x+5, y=air_pos.y+0.5, z=air_pos.z+5},
				minvel = {x=-0.1, y=2, z=-0.1},
				maxvel = {x=0.1, y=2, z=0.1},
				minacc = {x=0, y=2, z=0},
				maxacc = {x=0, y=2, z=0},
				minexptime = 5,
				maxexptime = 10,
				minsize = 1,
				maxsize = 1,
				collisiondetection = true,
				collision_removal = true,
				vertical = false,
				glow = minetest.LIGHT_MAX,
				texture = "dfcaverns_glowpit_particle.png",
			})
		end		
	end,
}
