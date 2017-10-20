-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local register_cooking_recipes = function(prefix, item, name, returns)
	minetest.register_craftitem("dfcaverns:"..item.."_biscuit", {
		description = S("@1 Biscuit", name),
		_doc_items_longdesc = dfcaverns.doc.biscuit_desc,
		_doc_items_usagehelp = dfcaverns.doc.biscuit_usage,
		inventory_image = "dfcaverns_biscuit.png",
		on_use = minetest.item_eat(4),
		groups = {food = 4},
	})
	minetest.register_craftitem("dfcaverns:"..item.."_stew", {
		description = S("@1 Stew", name),
		_doc_items_longdesc = dfcaverns.doc.stew_desc,
		_doc_items_usagehelp = dfcaverns.doc.stew_usage,
		inventory_image = "dfcaverns_stew.png",
		on_use = minetest.item_eat(6),
		groups = {food = 6},
	})
	minetest.register_craftitem("dfcaverns:"..item.."_roast", {
		description = S("@1 Roast", name),
		_doc_items_longdesc = dfcaverns.doc.roast_desc,
		_doc_items_usagehelp = dfcaverns.doc.roast_usage,
		inventory_image = "dfcaverns_roast.png",
		on_use = minetest.item_eat(8),
		groups = {food = 8},
	})
	
	if minetest.get_modpath("simplecrafting_lib") then
		simplecrafting_lib.register("cooking", {
			input = {
				["group:dfcaverns_cookable"] = 1,
				[prefix..":"..item] = 1,
			},
			output = {
				["dfcaverns:"..item.."_biscuit"] = 1,
			},
			cooktime = 5.0,
		})
		simplecrafting_lib.register("cooking", {
			input = {
				["group:dfcaverns_cookable"] = 2,
				[prefix..":"..item] = 1,
			},
			output = {
				["dfcaverns:"..item.."_stew"] = 1,
			},
			cooktime = 10.0,
		})
		simplecrafting_lib.register("cooking", {
			input = {
				["group:dfcaverns_cookable"] = 3,
				[prefix..":"..item] = 1,
			},
			output = {
				["dfcaverns:"..item.."_roast"] = 1,
			},
			cooktime = 15.0,
		})
	else
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
end

register_cooking_recipes("dfcaverns", "cave_flour", S("Cave Wheat Flour"))
register_cooking_recipes("dfcaverns", "cave_wheat_seed", S("Cave Wheat Seed"))
register_cooking_recipes("dfcaverns", "sweet_pod_seed", S("Sweet Pod Spore"))
register_cooking_recipes("dfcaverns", "sugar", S("Sweet Pod Sugar"))
register_cooking_recipes("group", "plump_helmet", S("Plump Helmet"))
register_cooking_recipes("dfcaverns", "plump_helmet_spawn", S("Plump Helmet Spawn"))
register_cooking_recipes("dfcaverns", "quarry_bush_leaves", S("Quarry Bush Leaf"))
register_cooking_recipes("dfcaverns", "quarry_bush_seed", S("Rock Nut"))
register_cooking_recipes("dfcaverns", "dimple_cup_seed", S("Dimple Cup Spore"))
register_cooking_recipes("dfcaverns", "pig_tail_seed", S("Pig Tail Spore"))
register_cooking_recipes("dfcaverns", "dwarven_syrup_bucket", S("Dwarven Syrup"), {{"dfcaverns:dwarven_syrup_bucket", "bucket:bucket_empty"}})
