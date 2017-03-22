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
	{name="fungiwood", min_depth=-100, max_depth=-31000, delay_multiplier = 1},
	{name="tunnel_tube", min_depth=-100, max_depth=-31000, delay_multiplier = 1},
	{name="spore_tree", min_depth=-100, max_depth=-31000, delay_multiplier = 1},
	{name="black_cap", min_depth=-100, max_depth=-31000, delay_multiplier = 1},
	{name="nether_cap", min_depth=-100, max_depth=-31000, delay_multiplier = 1},
	{name="goblin_cap", min_depth=-100, max_depth=-31000, delay_multiplier = 1},
	{name="tower_cap", min_depth=-100, max_depth=-31000, delay_multiplier = 1},
}

local plants = {
	{name="cave_wheat", delay_multiplier=1},
	{name="dimple_cup", delay_multiplier=3},
	{name="pig_tail", delay_multiplier=1},
	{name="plump_helmet", delay_multiplier=3},
	{name="quarry_bush", delay_multiplier=2},
	{name="sweet_pod", delay_multiplier=2},
}

setting("int", "tree_min_growth_delay", 2400, "Minimum sapling growth delay")
setting("int", "tree_max_growth_delay", 4800, "Maximum sapling growth delay")

for _, tree in pairs(trees) do
	setting("float", tree.name.."_delay_multiplier", tree.delay_multiplier, tree.name.." growth delay multiplier")
	setting("int", tree.name.."_min_depth", tree.min_depth, tree.name.." minimum sapling growth depth")
	setting("int", tree.name.."_max_depth", tree.max_depth, tree.name.." maximum sapling growth depth")
end

setting("int", "blood_thorn_growth_interval", 12, "blood_thorn growth ABM interval")
setting("int", "blood_thorn_growth_chance", 83, "blood_thorn growth ABM chance")
setting("int", "blood_thorn_min_depth", -100, "blood_thorn minimum sapling growth depth")
setting("int", "blood_thorn_max_depth", -31000, "blood_thorn maximum sapling growth depth")

setting("int", "plant_growth_timer", 100, "Base plant growth timer interval")
setting("int", "plant_growth_chance", 4, "Base plant growth chance")

for _, plant in pairs(plants) do
	setting("float", plant.name.."_timer_multiplier", plant.delay_multiplier, plant.name.." growth delay multiplier")
end

setting("bool", "light_kills_fungus", true, "Light kills fungus")

setting("int", "ymax", -300, "Upper limit of level 1")
setting("int", "level1_min", -900, "Upper limit of level 2")
setting("int", "level2_min", -1500, "Upper limit of level 3")
setting("int", "level3_min", -2100, "Upper limit of lava sea")
setting("int", "lava_sea_min", -2700, "Upper limit of underworld")
setting("int", "ymin", -3500, "Lower limit of underworld")

