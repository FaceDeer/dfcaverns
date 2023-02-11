local S = minetest.get_translator(minetest.get_current_modname())

local base = 100

--Speleothems introduction
collectible_lore.register_lorebook({
	id = "banks speleothems",
	title = S("Speleothems"),
	text = S([[It has previously been established that a great many of the conduits and cavities that lead deep into the stone foundations of the world are carved not by pick or claw, or by any shifting and cracking of the firmament, but rather by the weak but inexorable corrosive power of mere water. Over the aeons, trickles of water passing through pores too tiny even to be seen erode away miniscule portions of matter.

But whence does this matter go? Dissolved into the water it is carried away deeper, and its ultimate destination is yet unknown. But not all of it gets that far. Should the water become over-laden with dissolved stone it may leave some of its burden behind to form new rock. These formations are collectively called \"speleothems\", or \"cave deposits.\" Though the material composition of these speleothems are all the same they are given sub-types based upon their morphology. They are further distinguished as being \"live\" or \"dead\" - live speleothems being those subject to continued growth as mineral-laden water continues to flow over their surfaces, and dead speleothems being remnants whose wellsprings have been staunched.

The most common and well-known speleothems are the stalactites (which grow downward from the ceiling of caves) and stalagmites (which grow upward to meet them), collectively called \"dripstone.\" Formed by a simple slow dripping of water, stalactites and stalagmites often gather into rippled \"curtains\" that follow the hidden cracks through which the water that feeds them flows. When floor and ceiling are close enough and the formations grow long enough they may meet in the middle, forming columns. Small caves may become choked off over the ages as their teeth close shut in this manner.

Where the flow of water follows the walls and floors rather than dripping down from the ceiling, more amorphous structures may be formed that go by the more general term \"flowstone.\"

Signed,
Dr. Theodore Banks]]),
	sort = base + 0,
})



collectible_lore.register_lorebook({
	id = "banks tunnels",
	title = S("Twisting Tunnels"),
	text = S([[Today's exploration took us deep into the caverns beneath the surface world. As we progressed, I was reminded of the intricate network of passages that make up the bedrock of this world.

It is fascinating to see how these passages have been carved by a combination of ancient streams and other mysterious processes that have yet to be fully understood. They twist and turn, making navigation a challenging task. Although it is possible to reach almost any location by following these existing passages, they can be so convoluted that it sometimes makes more sense to simply mine a direct route to your destination.

The significance of these passages cannot be overstated. They provide a glimpse into the geological history of the world and the forces that shaped it. The passages also hold the promise of valuable mineral deposits and other resources, making them a crucial area of exploration for anyone seeking to unlock the secrets of the earth.

Signed,
Dr. Theodore Banks]]),
	sort = base + 1,
})


--The Great Caverns general morphology (major caverns, warrens)

collectible_lore.register_lorebook({
	id = "banks cavern types",
	title = S("A Heirarchy of Caverns"),
	text = S([[Today, I had the opportunity to delve deeper into the caverns beneath the surface of the world. As I explored, I was struck by the sheer diversity of the caves and tunnels that have been carved out by eons of erosion. There is truly a sort of hierarchy in the form taken by these underground features.

Starting with the smallest, we have the narrow, twisty tunnels that pervade the bedrock. These tunnels can lead for long distances and often provide the only access to more spacious galleries. They are the most ubiquitous type of cave in this subterranean realm.

Next up are the occasional hollows where the tunnels have enlarged into more spacious galleries. These areas provide a welcome respite from the cramped conditions of the twisty tunnels and offer a chance to stretch one's legs.

Then there are regions where the rock has been so eroded that it has become a spongey network of caves and passages leading in every direction. This type of cave system is a maze-like labyrinth, and one must be careful not to get lost in its twisting paths.

And finally, there are the vast caverns that are hundreds or even thousands of meters across. These awe-inspiring spaces are where entire mountains' worth of rock have been washed away over the eons, leaving behind caverns of staggering proportions. These spaces are truly otherworldly and offer a glimpse into the immense forces that have shaped the Earth.

Signed,
Dr. Theodore Banks]]),
	sort = base + 2,
})

--Vertical shafts
collectible_lore.register_lorebook({
	id = "banks sinkholes",
	title = S("Sinkholes and Shafts"),
	text = S([[Today's expedition took us deep into the heart of the world's foundation and the incredible geological wonders that reside within. As we descended, I was struck by the sight of the sinkholes that have formed over time due to erosive forces working upon weak spots in the rock layers. These sinkholes are truly a marvel of nature and can descend for thousands of meters, offering access to regions that would be virtually impossible to reach otherwise. The sight of the sun shining down from the surface into the depths is truly breathtaking and serves as a reminder of the incredible forces that have shaped our world.

It is interesting to note that sinkholes are not simply vertical shafts, but also form as a result of the strata of the rock becoming weakened and eventually collapsing. This allows for a clear path to the depths below, where new wonders await our discovery.

I must stress the importance of caution when exploring these sinkholes, as the walls can be brittle and unstable. In the event that valuable resources are found far below, some form of elevator might be rigged within such shafts to allow more reliable access.

Signed,
Dr. Theodore Banks]]),
	sort = base + 3,	
})
--Chasms

collectible_lore.register_lorebook({
	id = "banks chasms",
	title = S("Great Chasms"),
	text = S([[Not all vast open spaces underground are the result of aeons of erosion by water or magma. The foundations of the world shift from time to time, causing deep faults to split open in the rock. Yawning underground chasms can be found in this region oriented along the north-south axis, some of them stretching for kilometers both in length and depth. They cross through multiple cavern layers and are an environment in their own right. Chasms can be a convenient way of traveling long distances if they happen to lead in the correct direction and can also be a convenient way of falling to your death. We have had to construct more than a few bridges to make our way from one side to the other.

The great extent of chasms makes them hospitable to small flying creatures, and their narrowness makes the hospitable to creatures that feed on them - giant cave spider webs can be found strung across them here and there. A dubious salvation for anyone falling from above.

Signed,
Dr. Theodore Banks]]),
	sort = base + 4,
})

--Giant speleothems

collectible_lore.register_lorebook({
	id = "banks towering speleothems",
	title = S("Towering Speleothems"),
	text = S([[Today I had the privilege of exploring one of the most incredible geological wonders I have ever encountered. Deep within the caverns of the underworld lies a region of gigantic stalactites and stalagmites, some reaching up to twenty meters in girth. These speleothems are truly awe-inspiring and I can hardly believe that they have formed over eons of mineral deposits and slow dripping water.

As I walked among these titanic structures, I couldn't help but feel a sense of wonder at the sheer scale of them. They appear to be pillars supporting the very fabric of the caverns themselves, and I can only imagine the immense geological forces that have shaped and formed these geological wonders over such an incredible span of time.

Despite my extensive knowledge and experience in geology, I must admit that I still cannot fully grasp the processes behind the creation of these massive formations. It is a humbling reminder of the limitations of our understanding and the boundless mysteries that still remain hidden in the depths of our planet.

I have collected samples of the mineral deposits from the formations for further study and analysis, but for now I am content to simply bask in the beauty and majesty of these incredible structures. I am eager to continue exploring this region and uncovering more of the secrets it holds.

Signed,
Dr. Theodore Banks]]),
	sort = base + 5,
})

--Mine gas

collectible_lore.register_lorebook({
	id = "banks mine gas",
	title = S("Mine Gas"),
	text = S([[Today I explored the depths of the world beneath the Sunless Sea and discovered a dangerous but fascinating new substance - mine gas. This explosive and unbreatheable vapor originates from the ancient organic remnants of life that have been pressed and baked into minerals. Coal and oil are well known forms of this substance, but the gaseous form is far more volatile and can pose a significant threat to those exploring the deep caverns.

In the living caverns, the strange biology filters and purifies the air, and even torchspines seem to thrive on it. But in the deeps, there is no life to clean the air, and the twisting passages don't allow it to disperse easily. This makes it deadly dangerous. Mine gas is heavier than air, so it pools in hollows and dips in passages, and since it can't be swum in, a traveler must always have a way to climb quickly back out should they find themselves without air.

Additionally, mine gas mixed with breathable air can explode violently when exposed to a spark or heat source such as a torch. This makes it imperative that caution is exercised when exploring these areas. I will be sure to take all necessary precautions and make note of the locations of any significant pockets of mine gas in my maps to ensure the safety of future explorers.

Signed,
Dr. Theodore Banks]]),
	sort = base + 6,	
})

--gas wisps

collectible_lore.register_lorebook({
	id = "banks gas wisps",
	title = S("Gas Wisps"),
	text = S([[Today I encountered the mysterious blue flames known as gas wisps. These self-sustaining flames are found flickering on the edges of oil lakes and are able to burn without the presence of oxygen. Despite my attempts, I have been unable to capture or perform any tests on these wisps as they seem to disappear when deprived of access to mine gas.

The behavior of these wisps is intriguing, as they seem to exhibit some signs of life, moving slowly about, but without any evidence, I refuse to speculate on such a thing. The lack of data on these wisps is frustrating, and I will continue to try and gather more information on their nature and behavior.

I have noticed that the presence of gas wisps is often an indicator of a high concentration of mine gas, making their vicinity one of the most inhospitable regions I have encountered. Despite the dangers, I will continue to explore these caverns and uncover the secrets they hold.

Signed,
Dr. Theodore Banks]]),
	sort = base + 7,
})

--oil sea
collectible_lore.register_lorebook({
	id = "banks oil sea",
	title = S("The Oil Seas"),
	text = S([[Today I had the opportunity to explore one of the more unique geological features of the underground caverns: the lakes of oil. These vast reservoirs of liquid are found in giant cavities that are believed to have formed from pressure separating and forcing open the seams of the rock, rather than from erosion.

The oil is thick, black, and flows slowly, and it is flammable enough to be used as a fuel source. However, it is not so flammable that it can be set alight where it stands, as there is not enough air for it to burn. This lack of air is due to the presence of mine gas, which is also present in these caverns.

The combination of oil and mine gas makes these caverns one of the most inhospitable regions I have encountered so far. The atmosphere is unbreathable, and the oil is not suitable for swimming, so one must always be prepared to find a way to climb quickly back out should they find themselves without air. If a traveller brought means to breathe while swimming deep in the Sunless Sea those tools may prove of continued use while traveling here.

Despite these challenges, the lakes of oil are a unique and fascinating geological feature, and I look forward to further exploring and studying them in the future.

Signed,
Dr. Theodore Banks]]),
	sort = base + 8,
})

--magma sea
collectible_lore.register_lorebook({
	id = "banks magma sea",
	title = S("The Magma Sea"),
	text = S([[Today I ventured into the depths of the Magma Sea, a region where the very foundation of our world lies. The journey to reach this region was a perilous one, and I was only able to make it because of the advanced protective gear I was equipped with.

As I delve deeper, the heat here was nearly unbearable, and it is a wonder that anything could survive in these conditions. The Magma Sea is not a true sea, but rather a labyrinth of tunnels and caves filled with molten rock, with a few large magma bodies located at the roots of volcanoes.

Despite the intense heat and danger, I was driven to explore this area, as it is a source of one of the rarest minerals in the world. I was fortunate enough to come across some glowing crystals, suspended from the ceilings of lava tubes in the hottest regions of the Magma Sea. These crystals are suffused with a strange power, and their radiance is nothing short of breathtaking. It is truly a remarkable sight to behold. There is also obsidian found in abundance here.

However, the dangers in this region are not to be underestimated, as the heat can cause serious damage to one's equipment, and the molten rock could easily trap and consume any unwary traveler. Despite this, the potential rewards of exploring the Magma Sea make it all worth it, as the discovery of these glowing crystals is a major step forward in our understanding of the inner workings of our world.

Signed,
Dr. Theodore Banks]]),
	sort = base + 9,
})

--sunless sea
collectible_lore.register_lorebook({
	id = "banks sunless sea",
	title = S("The Sunless Sea"),
	text = S([[The Sunless Sea is an awe-inspiring place, a true marvel of the underground world. The water that fills these caverns, so vast and broad that it would make even the grandest of lakes seem small in comparison, is the ultimate destination for all the streams and rivers that flow down from above. The ceilings are held aloft by massive columns of cave coral, supporting the weight of the worlds above and creating a stunning visual spectacle.

The shores of the Sunless Sea are teeming with life, a mix of many different forms that have made their way down from the living caverns above. The nutrients washing down from above and minerals welling up from hydrothermal sources below have combined to make this one of the most biologically rich regions of the known caverns. The proliferation of life here is truly staggering, and I feel as though I've discovered a new world every time I visit.

In addition to the large underground lakes, there is a network of rivers connecting them all, resulting in a consistent underground "sea level" shared across the known world. This allows for travel by boat, a unique mode of transportation in the caverns, providing access to areas that would otherwise be unreachable. I theorize that one could theoretically navigate to anywhere in the world by boat on these river passages, making the Sunless Sea a vital hub for underground exploration and trade.

This abundance of water does make penetrating to deeper elevations difficult, however. Either some form of underwater breathing system or the excavation of watertight passages is required to reach below.

Signed,
Dr. Theodore Banks]]),
	sort = base + 10,
})

--volcano vents

collectible_lore.register_lorebook({
	id = "banks volcanoes",
	title = S("Volcanoes"),
	text = S([[It is well known to the layperson what a volcano looks like - a great conical pile of rock, a mountain, with a crater at its peak that sometimes spews smoke and fire and coats its flanks with fresh grey ash. However, this is only the tip of the proverbial iceberg. The surface vent of a volcano is merely the uppermost extent of a deep upwelling of magma, channelled through a pipe that rises from a source kilometers below. Magma rises through this narrow, twisting pipe - pushed from below by immense heat and pressure - and the mountain that forms is only the trace encrustations of what overflows.

The pressure from beneath waxes and wanes over the geological epochs, and so not all volcanoes are equal in their activity. Many have gone quiescent over the years, their throats choked with cooled magma. Others merely sleep, with magma boiling just below the surface ready to flood forth. One may gain a rough estimate of how long it has been since a volcano last erupted by the sorts of vegetation clinging to its slopes - the longer it has been, the more and larger vegetation has gained a foothold. But beware, this does not guarantee how long it will be until the next eruption in the volcano's future.

What is the ultimate source of a volcano's magma? This is a mystery that will require a mighty expedition indeed to resolve. It is known that, generally speaking, the deeper one travels underground the greater the ambient temperature and pressure becomes. But this generality has many localized anomalies, volcanic pipes being only the most obvious. Based on these general gradients it is thought that magma may originate some three kilometers underground.

Signed,
Dr. Theodore Banks]]),
	sort = base + 11,
})



--Cave pearls
collectible_lore.register_lorebook({
	id = "banks pearls",
	title = S("Cave Pearls"),
	text = S([[During my explorations of the underground world, I have come across a truly fascinating form of mineral deposit known as cave pearls. These delicate, glowing formations can be found studding the walls of tunnels in various locations and are characterized by their calcium-rich composition. The source of their faint luminescence is still a mystery to me, but it is possible that some form of phosphorescent microorganisms may be involved in their creation.

Aside from their aesthetic appeal, these cave pearls also serve a practical purpose. Their smooth, round shape and solid composition make them excellent handholds when climbing treacherous walls. This has proven to be a lifesaving feature on more than one occasion, as the underground world can often be a treacherous and inhospitable place.

However, despite their practicality, it is the origin of these cave pearls that has captured my imagination the most. Whether they are formed purely through geological processes or with the help of some kind of living action, like the more well-known pearls of the surface world, remains a mystery. I plan to continue my research into this fascinating subject and hope to uncover more about these intriguing formations.

Signed,
Dr. Theodore Banks]]),
	sort = base + 12,
})
-- giant ruby crystals
collectible_lore.register_lorebook({
	id = "banks ruby crystals",
	title = S("Ruby Crystals"),
	inv_img = "lorebooks_science.png",
	text = S([[Today I have encountered something truly remarkable in one of the hotter caverns. Growing from the floors and ceilings are clusters of large red hexagonal crystals, some larger than a man is tall, each glowing with an inner light. The crystals have a quartz-like composition but the red color and luminosity suggest that there is an unknown impurity present. I speculate that these crystals grow from smaller crystals embedded in veins of ore in the rock, but further investigation is needed to confirm this theory. These magnificent formations are unlike anything I have seen before, and I am eager to study them in greater detail. However, the extreme heat of the caverns presents a challenge for conducting any in-depth analysis. Nevertheless, I will not let this deter me from uncovering the secrets of these incredible crystals.

Signed,
Dr. Theodore Banks]]),
	sort = base + 13,
})
-- veinstone
collectible_lore.register_lorebook({
	id = "banks veinstone",
	title = S("Veinstone"),
	text = S([[Today I had the displeasure of encountering Veinstone, one of the most unnerving mineral formations I have come across in my explorations. This mineral forms a web-like pattern of ridges on the inner surface of some large and otherwise-barren caverns, with a reddish pattern of mineral inclusions and a faint internal glow.

The glow itself is not entirely unusual, as other minerals in these deep places have a similar feature, but Veinstone reacts in a unique way when struck even with a light blow. Upon striking, Veinstone releases a brief pulse of brighter glow accompanied by a deep thudding sound that originates from within the mineral. Adjacent regions of Veinstone respond in a similar manner, resulting in a cascade of deep thudding and glowing spots that travel slowly along the ridges covering the interior of the cave.

This reaction of Veinstone is particularly unsettling, as it almost feels like the entire cavern is one enormous living creature and I am but an insect crawling around inside it. The pulses split at forks and even occasionally become trapped circling around loops of Veinstone for long periods of time.

In conclusion, Veinstone remains one of the most unique and fascinating mineral formations I have encountered. Further study is required to determine the nature and origin of this mineral and its strange reaction to stimuli.

Signed,
Dr. Theodore Banks]]),
	sort = base + 14,
})
-- pink salt crystals
collectible_lore.register_lorebook({
	id = "banks salt crystals",
	title = S("Salt Crystals"),
	text = S([[Today I ventured into the hot, dry, sandy caverns where bloodthorns grow. It is an inhospitable environment, but one that holds unique geological wonders. Along the cracks and seams where water enters these caverns, I found encrustations of salt. The water that seeps in is immediately siphoned away by the thirsty air and vegetation, leaving behind the minerals it carried with it. These salt crystals have a pinkish hue and a faint inherent glow that suggest similar impurities to the larger quartz crystals found in similarly hot places, but in a much less impressive form. The salt crystals are a testament to the harsh environment and the relentless processes that shape and change the underground world. Further study of these minerals could provide insights into the geological history of these caverns.

Signed,
Dr. Theodore Banks]]),
	sort = base + 15,
})

