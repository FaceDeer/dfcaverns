-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local register_cooking_recipes = function(prefix, item, name, returns)
	minetest.register_craftitem("dfcaverns:"..item.."_biscuit", {
		description = S("@1 Biscuit", name),
		inventory_image = "dfcaverns_biscuit.png",
		on_use = minetest.item_eat(4),
	})
	minetest.register_craftitem("dfcaverns:"..item.."_stew", {
		description = S("@1 Stew", name),
		inventory_image = "dfcaverns_stew.png",
		on_use = minetest.item_eat(6),
	})
	minetest.register_craftitem("dfcaverns:"..item.."_roast", {
		description = S("@1 Roast", name),
		inventory_image = "dfcaverns_roast.png",
		on_use = minetest.item_eat(8),
	})

	minetest.register_craft({
		type = "shapeless",
		output = "dfcaverns:"..item.."_biscuit",
		recipe = {"group:dfcaverns_cookable", prefix..":"..item},
		replacements = returns
	})
	minetest.register_craft({
		type = "shapeless",
		output = "dfcaverns:"..item.."_stew",
		recipe = {"group:dfcaverns_cookable", "group:dfcaverns_cookable", prefix..":"..item},
		replacements = returns
	})
	minetest.register_craft({
		type = "shapeless",
		output = "dfcaverns:"..item.."_roast",
		recipe = {"group:dfcaverns_cookable", "group:dfcaverns_cookable", "group:dfcaverns_cookable", prefix..":"..item},
		replacements = returns
	})
end

register_cooking_recipes("dfcaverns", "cave_flour", S("Cave Wheat Flour"))
register_cooking_recipes("dfcaverns", "cave_wheat_seed", S("Cave Wheat Seed"))
register_cooking_recipes("dfcaverns", "sweet_pod_seed", S("Sweet Pod Spore"))
register_cooking_recipes("dfcaverns", "sugar", S("Sweet Pod Sugar"))
register_cooking_recipes("group", "plump_helmet", S("Plump Helmet"))
register_cooking_recipes("dfcaverns", "plump_helmet_seed", S("Plump Helmet Spawn"))
register_cooking_recipes("dfcaverns", "quarry_bush_leaves", S("Quarry Bush Leaf"))
register_cooking_recipes("dfcaverns", "quarry_bush_seed", S("Rock Nut"))
register_cooking_recipes("dfcaverns", "dimple_cup_seed", S("Dimple Cup Spore"))
register_cooking_recipes("dfcaverns", "pig_tail_seed", S("Pig Tail Spore"))
register_cooking_recipes("dfcaverns", "dwarven_syrup_bucket", S("Dwarven Syrup"), {{"dfcaverns:dwarven_syrup_bucket", "bucket:bucket_empty"}})
