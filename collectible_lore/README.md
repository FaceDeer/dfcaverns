This mod provides a framework for adding "lore" collectibles, entries that are either a block of text or an image. Players unlock these collectibles by finding stone cairns, and view them by using a "satchel" object. Note that players are not literally carrying these collectibles, whether they've been unlocked is recorded globally and any satchel will allow them to view their collection.

This is intended as a somewhat similar concept to achievements, but to reward exploration in general and to provide information about the world the player finds themself in.

An example:

	collectible_lore.register_lorebook({
		id = "banks tunnels",
		title = S("Twisting Tunnels"),
		text = S([[Today's exploration took us deep into the caverns beneath the surface world. As we progressed, I was reminded of the intricate network of passages that make up the bedrock of this world.

	It is fascinating to see how these passages have been carved by a combination of ancient streams and other mysterious processes that have yet to be fully understood. They twist and turn, making navigation a challenging task. Although it is possible to reach almost any location by following these existing passages, they can be so convoluted that it sometimes makes more sense to simply mine a direct route to your destination.

	The significance of these passages cannot be overstated. They provide a glimpse into the geological history of the world and the forces that shaped it. The passages also hold the promise of valuable mineral deposits and other resources, making them a crucial area of exploration for anyone seeking to unlock the secrets of the earth.

	Signed,
	Dr. Theodore Banks]]),
		sort = 101,
	})

The id should be a unique string, this is the key that will be recorded when a player unlocks a collectible. The title is shown in the list of collectibles when it is unlocked. The sort value is used to sort items in the collectible list in increasing order; it doesn't have to be unique, items with the same sort number will fall back to sorting by id.

Instead of text, an image can be shown:

	collectible_lore.register_lorebook({
		id = "rose watercolor chasm wall",
		title = S("Chasm Wall, By Amelia Rose"),
		image = "df_lorebooks_chasm_wall.jpg",
		sort = 201,
	})

Note that currently images and text are mutually exclusive, and images should have a square aspect ratio.

This mod by itself currently only provides a framework and defines the cairn and satchel nodes, you'll need to provide a mapgen to insert them into your world. The ``collectible_lore.place_cairn`` method checks to see if there are nearby cairns before it goes ahead and places a cairn, preventing them from being bunched too closely together, and should prove useful.