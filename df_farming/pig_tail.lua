local S = minetest.get_translator(minetest.get_current_modname())

local pig_tail_grow_time = df_farming.config.plant_growth_time * df_farming.config.pig_tail_delay_multiplier / 8

local register_pig_tail = function(number)
	local name = "df_farming:pig_tail_"..tostring(number)
	local def = {
		description = S("Pig Tail"),
		_doc_items_longdesc = df_farming.doc.pig_tail_desc,
		_doc_items_usagehelp = df_farming.doc.pig_tail_usage,
		drawtype = "plantlike",
		paramtype2 = "meshoptions",
		place_param2 = 3,
		tiles = {"dfcaverns_pig_tail_"..tostring(number)..".png"},
		inventory_image = "dfcaverns_pig_tail_"..tostring(number)..".png",
		paramtype = "light",
		walkable = false,
		is_ground_content = false,
		floodable = true,
		buildable_to = true,
		groups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1, light_sensitive_fungus = 11, fire_encouragement=60,fire_flammability=100, compostability=70, handy=1,shearsy=1,hoey=1, destroy_by_lava_flow=1,dig_by_piston=1},
		sounds = df_dependencies.sound_leaves(),
        selection_box = {
            type = "fixed",
            fixed = {
                {-8/16, -8/16, -8/16, 8/16, -8/16 + 2*number/16, 8/16},
            },
        },

		on_timer = function(pos, elapsed)
			df_farming.grow_underground_plant(pos, name, elapsed)
		end,

		drop = {
			max_items = 1,
			items = {
				{
					items = {'df_farming:pig_tail_seed 2', 'df_farming:pig_tail_thread 3'},
					rarity = 9-number,
				},
				{
					items = {'df_farming:pig_tail_seed 1', 'df_farming:pig_tail_thread 2'},
					rarity = 9-number,
				},
				{
					items = {'df_farming:pig_tail_seed'},
					rarity = 9-number,
				},
			},
		},
		_mcl_blast_resistance = 0.2,
		_mcl_hardness = 0.2,
	}

	if number < 8 then
		def._dfcaverns_next_stage_time = pig_tail_grow_time
		def._dfcaverns_next_stage = "df_farming:pig_tail_"..tostring(number+1)
	end

	minetest.register_node(name, def)
end

for i = 1,8 do
	register_pig_tail(i)
end

local place_list = {
	minetest.get_content_id("df_farming:pig_tail_1"),
	minetest.get_content_id("df_farming:pig_tail_2"),
	minetest.get_content_id("df_farming:pig_tail_3"),
	minetest.get_content_id("df_farming:pig_tail_4"),
	minetest.get_content_id("df_farming:pig_tail_5"),
	minetest.get_content_id("df_farming:pig_tail_6"),
	minetest.get_content_id("df_farming:pig_tail_7"),
	minetest.get_content_id("df_farming:pig_tail_8"),
}
-- doesn't set the timer running, so plants placed by this method won't grow
df_farming.spawn_pig_tail_vm = function(vi, area, data, param2_data)
	data[vi] = place_list[math.random(1,8)]
	param2_data[vi] = 3
end

df_farming.register_seed(
	"pig_tail_seed",
	S("Pig Tail Spore"),
	"dfcaverns_pig_tail_seed.png",
	"df_farming:pig_tail_1",
	pig_tail_grow_time,
	df_farming.doc.pig_tail_desc,
	df_farming.doc.pig_tail_usage)

minetest.register_craftitem("df_farming:pig_tail_thread", {
	description = S("Pig tail thread"),
	_doc_items_longdesc = df_farming.doc.pig_tail_thread_desc,
	_doc_items_usagehelp = df_farming.doc.pig_tail_thread_usage,
	inventory_image = "dfcaverns_pig_tail_thread.png",
	groups = {flammable = 1, thread = 1},
})

if df_dependencies.node_name_wool_white then
	minetest.register_craft({
		output = df_dependencies.node_name_wool_white,
		recipe = {
			{"group:thread", "group:thread"},
			{"group:thread", "group:thread"},
		}
	})
end
if df_dependencies.node_name_string then
	minetest.register_craft({
		output = df_dependencies.node_name_string .. " 2",
		recipe = {
			{"group:thread"},
			{"group:thread"},
		}
	})
end

minetest.register_craft({
	type = "fuel",
	recipe = "df_farming:pig_tail_thread",
	burntime = 1,
})

if minetest.get_modpath("footprints") then
	minetest.register_node("df_farming:pig_tail_trampled", {
		description = S("Flattened Pig Tail"),
		tiles = {"dfcaverns_pig_tail_flattened.png"},
		inventory_image = "dfcaverns_pig_tail_flattened.png",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		buildable_to = true,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -3 / 8, 0.5}
			},
		},
		groups = {snappy = 3, flammable = 2, attached_node = 1, handy=1, hoey=1, compostability=85, fire_encouragement=60, fire_flammability=20, fall_damage_add_percent=-30, destroy_by_lava_flow=1,dig_by_piston=1},
		drop = "",
		sounds = df_dependencies.sound_leaves(),
		_mcl_blast_resistance = 0.2,
		_mcl_hardness = 0.2,
	})

	footprints.register_trample_node("df_farming:pig_tail_5", {
		trampled_node_name = "df_farming:pig_tail_trampled",
		randomize_trampled_param2 = true,
	})
	footprints.register_trample_node("df_farming:pig_tail_6", {
		trampled_node_name = "df_farming:pig_tail_trampled",
		randomize_trampled_param2 = true,
	})
	footprints.register_trample_node("df_farming:pig_tail_7", {
		trampled_node_name = "df_farming:pig_tail_trampled",
		randomize_trampled_param2 = true,
	})
	footprints.register_trample_node("df_farming:pig_tail_8", {
		trampled_node_name = "df_farming:pig_tail_trampled",
		randomize_trampled_param2 = true,
	})
end