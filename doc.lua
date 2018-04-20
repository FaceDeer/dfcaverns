dfcaverns.doc = {}

if not minetest.get_modpath("doc") then
	return
end

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

dfcaverns.doc.biscuit_desc = S("A meal made from the admixture of two ingredients, biscuits keep well but are not a rich source of nutrients.")
dfcaverns.doc.biscuit_usage = nil
dfcaverns.doc.stew_desc = S("Stews mix three ingredients together. They're more wholesome than biscuits, packing more nutrition into a single serving.")
dfcaverns.doc.stew_usage = nil
dfcaverns.doc.roast_desc = S("Four finely minced ingredients combine into a roast, which serves as a full meal.")
dfcaverns.doc.roast_usage = nil

dfcaverns.doc.cave_moss_desc = S("Cave moss is technically a form of mold, but fortunately a relatively benign one given its ubiquity. Its fibers form a tough but springy mat over the surface of any organic-rich soil that accumulates deep underground.")
dfcaverns.doc.cave_moss_usage = S("Cave moss has no known uses. It dies when exposed to bright light sources.")
dfcaverns.doc.floor_fungus_desc = S("Floor fungus produces a thin, slick film that spreads through the cracks of broken rock. Its ability to subsist on the tiniest traces of nutrients means it's found in relatively harsh underground environments.")
dfcaverns.doc.floor_fungus_usage = S("Floor fungus has no known uses. It can penetrate deeply into cobblestone constructions if an infestation gets hold, but it is difficult to transport and is inhibited by light so it hasn't spread beyond the deep caverns.")

dfcaverns.doc.glow_worms_desc = S("Glistening strings of silk hang from the ceilings of some of the larger caverns, lit by the millions of tiny bioluminescent worms that spun them. Glow worms prey on the insects they lure and entangle with their faux starry sky - and sometimes the occasional bat or other larger flying beast.")
dfcaverns.doc.glow_worms_usage = S("Glow worms can be harvested and used as a source of light but they die when exposed to light significantly brighter than themselves or when immersed in water. A colony of glow worms hung in a hospitable environment will undergo a modest amount of growth, allowing it to be divided and propagated.")

-- Plants

dfcaverns.doc.dead_fungus_desc = S("Whatever this fungus was in life, it is now dead.")
dfcaverns.doc.dead_fungus_usage = S("Dead fungus quickly decays into an unrecognizable mess. It can be used as weak fuel or terrible decor.")

dfcaverns.doc.cavern_fungi_desc = S("A species of lavender mushroom ubiquitous in caves that is most notable for the soft bioluminescence it produces.")
dfcaverns.doc.cavern_fungi_usage = S("This mushroom is inedible but continues producing modest levels of light long after it's picked.")

dfcaverns.doc.cave_wheat_desc = S("Cave wheat is literally a breed of grain-producing grass that somehow lost its ability to photosynthesize and adapted to a more fungal style of life.")
dfcaverns.doc.cave_wheat_usage = S("Like its surface cousin, cave wheat produces grain that can be ground into a form of flour.")
dfcaverns.doc.cave_flour_desc = S("Cave wheat seed ground into a powder suitable for cooking.")
dfcaverns.doc.cave_flour_usage = S("When baked alone it forms an edible bread, but it combines well with other more flavorful ingredients.")
dfcaverns.doc.cave_bread_desc = S("Bread baked from cave wheat flour is tough and durable. A useful ration for long expeditions.")
dfcaverns.doc.cave_bread_usage = S("It's not tasty, but it keeps you going.")

dfcaverns.doc.dimple_cup_desc = S("The distinctive midnight-blue caps of these mushrooms are inverted, exposing their gills to any breeze that might pass, and have dimpled edges that give them their name.")
dfcaverns.doc.dimple_cup_usage = S("Dimple cups can be dried, ground, and processed to extract a deep blue dye.")

dfcaverns.doc.pig_tail_desc = S("Pig tails are a fibrous fungal growth that's most notable for its twisting stalks. In a mature stand of pig tails the helical stalks intertwine into a dense mesh.")
dfcaverns.doc.pig_tail_usage = S("Pig tail stalks can be processed to extract fibers useful as thread.")
dfcaverns.doc.pig_tail_thread_desc = S("Threads of pig tail fiber.")
dfcaverns.doc.pig_tail_thread_usage = S("A crafting item that can be woven into textiles and other similar items.")

dfcaverns.doc.plump_helmet_desc = S("Plump helmets are a thick, fleshy mushroom that's edible picked straight from the ground. They form a staple diet for both lost cave explorers and the fauna that preys on them.")
dfcaverns.doc.plump_helmet_usage = S("While they can be eaten fresh, they can be monotonous fare and are perhaps better appreciated as part of a more complex prepared dish.")

dfcaverns.doc.quarry_bush_desc = S("A rare breed of fungus from deep underground that produces a bushy cluster of rumpled gray 'blades'. The biological function of these blades is not known, as quarry bushes reproduce via hard-shelled nodules that grow down at the blade's base.")
dfcaverns.doc.quarry_bush_usage = S("Quarry bush leaves and nodules (called 'rock nuts') can be harvested and are edible with processing.")
dfcaverns.doc.quarry_bush_leaves_desc = S("The dried blades of a quarry bush add a welcome zing to recipes containing otherwise-bland subterranean foodstuffs, but they're too spicy to be eaten on their own.")
dfcaverns.doc.quarry_bush_leaves_usage = S("Quarry bush leaves can be used as an ingredient in foodstuffs.")

dfcaverns.doc.sweet_pod_desc = S("Sweet pods grow in rich soil, and once they reach maturity they draw that supply of nutrients up to concentrate it in their fruiting bodies. They turn bright red when ripe and can be processed in a variety of ways to extract the sugars they contain.")

if minetest.get_modpath("cottages") then
	dfcaverns.doc.sweet_pod_usage = S("When milled, sweet pods produce a granular sugary substance.")
else
	dfcaverns.doc.sweet_pod_usage = S("When dried in an oven, sweet pods produce a granular sugary substance.")
end
dfcaverns.doc.sweet_pod_usage = dfcaverns.doc.sweet_pod_usage .. " " .. S("Crushing them in a bucket squeezes out a flavorful syrup.")

dfcaverns.doc.sweet_pod_sugar_desc = S("Sweet pod sugar has a pink tint to it.")
dfcaverns.doc.sweet_pod_sugar_usage = S("Too sweet to be eaten directly, it makes an excellent ingredient in food recipes.")
dfcaverns.doc.sweet_pod_syrup_desc = S("Sweet pod syrup is thick and flavorful.")
dfcaverns.doc.sweet_pod_syrup_usage = S("Too strong and thick to drink straight, sweet pod syrup is useful in food recipes.")

-- Trees
dfcaverns.doc.black_cap_desc = S("The dense black wood of these mushrooms is heavy and hard to work with, and has few remarkable properties.")
dfcaverns.doc.black_cap_usage = S("Aside from the artistic applications of its particularly dark color, black cap wood is a long-burning fuel source that's as good as coal for some applications.")

dfcaverns.doc.blood_thorn_desc = S("Blood thorns are the most vicious of underground flora, as befits their harsh environments. Found only in hot, dry caverns with sandy soil far from the surface world's organic bounty, blood thorns seek to supplement their nutrient supply with wickedly barbed hollow spines that actively drain fluids from whatever stray plant or creature they might impale.")
dfcaverns.doc.blood_thorn_usage = S("When harvested, the central stalk of a blood thorn can be cut into planks and used as wood. It has a purple-red hue that may or may not appeal, depending on one's artistic tastes.")
dfcaverns.doc.blood_thorn_spike_desc = S("The spikes of a blood thorn can actually remain living long after they're severed from their parent stalk, a testament to their tenacity. As long as they remain alive they will continue to actively drain anything they puncture, though they don't grow.")
dfcaverns.doc.blood_thorn_spike_usage = S("Living blood thorn spikes remain harmful to creatures that touch them. If killed by bright light, they cause only passive damage to creatures that fall on them (as one would expect from an enormous spike).")

dfcaverns.doc.fungiwood_desc = S("Thin, irregular layers of spore-producing 'shelves' surround the strong central stalk of the mighty Fungiwood.")
dfcaverns.doc.fungiwood_usage = S("Fungiwood stalk is strong and very fine-grained, making smooth yellow-tinted lumber when cut. Fungiwood shelf is too fragile to be much use as anything other than fuel.")

dfcaverns.doc.goblin_cap_desc = S("Massive but squat, mature goblin cap mushrooms are the size of small cottages.")
dfcaverns.doc.goblin_cap_usage = S("Goblin cap stem and cap material can be cut into wood of two different hues, a subdued cream and a bright orange-red.")

dfcaverns.doc.nether_cap_desc = S("Nether caps have an unusual biochemistry that allows them to somehow subsist on ambient heat, in violation of all known laws of thermodynamics. They grow deep underground in frigid, icy caverns that should by all rights be volcanic.")
dfcaverns.doc.nether_cap_usage = S("Nether cap wood, in addition to being a beautiful blue hue, retains the odd heat-draining ability of living nether caps and is able to quickly freeze nearby water solid.")

dfcaverns.doc.spore_tree_desc = S("Spore trees have a sturdy 'trunk' that supports a large spongy mesh of branching fibers, with embedded fruiting bodies that produce a copious amount of spores that gently rain down around the spore tree's base.")
dfcaverns.doc.spore_tree_usage = S("Spore tree trunks can be cut into pale woody planks. The branching fibers and fruiting bodies are only useful as fuel.")

dfcaverns.doc.tower_cap_desc = S("The king of the fungi, tower cap mushrooms grow to immense proportions.")
dfcaverns.doc.tower_cap_usage = S("Tower caps are an excellent source of wood.")

dfcaverns.doc.tunnel_tube_desc = S("Tunnel tubes are hollow, curved fungal growths that support a fruiting body.")
if dfcaverns.config.enable_tnt then
	dfcaverns.doc.tunnel_tube_usage = S("The trunk of a tunnel tube can be cut and processed to produce plywood-like material. The fruiting body accumulates high-energy compounds that, when ignited, produce a vigorous detonation - a unique adaptation for spreading tunnel tube spawn through the still cavern air.")
else
	dfcaverns.doc.tunnel_tube_usage = S("The trunk of a tunnel tube can be cut and processed to produce plywood-like material.")
end
