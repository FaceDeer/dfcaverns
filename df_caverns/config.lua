local CONFIG_FILE_PREFIX = "dfcaverns_"

df_caverns.config = {}

local print_settingtypes = false

local function setting(stype, name, default, description)
	local value
	if stype == "bool" then
		value = minetest.setting_getbool(CONFIG_FILE_PREFIX..name)
	elseif stype == "string" then
		value = minetest.setting_get(CONFIG_FILE_PREFIX..name)
	elseif stype == "int" or stype == "float" then
		value = tonumber(minetest.setting_get(CONFIG_FILE_PREFIX..name))
	end
	if value == nil then
		value = default
	end
	df_caverns.config[name] = value
	
	if print_settingtypes then
		minetest.debug(CONFIG_FILE_PREFIX..name.." ("..description..") "..stype.." "..tostring(default))
	end	
end

--Caverns

setting("float", "vertical_cavern_scale", 256, "Vertical cavern dimension scale")
setting("float", "horizontal_cavern_scale", 256, "Horizontal cavern dimension scale")
setting("float", "cavern_threshold", 0.5, "Cavern threshold")

setting("int", "ymax", -300, "Upper limit of level 1")
setting("int", "level1_min", -900, "Upper limit of level 2")
setting("int", "level2_min", -1500, "Upper limit of level 3")
setting("int", "level3_min", -2100, "Upper limit of the sunless sea")
setting("int", "sunless_sea_min", -2500, "Lower limit of the sunless sea")

setting("int", "lava_sea_max", -3000, "Upper limit of the lava sea")
setting("int", "lava_sea_min", -3500, "Lower limit of the lava sea")

setting("float", "lava_sea_threshold", 0.2, "Cavern threshold for sunless and magma seas (higher number means sparser magma)")
setting("bool", "enable_lava_sea", true, "Enable magma sea level")

setting("bool", "flooded_biomes", true, "Add a lot of water to the most humid cavern biomes")
setting("bool", "stone_between_layers", true, "Ensures that there's a solid stone floor/ceiling between cavern layers")

df_caverns.config.sunless_sea_level = df_caverns.config.level3_min - (df_caverns.config.level3_min - df_caverns.config.sunless_sea_min) * 0.5
