local CONFIG_FILE_PREFIX = "dfcaverns_"

df_trees.config = {}

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
	df_trees.config[name] = value
	
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

--Trees

setting("int", "tree_min_growth_delay", 2400, "Minimum sapling growth delay")
setting("int", "tree_max_growth_delay", 4800, "Maximum sapling growth delay")

for _, tree in pairs(trees) do
	setting("float", tree.name.."_delay_multiplier", tree.delay_multiplier, tree.name.." growth delay multiplier")
end

setting("int", "blood_thorn_growth_interval", 12, "blood_thorn growth ABM interval")
setting("int", "blood_thorn_growth_chance", 83, "blood_thorn growth ABM chance")

if minetest.get_modpath("tnt") then
	df_trees.config.enable_tnt = minetest.settings:get_bool("enable_tnt")
	if df_trees.config.enable_tnt == nil then
		-- Default to enabled when in singleplayer
		df_trees.config.enable_tnt = minetest.is_singleplayer()
	end
end