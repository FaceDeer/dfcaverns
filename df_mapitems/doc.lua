df_mapitems.doc = {}

if not minetest.get_modpath("doc") then
	return
end

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

df_mapitems.doc.cave_moss_desc = S("Cave moss is technically a form of mold, but fortunately a relatively benign one given its ubiquity. Its fibers form a tough but springy mat over the surface of any organic-rich soil that accumulates deep underground.")
df_mapitems.doc.cave_moss_usage = S("Cave moss has no known uses aside from the faint glow it emits. It dies when exposed to bright light sources such as the Sun.")
df_mapitems.doc.floor_fungus_desc = S("Floor fungus produces a thin, slick film that spreads through the cracks of broken rock. Its ability to subsist on the tiniest traces of nutrients means it's found in relatively harsh underground environments.")
df_mapitems.doc.floor_fungus_usage = S("Floor fungus has no known uses. It can penetrate deeply into cobblestone constructions if an infestation gets hold, but it is difficult to transport and is inhibited by light so it hasn't spread beyond the deep caverns.")

df_mapitems.doc.glow_worms_desc = S("Glistening strings of silk hang from the ceilings of some of the larger caverns, lit by the millions of tiny bioluminescent worms that spun them. Glow worms prey on the insects they lure and entangle with their faux starry sky - and sometimes the occasional bat or other larger flying beast.")
df_mapitems.doc.glow_worms_usage = S("Glow worms can be harvested and used as a source of light but they die when exposed to light significantly brighter than themselves or when immersed in water. A colony of glow worms hung in a hospitable environment will undergo a modest amount of growth, allowing it to be divided and propagated.")

df_mapitems.doc.snareweed_desc = S("A nasty kelp-like plant that grows in patches on the floor of the Sunless Sea. Its reflective patches draw in the unwary and then its prickly barbs catch and hold small creatures.")
df_mapitems.doc.snareweed_usage = S("Snareweed has no practical use, its fibers disintegrate when they dry.")

df_mapitems.doc.cave_coral_desc = S("A rare form of coral found only deep underground in the Sunless Sea, cave coral grows hanging from the ceilings of flooded caverns.")
df_mapitems.doc.cave_coral_usage = S("Aside from their aesthetic beauty, cave corals can be harvested for simple building materials.")

df_mapitems.doc.flowstone_desc = S("Flowstone is a carbonate-rich rock formation deposited by flowing water. It consists of minerals that the water dissolved earlier as it widens cracks and fissures into caves.")
df_mapitems.doc.flowstone_usage = S("Aside from the aesthetic beauty of its formations flowstone has no special properties or uses.")
df_mapitems.doc.dripstone_desc = S("The iconic stalactites and stalagmites found in caverns are composed of flowstone (or 'dripstone' in the case of these formations). Moist dripstone is still undergoing growth, whereas dry dripstone is found in 'dead' caverns once the source of water that created them ceases.")
df_mapitems.doc.dripstone_usage = S("Although stalagmites are blunter than the stalactites above them, they can cause extra damage to the unwary caver who falls on them.")
df_mapitems.doc.icicle_desc = S("Ice formed by water dripping slowly into a cold environment, icicles tend to be exceptionally pure and clear.")
df_mapitems.doc.icicle_usage = S("Falling onto an icicle is particularly damaging.")


df_mapitems.doc.glow_mese_desc = S("Deep in the infernal conditions of the magma sea, over the course of millions of years, mese crystals grow into flawless blocks that glow bright with strange energies.")
df_mapitems.doc.glow_mese_usage = S("These blocks can be broken down into a large number of mese crystals, but cannot be artificially reassembled.")

df_mapitems.doc.glow_ruby_ore_desc = S("Large, dry caverns deep underground are well suited to aeons-long processes that concentrate crystalline substances in their walls. This rock is riddled with veins of the stuff.")
df_mapitems.doc.glow_ruby_ore_usage = S("Aside from its aesthetic value this rock has no particular use.")

df_mapitems.doc.big_crystal_desc = S("Monolithic crystals of this size form only over extremely long periods deep underground, in large long-lived cavities that allow them room to grow. Water and the life it hosts tend to disrupt the formation process of these crystals so they're only found in dry environments.")
df_mapitems.doc.big_crystal_usage = S("Aside from its aesthetic value this crystal has no particular use.")

df_mapitems.doc.slade_desc = S("The very foundation of the world, Slade is a mysterious ultra-dense substance.")
df_mapitems.doc.slade_usage = S("Slade is extremely hard to work with so it has little use.")
if df_mapitems.config.invulnerable_slade then
	df_mapitems.doc.slade_usage = df_mapitems.doc.slade_usage .. " " .. S("In fact, Slade is impervious to conventional mining entirely.")
end

df_mapitems.doc.slade_seal_desc = S("This block of Slade, carved by an unknown hand, is engraved with mysterious symbols. Most of the engraving's meaning is lost to the mists of time but one frament in the oldest known language can be translated: \"This place is not a place of honor.\"")