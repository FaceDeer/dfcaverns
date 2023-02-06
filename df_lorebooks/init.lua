local modpath = minetest.get_modpath(minetest.get_current_modname())

df_lorebooks = {}

local S = minetest.get_translator(minetest.get_current_modname())

-- Splits strings into chunks that are approximately length long, dividing at the nearest pattern to the first length mark.
function splitString(str, length, splitmark)
    if #str <= length then
        return str
    else
        local split_index = string.find(str, splitmark, 1, true)
        local closest_index = split_index or math.huge
        while split_index do
            if math.abs(split_index - length) < math.abs(closest_index - length) then
                closest_index = split_index
            end
            split_index = string.find(str, splitmark, split_index + 2, true)
        end
        if closest_index == math.huge then
            return str
        else
            local str1 = string.sub(str, 1, closest_index)
            local str2 = string.sub(str, closest_index + 2)
            return str1, str2
        end
    end
end


local lorebooks = {}


df_lorebooks.register_lorebook = function(def)

	if lorebooks[def.title] then
		minetest.debug("duplicate title " .. def.title)
	end
	lorebooks[def.title] = def

--	minetest.register_craftitem(def.title, {
--		description = def.desc,
--		inventory_image = def.inv_img,
--		groups = {book = 1},
--	on_use = function(itemstack, user, pointed_thing)
--		lorebooks.read_book(user, def.title, def.desc, def.text, def.text2, def.author, def.date)
--		return
--	end
--	})
--
--	minetest.register_craft({
--		type = "shapeless",
--		output = def.title .. " 2",
--		recipe = {def.title, "default:book"}
--	})
end

dofile(modpath.."/ecology_sunless_sea.lua")
dofile(modpath.."/ecology_flora.lua")
dofile(modpath.."/ecology_trees.lua")
dofile(modpath.."/fauna_ice_sprites.lua")
dofile(modpath.."/geology_the_great_caverns.lua")
dofile(modpath.."/introductions.lua")
dofile(modpath.."/underworld_and_primordial.lua")

for title, lorebook in pairs(lorebooks) do
	if lorebook.text == "\27(T@df_lorebooks)\27E" then
		minetest.debug("empty text for " .. title)
	end
end
