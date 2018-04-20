local CONFIG_FILE_PREFIX = "dfcaverns_"

dfcaverns.config = {}

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
	dfcaverns.config[name] = value
	
	if print_settingtypes then
		minetest.debug(CONFIG_FILE_PREFIX..name.." ("..description..") "..stype.." "..tostring(default))
	end	
end

local trees = {
	{name="fungiwood", delay_multiplier = 1},
	{name="tunnel_tube", delay_multiplier = 1},
	{name="spore_tree", delay_multiplier = 1},
	{name="black_cap", delay_multiplier = 1},
	{name="nether_cap", delay_multiplier = 1},
	{name="goblin_cap", delay_multiplier = 1},
	{name="tower_cap", delay_multiplier = 1},
}

local plants = {
	{name="cave_wheat", delay_multiplier=1},
	{name="dimple_cup", delay_multiplier=3},
	{name="pig_tail", delay_multiplier=1},
	{name="plump_helmet", delay_multiplier=3},
	{name="quarry_bush", delay_multiplier=2},
	{name="sweet_pod", delay_multiplier=2},
}

--Trees

setting("int", "tree_min_growth_delay", 2400, "Minimum sapling growth delay")
setting("int", "tree_max_growth_delay", 4800, "Maximum sapling growth delay")

for _, tree in pairs(trees) do
	setting("float", tree.name.."_delay_multiplier", tree.delay_multiplier, tree.name.." growth delay multiplier")
end

setting("int", "blood_thorn_growth_interval", 12, "blood_thorn growth ABM interval")
setting("int", "blood_thorn_growth_chance", 83, "blood_thorn growth ABM chance")

--Plants

setting("int", "plant_growth_time", 500, "Base plant growth time")

for _, plant in pairs(plants) do
	setting("float", plant.name.."_delay_multiplier", plant.delay_multiplier, plant.name.." growth delay multiplier")
end

setting("float", "glow_worm_delay_multiplier", 10.0, "glow worm growth delay multiplier")
setting("bool", "light_kills_fungus", true, "Light kills fungus")

--Caverns

setting("float", "vertical_cavern_scale", 256, "Vertical cavern dimension scale")
setting("float", "horizontal_cavern_scale", 256, "Horizontal cavern dimension scale")

setting("int", "ymax", -300, "Upper limit of level 1")
setting("int", "level1_min", -900, "Upper limit of level 2")
setting("int", "level2_min", -1500, "Upper limit of level 3")
setting("int", "level3_min", -2100, "Upper limit of lava sea")
setting("int", "lava_sea_min", -2700, "Lower limit of the lava sea")

setting("float", "lava_sea_threshold", 0.2, "Cavern threshold for magma sea (higher number means sparser magma)")
setting("bool", "bottom_sea_contains_lava", true, "Lower sea contains lava")

if minetest.get_modpath("tnt") then
	dfcaverns.config.enable_tnt = minetest.settings:get_bool("enable_tnt")
	if dfcaverns.config.enable_tnt == nil then
		-- Default to enabled when in singleplayer
		dfcaverns.config.enable_tnt = minetest.is_singleplayer()
	end
end
