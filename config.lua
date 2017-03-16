local CONFIG_FILE_PREFIX = "dfcaverns_"

dfcaverns.config = {}

local print_settingtypes = true

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
	{name="fungiwood", min_delay=2400, max_delay=4800, min_depth=-100, max_depth=-31000},
	{name="tunnel_tube", min_delay=2400, max_delay=4800, min_depth=-100, max_depth=-31000},
	{name="spore_tree", min_delay=2400, max_delay=4800, min_depth=-100, max_depth=-31000},
	{name="black_cap", min_delay=2400, max_delay=4800, min_depth=-100, max_depth=-31000},
	{name="nether_cap", min_delay=2400, max_delay=4800, min_depth=-100, max_depth=-31000},
	{name="goblin_cap", min_delay=2400, max_delay=4800, min_depth=-100, max_depth=-31000},
	{name="tower_cap", min_delay=2400, max_delay=4800, min_depth=-100, max_depth=-31000},
}

for _, tree in pairs(trees) do
	setting("int", tree.name.."_min_growth_delay", tree.min_delay, tree.name.." minimum sapling growth delay")
	setting("int", tree.name.."_max_growth_delay", tree.max_delay, tree.name.." maximum sapling growth delay")
	setting("int", tree.name.."_min_depth", tree.min_depth, tree.name.." minimum sapling growth depth")
	setting("int", tree.name.."_max_depth", tree.max_depth, tree.name.." maximum sapling growth depth")
end

setting("int", "blood_thorn_growth_interval", 12, "blood_thorn growth ABM interval")
setting("int", "blood_thorn_growth_chance", 83, "blood_thorn growth ABM chance")
setting("int", "blood_thorn_min_depth", -100, "blood_thorn minimum sapling growth depth")
setting("int", "blood_thorn_max_depth", -31000, "blood_thorn maximum sapling growth depth")

setting("bool", "light_kills_fungus", true, "Light kills fungus")