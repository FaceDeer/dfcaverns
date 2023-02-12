local S = minetest.get_translator(minetest.get_current_modname())

local base = 200

collectible_lore.register_lorebook({
	id = "rose cave wheat",
	title = S("Cave Wheat: The Other White Grain"),
	text = S([[In a world dominated by many varied fungal forms, cave wheat is an oddity - it is in fact not a fungus at all.  It is literally a breed of grass that has lost its ability to photosynthesize and adapted to a subterranean style of life. Its roots draw sustenance from the same sources of nutrition that more conventional fungi do, with the blades of its leaves having atrophied into mere structural supports to elevate its seeds above the mire below and allow them to dry before dispersing. Cave wheat has a pale blue-tinted hue while it is growing, fading to white once its stalks mature and dry into wispy straw.

The grains of cave wheat are as nutritional as those of its surface cousins, and can be ground into a flour-like powder that keeps well in the cool damp conditions prevalent underground. Bread baked from cave wheat flour is dense and tough, but can serve as a staple food to sustain a traveler provided they don't mind a little monotony.

Make that a lot of monotony. It is advised to combine cave wheat flour with other ingredients whenever possible, it extends the nutritional value without adding or detracting much from other flavours.

Cave wheat can be cultivated by planting its seeds in suitable loamy soil. As with most underground flora, it has little resistance to the damaging effects of light and will wither if exposed to much of it.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 0,
})

collectible_lore.register_lorebook({
	id = "rose dimple cup",
	title = S("Dimple Cup"),
	text = S([[Today, I discovered a new species of mushroom deep in the caverns - the Dimple Cup. These small mushrooms have caps that are a deep, midnight-blue color, with inverted gills and dimpled edges that give them their name. I was able to dry, grind, and process these mushrooms to extract a dye of the same beautiful color. The resulting dye is a rich and vibrant blue that I can't wait to experiment with in my artistic endeavors.

As I held the mushroom in my hand, I couldn't help but think of the depths of the ocean and the mysteries that lie within. I wrote a short poem to capture the feeling:

Deep in the caverns, a mushroom so rare
A blue so deep, like the ocean's despair
With dimpled edges, and inverted gills
A mystery of nature, that still fills

My heart with wonder, my mind with awe
The Dimple Cup, forever more.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 1,
})

collectible_lore.register_lorebook({
	id = "rose pig tail",
	title = S("Pig Tail"),
	text = S([[Today I discovered a fascinating new species of underground fungus - Pig Tails. These growths have twisting stalks that wind around each other in a dense mesh, creating a beautiful spiral pattern. Upon closer inspection, I found that the stalks of the Pig Tails can be processed to extract fibers that are strong and pliable, making them ideal for use as thread.

As I examined these Pig Tails, I couldn't help but feel a sense of wonder at the unexpected possibilities that exist deep beneath the ground. To think that textiles could be made in these remote caverns is truly remarkable. The fibers extracted from the Pig Tails are of a high quality, and I can't wait to see what kind of fabrics and clothing can be crafted from them.

I must remind myself to be cautious when harvesting these Pig Tails, as they grow in dense clusters and are easily disturbed. I am excited to continue my research on these Pig Tails and the other unique underground fungi that I have yet to discover.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 2,
})

collectible_lore.register_lorebook({
	id = "rose plump helmet",
	title = S("Plump Helmet"),
	text = S([[Today I stumbled upon a bountiful patch of plump helmets. These thick, fleshy mushrooms are a common sight in the caverns and serve as a staple food source for both lost cave explorers and the fauna that preys on them. Though they can be eaten fresh, I found that they can be quite monotonous on their own. However, when prepared in a more complex dish, they add a nice meaty texture and earthy flavor. It's always a relief to come across a reliable source of sustenance in these underground depths. I will be sure to gather as many as I can to bring back to camp for tonight's meal.



Sincerely,
Professor Amelia Rose]]),
	sort = base + 3,
})

collectible_lore.register_lorebook({
	id = "rose quarry bush",
	title = S("Quarry Bush"),
	text = S([[Today I stumbled upon a fascinating find deep in the caverns - Quarry Bushes. These unique fungi produce a cluster of grey, rumpled 'blades' that seem to serve no obvious purpose. Upon closer examination, I discovered that the bushes reproduce via hard-shelled nodules, called 'rock nuts', that grow at the base of the blades.

To my delight, I found that both the leaves and the rock nuts are edible, though they do require some processing. The dried blades of a quarry bush add a welcome zing to recipes containing otherwise-bland subterranean foodstuffs, but they're too spicy to be eaten on their own.

This discovery opens the possibility of genuinely gourmet cooking and not just subsistence foods in these subterranean regions. The wide variety of edible fungi and plants that can be found here truly astounds me. The Quarry Bushes are a rare find, but they add a new dimension to the underground culinary scene. I can't wait to experiment with them in the lab and see what other culinary delights can be created.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 4,
})

local ss_text = ""
if minetest.get_modpath("cottages") then
	ss_text = S("When milled, sweet pods produce a granular pink-tinted sugary substance.")
else
	ss_text = S("When dried in an oven, sweet pods produce a granular pink-tinted sugary substance.")
end
ss_text = ss_text .. " " .. S("Crushing them in a bucket squeezes out a flavorful syrup.")

collectible_lore.register_lorebook({
	id = "rose sweet pod",
	title = S("Sweet Pod"),
	text = S([[Today, I had the pleasure of discovering a new species of subterranean fungi - the sweet pods. These mushrooms grow in rich soil, and once they reach maturity, they draw the nutrients from the soil up their pale stalks to concentrate it in their round fruiting bodies. The fruiting bodies turn bright red when ripe and can be processed in a variety of ways to extract the sugars they contain.

When dried and milled, the sweet pods produce a granular pink-tinted sugary substance that can be used as a sweetener in a variety of dishes. Additionally, when crushed in a bucket, a flavorful syrup can be squeezed out that can be used as a topping or an ingredient in cooking.

The sweet pods are a delightful discovery and open up new possibilities for gourmet cooking in the subterranean regions. I can't wait to experiment with different recipes and see what other culinary delights can be created using these delicious mushrooms.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 5,
})

collectible_lore.register_lorebook({
	id = "rose cave moss",
	title = S("Cave Moss"),
	text = S([[I am constantly in awe of the strange and beautiful life that exists in these caverns. Today I came across Cave Moss, a type of mold that covers the floors of the subterranean world. Although it is not a spectacular sight, its presence is still quite remarkable.

This moss forms a dense mat of fibrous strands that seem to be both tough and springy. It thrives in rich organic soil, which is so plentiful in these caverns, making it one of the most widespread forms of life here.

But what truly sets Cave Moss apart is its ability to emit a gentle glow. This makes it an important source of light in the otherwise dark caverns, allowing travelers like myself to navigate through these underground realms with ease. It is a small but crucial detail that highlights the unique and amazing adaptations that the life down here has evolved.

However, it is a delicate creature that cannot withstand bright light and will die when exposed to the sun. It is a reminder of the fragility of life, even in these seemingly harsh and inhospitable environments.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 6,
})

collectible_lore.register_lorebook({
	id = "rose floor fungus",
	title = S("Ecology of Floor Fungus"),
	text = S([[Today I had the opportunity to observe and study a most peculiar fungus, known as Floor Fungus. This thin and slick growth can be found in the cracks of broken rocks, subsisting on the smallest of nutrients in harsh underground environments. It's a remarkable example of the resilience of life, adapting to the challenging conditions in these caverns.

However, despite its prevalence, Floor Fungus does not seem to have any known uses. I learned that it can penetrate deeply into cobblestone constructions if allowed to infest, but its spread has been limited by its sensitivity to light. It is fascinating to think about the unique adaptations that organisms like Floor Fungus have developed in order to survive in these dark and harsh conditions.

This discovery only deepens my appreciation for the rich and diverse life that exists within these caverns, and I look forward to uncovering more secrets in my continued explorations.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 7,
})

collectible_lore.register_lorebook({
	id = "banks floor fungus",
	title = S("The Scourge of Floor Fungus"),
	text = S([[Today I encountered the floor fungus, a peculiar form of subterranean mold that spreads through the cracks of broken rock. Despite its ubiquity in harsh underground environments, I cannot help but feel horrified by its resilience. This insidious growth has the potential to cause immense harm if it were to contaminate the foundations of surface structures and constructions.

During my experiments in the caverns, I observed the ease with which floor fungus can penetrate deeply into cobblestone constructions, and its ability to subsist on the tiniest traces of nutrients. It is therefore imperative that exploration of caverns with floor fungus in it be treated with care.

In light of this discovery, I strongly advise caution and recommend further research into the properties of this fungus. Its ability to thrive in seemingly inhospitable environments is a cause for concern, and I worry about what might happen if it were to spread beyond the deep caverns.

Signed,
Dr. Theodore Banks]]),
	sort = base + 8,
})

collectible_lore.register_lorebook({
	id = "rose stillworm",
	title = S("Stillworm"),
	text = S([[Today, I encountered a new species of fungus, known as Stillworm, while exploring the caverns. At first glance, its appearance is that of pale, motionless earthworms intertwined with the soil. Despite being aware that it is a form of fungus, I can't help but feel disturbed by its uncanny resemblance to actual worms. Walking on soil where Stillworm grows is an eerie experience, and I find myself tiptoeing cautiously to avoid stepping on them. Its survival in harsh underground environments is remarkable, but its eerie appearance leaves a lasting impression.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 9,
})

collectible_lore.register_lorebook({
	id = "rose sand scum",
	title = S("Sand scum"),
	text = S([[Today, I encountered something new down here in the caverns: Sand Scum. It's a crust of algae that grows on wet sand and, apparently, it's able to survive by utilizing the bioluminescent light from other organisms.

To be honest, I have to admit that I'm at a loss for words when it comes to Sand Scum. I have tried my best to find something interesting to say about it, but unfortunately, I have failed. It's just not that exciting of a discovery. I suppose it's a good indicator of the diversity of life that can be found in even the harshest environments, but that's about the extent of my thoughts on the matter.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 10,
})

collectible_lore.register_lorebook({
	id = "rose pebble fungus",
	title = S("Pebble Fungus"),
	text = S([[Today I discovered another fascinating underground species: pebble fungus. This mushroom covers the soil in small, spheroidal fruiting bodies that look like they could be gravel composed of erosion-smoothed pebbles. However, upon closer inspection, I found that the surface of these "pebbles" is actually soft and springy to the touch.

I must admit, I was pleasantly surprised to find that walking on this pebble fungus is actually quite comfortable. The dense, spongy surface of the fruiting bodies provides a gentle cushion, and it feels as though I am walking on a bed of soft, warm stones.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 11,
})

collectible_lore.register_lorebook({
	id = "rose rock rot",
	title = S("The Ecology of Rock Rot and Spongestone"),
	text = S([[Today I encountered a truly remarkable and somewhat terrifying organism- Rock Rot. This aggressive form of lichen seems to have an insatiable appetite for solid rock, eating away at its surface and leaving it rough and spongy. Over time, the rock becomes so riddled with pores and cavities that it is no longer recognizable as such, and is instead referred to as "Spongestone".

While the sight of rock being consumed and transformed by Rock Rot is unnerving, the end result is fascinating. The Spongestone that is produced is rich in minerals and organic material, which allows plants to grow on it as if it were soil. This opens up new opportunities for subterranean agriculture and other forms of life to thrive in areas where they would otherwise not be able to.

Despite my admiration for Rock Rot and its role in the creation of Spongestone, I cannot help but worry about what would happen if it were to spread beyond the caverns and infect the surface world. The thought of this tenacious and voracious organism eating away at the very foundations of civilization is a frightening one. I will continue to study it, but I also recommend caution to any future explorers of caverns containing Rock Rot.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 12,
})

collectible_lore.register_lorebook({
	id = "banks rock rot",
	title = S("Mineral Extraction by Rock Rot"),
	text = S([[Today I was examining the spongestone formation created by rock rot and I must admit, I was impressed by its potential. It is a well-known fact that rock rot is a highly aggressive form of lichen that eats into solid rock and transforms it into something that can barely be called "rock" anymore. The end result, spongestone, is a porous and spongy material that can provide a rich source of minerals.

I believe that rock rot could be harnessed as a tool for extracting minerals from ore bodies that are otherwise difficult to mine. The porosity of spongestone allows for easier access to the minerals contained within, making it a much more cost-effective and efficient method of mining. It would also have the added benefit of reducing the environmental impact of traditional mining methods, as it would require fewer excavation and drilling techniques.

Of course, caution must be exercised when utilizing rock rot for mining purposes. The aggressive nature of the lichen must be monitored closely to prevent it from spreading and potentially causing damage to surrounding structures. However, with proper safety measures in place, I believe that rock rot has the potential to revolutionize the mining industry.

I will continue my research on the subject and report back any further findings.

Signed,
Dr. Theodore Banks]]),
	sort = base + 13,
})

collectible_lore.register_lorebook({
	id = "banks hoar moss",
	title = S("Hoar Moss"),
	text = S([[Today I was able to examine a specimen of hoar moss, a mysterious and highly unusual organism that only occurs in the coldest environments underground. It is a type of greenish-blue crust that forms on the surface of ice-cold water and emits a ghostly light. I had initially assumed it was some form of mineral salt catalyzing an unusual growth of ice crystals but I was quite surprised to discover complex organic structure within it.

Hoar moss is highly resilient and can thrive in extreme conditions where other life forms cannot. Despite its potential scientific value, hoar moss is not well understood and its sensitivity to warmth makes it very difficult to study. Further research is required to understand the significance of this remarkable organism.

Signed,
Dr. Theodore Banks]]),
	sort = base + 14,
})


collectible_lore.register_lorebook({
	id = "rose glow worms",
	title = S("Glow Worms: A False Night in the Depths"),
	text = S([[Wherever there is a substantial amount of moisture, life, and airspace in the deep places of the world, there will be an ecology of flying insect and flying insectivores. And above it all will be the deceptively beautiful star-like galleries of the glow worms, preying on all of those. Glow worms are small carnivorous creatures that form colonies of millions on high cavern ceilings, hanging in chains along nigh-invisible silken threads. They produce a twinkling blue-white glow within their bodies, creating an effect not unlike a starry sky.

That seemingly inviting sky is a trap, however. Creatures that fly into it - whether lured by the lights or simply confused by them - become tangled in the sticky strands and are quickly devoured.

Glow worms are individually quite small and helpless when not suspended among their countless fellows, and don't thrive in caverns that are too dry - they require water for breeding and their silk becomes brittle without some amount of humidity. However, a careful caver can gather a quantity of worms and transplant them to other hospitable locations if they find the light (and pest control) they provide to be appealing. Glow worms are one of the most ubiquitous forms of life down here, found at all depths.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 15,
})


collectible_lore.register_lorebook({
	id = "rose ice sprites",
	title = S("Ice Sprites"),
	text = S([[Today I had the privilege of witnessing a truly remarkable sight. Deep in the @1 caverns, I came across the most beautiful creatures I have ever seen. They were tiny, glowing blue insects that flitted around the tips of the icicles, like tiny fairy lights. I couldn't help but feel enchanted by their beauty.

These creatures are called Ice Sprites and they seem to be perfectly at home in the cold, icy environment of the @2 caverns. Their glow is intermittent, and when it shuts off, they are nigh invisible. I found it fascinating how such a small creature could survive in such a harsh environment.

I was able to capture one of the Ice Sprites and contain it in a jar. I wanted to study it further and understand more about its biology. But as I sat looking at it, I realized that I had no idea how to keep it alive in the long term. I couldn't bring myself to subject it to a slow and painful death in the name of science. So I made the difficult decision to release it back into its natural habitat.

The more I explore these caverns, the more I am amazed by the strange and wonderful forms of life that exist here. The Ice Sprites have added another layer of mystery to the already puzzling biology of the @3 caverns. I am eager to continue my exploration and unravel more of the secrets that lay hidden here.

Sincerely,
Professor Amelia Rose]], df_dependencies.nethercap_name, df_dependencies.nethercap_name, df_dependencies.nethercap_name),
	sort = base + 16,
})


collectible_lore.register_lorebook({
	id = "rose poem 1",
	title = S("Life Beneath the Surface"),
	text = S([[Amid the darkness deep and true,
Where most would fear to venture, too,
A world of wonders I did find,
A place to let my heart unwind.

The caves and tunnels underground,
A world so different, yet profound,
A place where life still finds a way,
And flourishes, night and day.

The spindlestems, they glow so bright,
A sight that takes my breath away,
And in their caps, the secrets kept,
Of minerals and secrets kept.

The dimple cups, with midnight hue,
A dye so rich, it's hard to view,
A treasure trove of beauty rare,
A gift from depths beyond compare.

Pig tails twist and twine with grace,
A fibrous mass of form and space,
The thread they give, a wondrous sight,
A cloth of strength, both day and night.

The plump helmets, thick and round,
A staple food, both there and found,
A sustenance, a common treat,
A delight, both crisp and sweet.

The quarry bushes, zingy blades,
A spicy flavor, well-made,
The nodules, the rock nuts sweet,
A taste that can't be beat.

The sweet pods, with their sugary treat,
A delight for both man and beast,
A gift from life, so rich and true,
A treasure trove, so rare and few.

This world, so hidden, far below,
A world of life, in ebb and flow,
A world I've found, a world so dear,
A place I hold so very near.

	-- Professor Amelia Rose]]),
	sort = base + 17,
})

collectible_lore.register_lorebook({
	id = "rose cave coral",
	title = S("Cave Coral"),
	inv_img = "lorebooks_science.png",
	text = S([[Today I had the chance to witness the most amazing sight deep in the Sunless Sea. The Cave Coral! I have read about it in books, but to see it in person is truly breathtaking. It is a rare form of coral that only grows in the depths of the sea where the dripstone dips into the water, delivering the minerals needed for its skeletal structure. The result is a beautiful, luminescent structure that glows with ever-changing patterns.

As I swam through the darkness of the Sunless Sea, the light from the Cave Coral was a beacon of hope and wonder. It was like nothing I had ever seen before. The coral formations were so intricate, with delicate branches that seemed to glow from within. The light was so bright and pure, it was almost like staring into a star.

The Cave Coral not only adds to the beauty of the Sunless Sea, but it also helps form the foundations of the massive pillars that support the broad ceilings of the sea. It is a vital part of the ecosystem and it is a privilege to be able to witness it in its natural habitat.

Reaching the Cave Coral is not an easy task. The journey down to the Sunless Sea is treacherous, but the reward is more than worth it. The sight of the Cave Coral is a reminder of the beauty and majesty that can still be found in this world, even in the darkest and most remote places. It is a sight that I will never forget and I am grateful for the opportunity to experience it.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 18,
})

collectible_lore.register_lorebook({
	id = "rose castle coral",
	title = S("Castle Coral"),
	inv_img = "lorebooks_science.png",
	text = S([[Today I had the opportunity to see the rare and beautiful Castle Corals in the depths of the Sunless Sea. These formations truly resemble miniature undersea castles, complete with towers and battlements, and their delicate structure and intricate details are a sight to behold.

Getting to see the Castle Corals was no small feat, however. The journey was long and treacherous, and the pressure at such depths is intense. But despite the difficulties, the sight of the Castle Corals was more than worth it. Their delicate beauty is unmatched, and the fact that they can only be found in such a remote and challenging location only adds to their value.

In terms of practical use, the Castle Corals are of little value, as their delicate structure makes them unsuitable for most construction purposes. But for someone like me, who values the beauty and wonder of nature, the Castle Corals are a true treasure.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 19,
})

collectible_lore.register_lorebook({
	id = "rose snareweed",
	title = S("Snareweed"),
	inv_img = "lorebooks_science.png",
	text = S([[Today I had the misfortune of encountering a patch of Snareweed in the Sunless Sea. At first, I was mesmerized by its beauty. Its long, kelp-like fronds shimmered in the light of my lantern, creating a glittering underwater garden. But as I approached, I realized that the reflective patches on its fronds were not simply a trick of the light. They were a trap, luring in unsuspecting creatures with their allure.

I watched in horror as small fish swam towards the Snareweed, only to become entangled in its prickly barbs. They struggled and thrashed, but to no avail. The Snareweed held them fast, leeching the life from their bodies.

I have encountered many dangerous creatures in my explorations of the Sunless Sea, but this plant takes the cake. It is a beautiful and deadly predator all in one. The thought of it lurking in the shadows, waiting to ensnare its next victim, is both fascinating and terrifying.

I must be more careful in the future and avoid areas of dense Snareweed growth. It is a beautiful and deadly reminder of the harsh realities of the subterranean world.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 20,
})

collectible_lore.register_lorebook({
	id = "rose bubblesponge",
	title = S("Bubblesponge"),
	inv_img = "lorebooks_science.png",
	text = S([[Today, I had the privilege of discovering the fascinating and unusual Bubblesponges in the Sunless Sea. These large yellow sponges are unlike anything I have ever seen before, only growing in large bodies of water deep underground.

What makes these sponges truly remarkable is their ability to absorb and store such large amounts of oxygen from the surrounding water. A diver can actually bite down on one of these sponges and take a lungful of air. This is an incredibly useful property, as it enables divers to explore the Sunless Sea without having to constantly resurface for air.

Harvesting these sponges does not diminish their air storage capabilities, but the harvested pieces will not replenish the air on their own. Once the air is gone, the sponge should be discarded. However, if the trunk of the Bubblesponge is left intact, the fronds will regenerate over time.

I am extremely excited about this discovery and its potential implications for exploration in the Sunless Sea. The Bubblesponge is truly a remarkable and unique species of underwater fauna.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 21,
})
