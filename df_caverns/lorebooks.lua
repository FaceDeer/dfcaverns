if not minetest.get_modpath("df_lorebooks") then return end

local foundations = {"group:stone", "group:dirt", "group:soil", "group:sand"}

minetest.register_on_generated(function(minp, maxp, blockseed)
	if maxp.y > 0 or maxp.y < df_caverns.config.primordial_min then return end

	-- using after so that all other mapgen should be finished fiddling with stuff by the time this runs
	minetest.after(1, function(minp, maxp)
		local middle = vector.divide(vector.add(minp, maxp), 2)
		if collectible_lore.are_cairns_close_to_pos(middle) then return end -- quick and dirty check to discard mapblocks close to other cairns
		local possibles = minetest.find_nodes_in_area_under_air(minp, maxp, foundations)
		if next(possibles) then
			local target = possibles[math.random(#possibles)]
			target.y=target.y+1
			collectible_lore.place_cairn(target)
		end		
	end, minp, maxp)

end)