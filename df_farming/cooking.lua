-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local register_cooking_recipes = function(prefix, item, name, returns)
	minetest.register_craftitem("df_farming:"..item.."_biscuit", {
		description = S("@1 Biscuit", name),
		_doc_items_longdesc = df_farming.doc.biscuit_desc,
		_doc_items_usagehelp = df_farming.doc.biscuit_usage,
		inventory_image = "dfcaverns_biscuit.png",
		on_use = minetest.item_eat(4),
		groups = {food = 4},
	})
	minetest.register_craftitem("df_farming:"..item.."_stew", {
		description = S("@1 Stew", name),
		_doc_items_longdesc = df_farming.doc.stew_desc,
		_doc_items_usagehelp = df_farming.doc.stew_usage,
		inventory_image = "dfcaverns_stew.png",
		on_use = minetest.item_eat(6),
		groups = {food = 6},
	})
	minetest.register_craftitem("df_farming:"..item.."_roast", {
		description = S("@1 Roast", name),
		_doc_items_longdesc = df_farming.doc.roast_desc,
		_doc_items_usagehelp = df_farming.doc.roast_usage,
		inventory_image = "dfcaverns_roast.png",
		on_use = minetest.item_eat(8),
		groups = {food = 8},
	})
	
	minetest.register_alias("dfcaverns:"..item.."_biscuit", "df_farming:"..item.."_biscuit")
	minetest.register_alias("dfcaverns:"..item.."_stew", "df_farming:"..item.."_stew")
	minetest.register_alias("dfcaverns:"..item.."_roast", "df_farming:"..item.."_roast")
	
	if minetest.get_modpath("simplecrafting_lib") then
		simplecrafting_lib.register("cooking", {
			input = {
				["group:dfcaverns_cookable"] = 1,
				[prefix..":"..item] = 1,
			},
			output = {
				["df_farming:"..item.."_biscuit"] = 1,
			},
			cooktime = 5.0,
		})
		simplecrafting_lib.register("cooking", {
			input = {
				["group:dfcaverns_cookable"] = 2,
				[prefix..":"..item] = 1,
			},
			output = {
				["df_farming:"..item.."_stew"] = 1,
			},
			cooktime = 10.0,
		})
		simplecrafting_lib.register("cooking", {
			input = {
				["group:dfcaverns_cookable"] = 3,
				[prefix..":"..item] = 1,
			},
			output = {
				["df_farming:"..item.."_roast"] = 1,
			},
			cooktime = 15.0,
		})
	else
		minetest.register_craft({
			type = "shapeless",
			output = "df_farming:"..item.."_biscuit",
			recipe = {"group:dfcaverns_cookable", prefix..":"..item},
			replacements = returns
		})
		minetest.register_craft({
			type = "shapeless",
			output = "df_farming:"..item.."_stew",
			recipe = {"group:dfcaverns_cookable", "group:dfcaverns_cookable", prefix..":"..item},
			replacements = returns
		})
		minetest.register_craft({
			type = "shapeless",
			output = "df_farming:"..item.."_roast",
			recipe = {"group:dfcaverns_cookable", "group:dfcaverns_cookable", "group:dfcaverns_cookable", prefix..":"..item},
			replacements = returns
		})
	end
end

register_cooking_recipes("df_farming", "cave_flour", S("Cave Wheat Flour"))
register_cooking_recipes("df_farming", "cave_wheat_seed", S("Cave Wheat Seed"))
register_cooking_recipes("df_farming", "sweet_pod_seed", S("Sweet Pod Spore"))
register_cooking_recipes("df_farming", "sugar", S("Sweet Pod Sugar"))
register_cooking_recipes("group", "plump_helmet", S("Plump Helmet"))
register_cooking_recipes("df_farming", "plump_helmet_spawn", S("Plump Helmet Spawn"))
register_cooking_recipes("df_farming", "quarry_bush_leaves", S("Quarry Bush Leaf"))
register_cooking_recipes("df_farming", "quarry_bush_seed", S("Rock Nut"))
register_cooking_recipes("df_farming", "dimple_cup_seed", S("Dimple Cup Spore"))
register_cooking_recipes("df_farming", "pig_tail_seed", S("Pig Tail Spore"))
register_cooking_recipes("df_farming", "dwarven_syrup_bucket", S("Dwarven Syrup"), {{"df_farming:dwarven_syrup_bucket", "bucket:bucket_empty"}})
