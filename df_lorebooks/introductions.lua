--[[

Name: Dr. Theodore Banks

Background: Dr. Theodore Banks is a renowned geologist and prospector who has made a name for himself in the field of mineral exploration. He was born to a family of miners and has always had a passion for geology and the earth sciences. He received his PhD in geology from a prestigious university and has been working as a prospector for various mining companies and royal patrons for many years. His expertise in mineralogy and geochemistry has led him to discover many rich ore deposits and valuable mineral specimens. He is also a skilled cartographer and surveyor, and is able to accurately map and document his discoveries. He has been commissioned by Queen Isabella of Aragon to explore the caverns in search of new mineral deposits and bring back samples for further study. He is known for his meticulous attention to detail and his ability to make accurate predictions about mineral deposits based on the geology of an area. He is determined to make the greatest discovery of his career and is willing to take great risks to achieve it. He travels with a team of engineers and laborers.

This explorer's background allows for him to be obsessed with discovering new minerals and rocks, also his academic background and job history as a prospector make him a reliable and experienced explorer. He is also a skilled cartographer and surveyor, which will come in handy in the underground caverns.


Name: Professor Amelia Rose

Background: Professor Amelia Rose is a renowned naturalist and botanist who has dedicated her life to the study of plants and their ecosystems. Born and raised in a small village surrounded by lush forests and meadows, she developed a deep appreciation for the natural world from a young age. She received her Ph.D in botany from a prestigious university and has been working as a professor of botany and ecology for many years.

She is known for her deep understanding of the complex relationships between plants and their environment, and her ability to identify and classify new species with ease. She is also a skilled artist, and often illustrate her findings in her journals with detailed drawings and watercolors. She has been commissioned by the same royal patron as Dr. Banks, Queen Isabella, but her main goal is to document and classify the new species that she finds in the caverns, and study the interactions between them, and how they adapt to the underground environment. She is known for her poetic and artistic way of describing the natural world and her passion for discovery.

This explorer is distinct from Dr. Banks as she has a different set of skills, expertise and interests. She is a naturalist and botanist, which means she is interested in the ecological details of what she discovers and is skilled in classifying and identifying new species of plants. She's also a skilled artist, which helps her in documenting her findings and describing the natural world in a poetic and artistic way. She travels with a group of graduate students.

These two know each other and will be rivals, each denigrating the others' approach to exploration and choice of focus in their logs. Banks thinks Rose is flighty and airheaded, Rose thinks Banks is callous and has no appreciation for beauty.


Name: Sir Reginald Sterling

Background: Sir Reginald Sterling is a wealthy and adventurous nobleman who is driven by a desire for fame and glory. He has always been fascinated by tales of exploration and discovery, and has spent much of his fortune funding expeditions to far-off lands. He is a skilled hunter and marksman and is also a trained archaeologist. He decided to explore the caverns on his own initiative, driven by his desire to be the first to see fantastic sights and to plant his personal flag.

Sir Sterling's early logs would detail his initial excitement and wonder at the fantastic sights he encountered in the caverns, as well as his attempts to claim them in the name of himself. He would write about the challenges he faced and the obstacles he overcame, as well as the unique features and discoveries he made. However, as he ventured deeper into the caverns, he began to encounter strange and terrifying creatures, and artifacts of ancient eldritch civilizations that began to unsettle him. He started to become paranoid and delusional, and his later logs would become increasingly disjointed and difficult to understand, filled with rambling and incoherent musings about the horrors he had encountered. Despite this, the logs could still contain valuable information and secrets hidden among his madness.

This explorer is distinct from Dr. Banks and Professor Rose as he is not a scientist but a gentleman adventurer, and his main goal is not scientific discovery but fame and glory. He is driven by his desire to be the first to see fantastic sights and to plant his personal flag. He's also a skilled hunter and marksman and is a trained archaeologist, which help him in his journey to the caverns. He's the first explorer to enter the caverns and he's the one who faced the ancient eldritch horrors deep beneath the Earth that broke his mind. He wasn't commissioned by any royal patron but he came here on his own initiative.

]]--

local S = minetest.get_translator(minetest.get_current_modname())

local base = 10

-- Introductory entries:

collectible_lore.register_lorebook({
	id = "banks intro 1",
	title = S("Introducing Dr. Theodore Banks"),
	text = S([[I, Dr. Theodore Banks, have been commissioned by her most Royal Highness Queen Isabella of Aragon to lead an expedition into the vast underground caverns in search of valuable resources to mine. My team consists of experienced engineers and labourers, all of whom are well-equipped and trained to face the challenges that lie ahead.

We have set up a base camp deep within the caverns and have begun our descent. Our goal is to explore the depths of these caverns, mapping out their geology and identifying any potential mineral deposits. We have brought with us a wide range of tools and equipment, including rock hammers, chisels, drills, timber scaffold, block and tackle, and ample supplies of torches and other such caving necessities.

I am filled with hope and excitement at the prospect of what we might discover. The caverns are vast and unknown, and I have no doubt that we will uncover many wonders and treasures. We will document our findings in these logs, which will be sent back to our patron for review.

I look forward to the challenges and adventures that lie ahead. With the help of my team, I am confident that we will be able to uncover the secrets of these caverns and bring back riches and resources that will benefit our patron and our nation.

Signed,
Dr. Theodore Banks, Geologist and Leader of the Expedition.]]),
	sort = base + 0,
})

collectible_lore.register_lorebook({
	id = "banks intro 2",
	title = S("First Steps of Dr. Theodore Banks"),
	text = S([[We have finally succeeded in our mission to reach the underground caverns. After months of evaluating the subtle stratigraphy and erosion patterns of the surface land, I identified a region that I considered most likely to be underlain by a gigantic cavern. I ordered my team of engineers and laborers to begin digging an access shaft to allow direct access to the cavern.

After weeks of hard work, we finally breached the roof of the cavern at a depth of 300 yards. The sight that greeted us was truly breathtaking. The floor of the cavern was hundreds of yards deeper and stretched out as far as the eye could see. The sheer size of the cavern is difficult to comprehend.

Unfortunately, during the final stages of the excavation, one of my workers fell through the roof and was lost. We have rigged up a system of ropes for the rest of us to safely reach the floor of the cavern and bring supplies down for further expeditions.

Now that we have access to the cavern, we can begin our true mission: to search for valuable resources and to make new discoveries. I have high hopes for what we will find in these underground depths, and I am confident that my team and I are up to the task.

Signed,
Dr. Theodore Banks]]),
	sort = base + 1,
})

collectible_lore.register_lorebook({
	id = "rose intro 1",
	title = S("Introducing Professor Amelia Rose"),
	text = S([[Dear Journal,

Today marks the beginning of my journey into the depths of the unknown. Accompanied by a team of dedicated graduate students, we set out to uncover the secrets of the underground world. Our focus is on the study of the unique flora and fauna that dwell within these caverns, and to uncover the ecological relationships that sustain them.

We have brought with us a plethora of scientific equipment and resources, as well as a boundless sense of curiosity and wonder. Our goal is to return with a comprehensive understanding of this underground ecosystem, and to use that knowledge to better understand the world above.

As we embark on this journey, I am reminded of a line from a favorite poem:

"And into the forest I go, to lose my mind and find my soul"

I anticipate that this journey will be both challenging and rewarding, and I look forward to the discoveries that lie ahead.

Sincerely,
Professor Amelia Rose.]]),
	sort = base + 2,
})

collectible_lore.register_lorebook({
	id = "rose intro 2",
	title = S("First Steps of Professor Amelia Rose"),
	text = S([[Dear Journal,

Today I ventured out into the local markets in search of rare and unique mushrooms. I have been studying the local flora for some time now and have come across several specimens that do not seem to originate from any known ecosystem. I was determined to find the source of these mushrooms and learn more about the strange and unusual environments they come from.

After much searching, I finally came across a group of merchants who were selling these mysterious mushrooms. I struck up a conversation with them and, through a combination of bargaining and charm, I managed to gain their trust. They revealed to me that the mushrooms came from a series of underground caverns that lay deep beneath the earth.

I was thrilled at this discovery and immediately set out to learn more about these caverns. The merchants were kind enough to provide me with a rough map and some basic instructions on how to reach them. I quickly gathered my graduate students and we set out on our journey.

We traveled for several days, through treacherous terrain and difficult conditions, but finally, we reached the entrance to the caverns. As we descended into the depths, I couldn't help but feel a sense of excitement and wonder. This was truly an adventure of a lifetime, and I can't wait to see what lies ahead.

Sincerely,
Professor Amelia Rose]]),
	sort = base + 3,
})

collectible_lore.register_lorebook({
	id = "ster into 1",
	title = S("Introducing Sir Reginald Sterling"),
	text = S([[Dear Members of the Royal Adventurers Society,

I write to you from the edge of the unknown, where I prepare to embark on an adventure that I fear may be the greatest of my life. I have come to a land of untold riches, where legends and myths have led me to believe that there is a wealth of ancient treasures waiting to be discovered.

I have brought with me all of the supplies and equipment necessary for an expedition of this magnitude, including a team of the bravest and most skilled men I could find. We are ready to face any danger and overcome any obstacle that may come our way.

I know that many of you may be envious of the opportunity that I have been given, but I assure you that the danger is very real. I have heard tales of ancient monsters and eldritch horrors that lurk in the depths of these caverns, waiting to claim the souls of the unwary. But I am not afraid, for I know that the rewards of this adventure will be worth any risk.

I will write to you again soon, with tales of the wonders and terrors that I have encountered on this journey.

Yours in adventure,
Sir Reginald Sterling]]),
	sort = base + 4,
})

collectible_lore.register_lorebook({
	id = "ster intro 2",
	title = S("First Steps of Sir Reginald Sterling"),
	text = S([[Dear Members of the Royal Adventurers Society,

I write to you today from the wilds of the unexplored, with news of my latest discovery. After weeks of traversing the small natural caves that riddled the landscape, I found myself growing increasingly frustrated with the cramped darkness and lack of excitement. But I refused to be deterred, and I knew that a true adventurer never gives up.

So, I decided to take a break from the caves and embark on a safari on the surface. It was there, amidst the lush greenery and majestic animals, that I stumbled upon an incredible sight: an incredibly deep sinkhole. I knew at once that this was my chance to finally reach the deep caverns.

With much rope and the help of my trusty guides, I descended into the sinkhole, and what I found was beyond my wildest dreams. The caverns beneath were unlike anything I had ever seen before - vast and labyrinthine, with strange and exotic flora and fauna. I knew that this was the place I had been searching for, and I was determined to uncover all of its secrets.

I look forward to sharing more of my discoveries with you in the future. Until then, I remain,

Yours in adventure,
Sir Reginald Sterling]]),
	sort = base + 5,
})

