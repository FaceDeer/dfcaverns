-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local register_cooking_recipes = function(def)
	local prefix = def.prefix
	local item = def.item
	local replacements = def.replacements
	minetest.register_craftitem("df_farming:"..item.."_simple_meal", {
		description = def.simple.name,
		_doc_items_longdesc = df_farming.doc.simple_meal_desc,
		_doc_items_usagehelp = df_farming.doc.simple_meal_usage,
		inventory_image = def.simple.image,
		on_use = minetest.item_eat(4),
		groups = {food = 4},
	})
	minetest.register_craftitem("df_farming:"..item.."_medium_meal", {
		description = def.medium.name,
		_doc_items_longdesc = df_farming.doc.medium_meal_desc,
		_doc_items_usagehelp = df_farming.doc.medium_meal_usage,
		inventory_image = def.medium.image,
		on_use = minetest.item_eat(6),
		groups = {food = 6},
	})
	minetest.register_craftitem("df_farming:"..item.."_complex_meal", {
		description = def.complex.name,
		_doc_items_longdesc = df_farming.doc.complex_meal_desc,
		_doc_items_usagehelp = df_farming.doc.complex_meal_usage,
		inventory_image = def.complex.image,
		on_use = minetest.item_eat(8),
		groups = {food = 8},
	})
	
	minetest.register_alias("dfcaverns:"..item.."_biscuit", "df_farming:"..item.."_simple_meal")
	minetest.register_alias("dfcaverns:"..item.."_stew", "df_farming:"..item.."_medium_meal")
	minetest.register_alias("dfcaverns:"..item.."_roast", "df_farming:"..item.."_complex_meal")
	minetest.register_alias("df_farming:"..item.."_biscuit", "df_farming:"..item.."_simple_meal")
	minetest.register_alias("df_farming:"..item.."_stew", "df_farming:"..item.."_medium_meal")
	minetest.register_alias("df_farming:"..item.."_roast", "df_farming:"..item.."_complex_meal")
	
	minetest.register_craft({
		type = "shapeless",
		output = "df_farming:"..item.."_simple_meal",
		recipe = {"group:dfcaverns_cookable", prefix..":"..item},
		replacements = replacements
	})
	minetest.register_craft({
		type = "shapeless",
		output = "df_farming:"..item.."_medium_meal",
		recipe = {"group:dfcaverns_cookable", "group:dfcaverns_cookable", prefix..":"..item},
		replacements = replacements
	})
	minetest.register_craft({
		type = "shapeless",
		output = "df_farming:"..item.."_complex_meal",
		recipe = {"group:dfcaverns_cookable", "group:dfcaverns_cookable", "group:dfcaverns_cookable", prefix..":"..item},
		replacements = replacements
	})
end


--{
--	prefix =,
--	item =,
--	replacements =,
--	simple = {name = , image = },
--	medium = {name = , image = },
--	complex = {name = , image = },
--}

register_cooking_recipes({prefix="df_farming", item="cave_flour",
	simple =  {name=S("Cave Wheat Flour Biscuit"), image="dfcaverns_prepared_food08x16.png"},
	medium =  {name=S("Cave Wheat Flour Bun"), image="dfcaverns_prepared_food11x16.png"},
	complex = {name=S("Cave Wheat Flour Pancake"), image="dfcaverns_prepared_food07x16.png"},
})
register_cooking_recipes({prefix="df_farming", item="cave_wheat_seed",
	simple =  {name=S("Cave Wheat Seed Loaf"), image="dfcaverns_prepared_food17x16.png"},
	medium =  {name=S("Cave Wheat Seed Puffs"), image="dfcaverns_prepared_food33x16.png"},
	complex = {name=S("Cave Wheat Seed Risotto"), image="dfcaverns_prepared_food14x16.png"},
})
register_cooking_recipes({prefix="df_farming", item="sweet_pod_seed",
	simple =  {name=S("Sweet Pod Spore Dumplings"), image="dfcaverns_prepared_food09x16.png"},
	medium =  {name=S("Sweet Pod Spore Single Crust Pie"), image="dfcaverns_prepared_food05x16.png"},
	complex = {name=S("Sweet Pod Spore Brule"), image="dfcaverns_prepared_food22x16.png"},
})
register_cooking_recipes({prefix="df_farming", item="sugar",
	simple =  {name=S("Sweet Pod Sugar Cookie"), image="dfcaverns_prepared_food02x16.png"},
	medium =  {name=S("Sweet Pod Sugar Gingerbread"), image="dfcaverns_prepared_food21x16.png"},
	complex = {name=S("Sweet Pod Sugar Roll"), image="dfcaverns_prepared_food25x16.png"},
})
register_cooking_recipes({prefix="group", item="plump_helmet",
	simple =  {name=S("Plump Helmet Mince"), image="dfcaverns_prepared_food15x16.png"},
	medium =  {name=S("Plump Helmet Stalk Sausage"), image="dfcaverns_prepared_food18x16.png"},
	complex = {name=S("Plump Helmet Roast"), image="dfcaverns_prepared_food04x16.png"},
})
register_cooking_recipes({prefix="df_farming", item="plump_helmet_spawn",
	simple =  {name=S("Plump Helmet Spawn Soup"), image="dfcaverns_prepared_food10x16.png"},
	medium =  {name=S("Plump Helmet Spawn Jambalaya"), image="dfcaverns_prepared_food01x16.png"},
	complex = {name=S("Plump Helmet Sprout Stew"), image="dfcaverns_prepared_food26x16.png"},
})
register_cooking_recipes({prefix="df_farming", item="quarry_bush_leaves",
	simple =  {name=S("Quarry Bush Leaf Spicy Bun"), image="dfcaverns_prepared_food23x16.png"},
	medium =  {name=S("Quarry Bush Leaf Croissant"), image="dfcaverns_prepared_food29x16.png"},
	complex = {name=S("Stuffed Quarry Bush Leaf"), image="dfcaverns_prepared_food27x16.png"},
})
register_cooking_recipes({prefix="df_farming", item="quarry_bush_seed",
	simple =  {name=S("Rock Nut Bread"), image="dfcaverns_prepared_food16x16.png"},
	medium =  {name=S("Rock Nut Cookie"), image="dfcaverns_prepared_food07x16.png"},
	complex = {name=S("Rock Nut Cake"), image="dfcaverns_prepared_food03x16.png"},
})
register_cooking_recipes({prefix="df_farming", item="dimple_cup_seed",
	simple =  {name=S("Dimple Cup Spore Flatbread"), image="dfcaverns_prepared_food12x16.png"},
	medium =  {name=S("Dimple Cup Spore Scone"), image="dfcaverns_prepared_food32x16.png"},
	complex = {name=S("Dimple Cup Spore Roll"), image="dfcaverns_prepared_food31x16.png"},
})
register_cooking_recipes({prefix="df_farming", item="pig_tail_seed",
	simple =  {name=S("Pig Tail Spore Sandwich"), image="dfcaverns_prepared_food20x16.png"},
	medium = {name=S("Pig Tail Spore Tofu"), image="dfcaverns_prepared_food30x16.png"},
	complex =  {name=S("Pig Tail Spore Casserole"), image="dfcaverns_prepared_food34x16.png"},
})
register_cooking_recipes({prefix="df_farming", item="dwarven_syrup_bucket", replacements={{"df_farming:dwarven_syrup_bucket", "bucket:bucket_empty"}},
	simple =  {name=S("Dwarven Syrup Taffy"), image="dfcaverns_prepared_food19x16.png"},
	medium =  {name=S("Dwarven Syrup Jellies"), image="dfcaverns_prepared_food06x16.png"},
	complex = {name=S("Dwarven Syrup Delight"), image="dfcaverns_prepared_food24x16.png"},
})

-- dfcaverns_prepared_food28 is currently unused
-- dfcaverns_prepared_food13 is used for dwarven bread