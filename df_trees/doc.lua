df_trees.doc = {}

if not minetest.get_modpath("doc") then
	return
end

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- Trees
df_trees.doc.black_cap_desc = S("The dense black wood of these mushrooms is heavy and hard to work with, and has few remarkable properties.")
df_trees.doc.black_cap_usage = S("Aside from the artistic applications of its particularly dark color, black cap wood is a long-burning fuel source that's as good as coal for some applications. Black cap gills are oily and make for excellent torch fuel.")

df_trees.doc.blood_thorn_desc = S("Blood thorns are the most vicious of underground flora, as befits their harsh environments. Found only in hot, dry caverns with sandy soil far from the surface world's organic bounty, blood thorns seek to supplement their nutrient supply with wickedly barbed hollow spines that actively drain fluids from whatever stray plant or creature they might impale.")
df_trees.doc.blood_thorn_usage = S("When harvested, the central stalk of a blood thorn can be cut into planks and used as wood. It has a purple-red hue that may or may not appeal, depending on one's artistic tastes.")
df_trees.doc.blood_thorn_spike_desc = S("The spikes of a blood thorn can actually remain living long after they're severed from their parent stalk, a testament to their tenacity. As long as they remain alive they will continue to actively drain anything they puncture, though they don't grow.")
df_trees.doc.blood_thorn_spike_usage = S("Living blood thorn spikes remain harmful to creatures that touch them. If killed by bright light, they cause only passive damage to creatures that fall on them (as one would expect from an enormous spike).")

df_trees.doc.fungiwood_desc = S("Thin, irregular layers of spore-producing 'shelves' surround the strong central stalk of the mighty Fungiwood.")
df_trees.doc.fungiwood_usage = S("Fungiwood stalk is strong and very fine-grained, making smooth yellow-tinted lumber when cut. Fungiwood shelf is too fragile to be much use as anything other than fuel.")

df_trees.doc.goblin_cap_desc = S("Massive but squat, mature goblin cap mushrooms are the size of small cottages.")
df_trees.doc.goblin_cap_usage = S("Goblin cap stem and cap material can be cut into wood of two different hues, a subdued cream and a bright orange-red.")

df_trees.doc.nether_cap_desc = S("Nether caps have an unusual biochemistry that allows them to somehow subsist on ambient heat, in violation of all known laws of thermodynamics. They grow deep underground in frigid, icy caverns that should by all rights be volcanic.")
df_trees.doc.nether_cap_usage = S("Nether cap wood, in addition to being a beautiful blue hue, retains the odd heat-draining ability of living nether caps and is able to quickly freeze nearby water solid.")

df_trees.doc.spore_tree_desc = S("Spore trees have a sturdy 'trunk' that supports a large spongy mesh of branching fibers, with embedded fruiting bodies that produce a copious amount of spores that gently rain down around the spore tree's base.")
df_trees.doc.spore_tree_usage = S("Spore tree trunks can be cut into pale woody planks. The branching fibers and fruiting bodies are only useful as fuel.")

df_trees.doc.tower_cap_desc = S("The king of the fungi, tower cap mushrooms grow to immense proportions.")
df_trees.doc.tower_cap_usage = S("Tower caps are an excellent source of wood.")

df_trees.doc.tunnel_tube_desc = S("Tunnel tubes are hollow, curved fungal growths that support a fruiting body.")
if df_trees.config.enable_tnt then
	df_trees.doc.tunnel_tube_usage = S("The trunk of a tunnel tube can be cut and processed to produce plywood-like material. The fruiting body accumulates high-energy compounds that, when ignited, produce a vigorous detonation - a unique adaptation for spreading tunnel tube spawn through the still cavern air.")
else
	df_trees.doc.tunnel_tube_usage = S("The trunk of a tunnel tube can be cut and processed to produce plywood-like material.")
end
