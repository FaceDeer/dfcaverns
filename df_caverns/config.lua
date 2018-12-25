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
setting("float", "sunless_sea_threshold", 0.25, "Cavern threshold for sunless seas (higher number means sparser caverns)")
setting("float", "tunnel_flooding_threshold", 0.25, "Threshold for flooding tunnels around flooded caverns")

setting("int", "ymax", -200, "Upper limit of level 1")
setting("int", "level1_min", -800, "Upper limit of level 2")
setting("int", "level2_min", -1400, "Upper limit of level 3")
setting("int", "level3_min", -2000, "Upper limit of the sunless seas")
setting("int", "sunless_sea_min", -2400, "Lower limit of the sunless seas")

setting("bool", "enable_oil_sea", true, "Enable oil sea")
df_caverns.config.enable_oil_sea = df_caverns.config.enable_oil_sea and minetest.get_modpath("oil") ~= nil
setting("int", "oil_sea_level", -2600, "Oil sea level")

setting("bool", "enable_lava_sea", true, "Enable magma sea")
setting("int", "lava_sea_level", -2800, "Lava sea level")

setting("bool", "enable_underworld", true, "Enable underworld")
df_caverns.config.enable_underworld = df_caverns.config.enable_underworld and minetest.get_modpath("df_underworld_items") ~= nil
setting("int", "underworld_level", -3100, "Underworld level")
