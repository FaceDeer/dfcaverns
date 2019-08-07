-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

bones_loot = {}

local dungeon_loot_path = minetest.get_modpath("dungeon_loot")
if dungeon_loot_path then
	local shuffle = function(tbl)
		for i = #tbl, 2, -1 do
			local rand = math.random(i)
			tbl[i], tbl[rand] = tbl[rand], tbl[i]
		end
		return tbl
	end

	bones_loot.get_loot = function(pos, loot_type, max_stacks)
	
		local item_list = {}
		local pos_y = pos.y
		for _, loot in ipairs(dungeon_loot.registered_loot) do
			if loot.y == nil or (pos_y >= loot.y[1] and pos_y <= loot.y[2]) then
				if loot.types == nil or table.indexof(loot.types, loot_type) ~= -1 then
					table.insert(item_list, loot)
				end
			end
		end

		shuffle(item_list)
		
		-- apply chances / randomized amounts and collect resulting items
		local items = {}
		for _, loot in ipairs(item_list) do
			if math.random() <= loot.chance then
				local itemdef = minetest.registered_items[loot.name]
				
				local amount = 1
				if loot.count ~= nil then
					amount = math.random(loot.count[1], loot.count[2])
				end
			
				if itemdef.tool_capabilities then
					for n = 1, amount do
						local wear = math.random(0.20 * 65535, 0.75 * 65535) -- 20% to 75% wear
						table.insert(items, ItemStack({name = loot.name, wear = wear}))
						max_stacks = max_stacks - 1
						if max_stacks <= 0 then break end
					end
				else
					local stack_max = itemdef.stack_max
					while amount > 0 do
						table.insert(items, ItemStack({name = loot.name, count = math.min(stack_max, amount)}))
						amount = amount - stack_max
						max_stacks = max_stacks - 1
						if max_stacks <= 0 then break end
					end
				end
			end
			if max_stacks <= 0 then break end
		end	
		return items
	end
end

bones_loot.place_bones = function(pos, loot_type, max_stacks, infotext)
	minetest.set_node(pos, {name="bones:bones", param2 = math.random(1,4)-1})
	local meta = minetest.get_meta(pos)
	if infotext == nil then
		infotext = S("Someone's old bones")
	end
	meta:set_string("infotext", infotext)
	
	if bones_loot.get_loot and loot_type and max_stacks then
		local loot = bones_loot.get_loot(pos, loot_type, max_stacks)
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
		for _, item in ipairs(loot) do
			inv:add_item("main", item)
		end
	end
end

