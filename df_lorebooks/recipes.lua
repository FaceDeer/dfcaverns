local S = minetest.get_translator(minetest.get_current_modname())

df_lorebooks.register_lorebook({
	title = "lorebooks:cave_wheat_biscuit",
	desc = S("Cave Wheat Flour Biscuit Recipe"),
	inv_img = "lorebooks_science.png",
	text = S([[Ingredients:

    2 cups cave wheat flour
    1/4 cup cave wheat seeds
    1 tbsp. baking powder
    1 tsp. salt
    1/2 cup unsalted butter, chilled and cut into small pieces
    1/2 cup buttermilk

Instructions:

    Preheat oven to 425°F (220°C). Line a baking sheet with parchment paper.
    In a large bowl, whisk together the cave wheat flour, cave wheat seeds, baking powder, and salt.
    Add the chilled butter pieces to the flour mixture and use a pastry cutter or your fingers to cut the butter into the flour until the mixture resembles coarse crumbs.
    Add the buttermilk to the flour mixture and stir until just combined.
    Turn the dough out onto a lightly floured surface and knead gently a few times until the dough comes together.
    Roll the dough out to about 1/2 inch thickness.
    Cut out biscuits using a round cookie cutter or the top of a glass.
    Place the biscuits on the prepared baking sheet and bake for 12-15 minutes, or until golden brown on the outside and cooked through.
    Serve the biscuits warm with butter, honey or jam, if desired. Enjoy!]]),
	author = S(""),
	date = "",
})

df_lorebooks.register_lorebook({
	title = "lorebooks:cave_wheat_buns",
	desc = S("Cave Wheat Bun Recipe"),
	inv_img = "lorebooks_science.png",
	text = S([[Ingredients:

    2 cups of cave wheat flour
    1 cup of all-purpose flour (if not enough cave wheat flour is available)
    2 teaspoons of sugar
    2 teaspoons of yeast
    1/2 teaspoon of salt
    1/4 cup of warm water
    1 egg
    1/4 cup of melted butter
    1/4 cup of cave wheat seeds
    1 tablespoon of sugar for topping

Instructions:

    In a large mixing bowl, combine the cave wheat flour, all-purpose flour, 2 teaspoons of sugar, yeast, and salt. Stir well to mix.
    In a separate small bowl, mix together the warm water, egg, and melted butter.
    Slowly add the wet mixture to the dry mixture, kneading it together until the dough is smooth and elastic.
    Add the cave wheat seeds to the dough, kneading until evenly distributed.
    Cover the dough and let it rise for about an hour in a warm place, or until it has doubled in size.
    Preheat the oven to 375°F (190°C).
    Roll out the dough on a floured surface to about 1/2 inch thick.
    Cut the dough into circles with a cookie cutter or a glass.
    Place the buns on a lined baking sheet, brush the tops with a beaten egg, and sprinkle with the remaining 1 tablespoon of sugar.
    Bake the buns in the oven for 15-20 minutes, or until they are golden brown and have fully cooked through.
    Serve the Cave Wheat Flour Buns warm with your favourite spread or toppings. Enjoy!]]),
	author = S(""),
	date = "",
})

df_lorebooks.register_lorebook({
	title = "lorebooks:cave_wheat_seed_loaf",
	desc = S("Cave Wheat Seed Loaf Recipe"),
	inv_img = "lorebooks_science.png",
	text = S([[Ingredients:

    1 cup of cave wheat seeds
    1 cup of all-purpose flour
    1 cup of warm water
    1 tbsp. of active dry yeast
    1 tsp. of sugar
    1 tsp. of salt
    2 cups of finely chopped plump helmet mushrooms
    2 tbsp. of olive oil
    2 cloves of garlic, minced
    2 tbsp. of chopped fresh rosemary

Instructions:

    In a large bowl, combine the cave wheat seeds, flour, sugar, and salt. Stir to combine.
    In a separate bowl, mix the warm water and yeast. Let it sit for about 5 minutes until the yeast is activated and bubbly.
    Add the yeast mixture to the dry ingredients and stir until a dough forms.
    Knead the dough on a floured surface for about 10 minutes, until the dough is smooth and elastic.
    Place the dough in a greased bowl, cover with plastic wrap, and let it rise in a warm place for about 1 hour, or until doubled in size.
    In a pan, heat the olive oil over medium heat. Add the garlic and rosemary and cook until fragrant.
    Add the chopped plump helmet mushrooms to the pan and cook until they are tender and any liquid has evaporated.
    Preheat the oven to 400°F (200°C).
    On a floured surface, roll out the dough into a large rectangle.
    Spread the mushroom mixture evenly over the dough. Roll the dough into a tight loaf, tucking the edges underneath.
    Place the loaf on a baking sheet lined with parchment paper and bake for 30-35 minutes, or until the crust is golden brown and the loaf sounds hollow when tapped.
    Let the loaf cool for a few minutes before slicing and serving. Enjoy your delicious Cave Wheat Seed Loaf with a drizzle of olive oil and a sprinkle of coarse salt.]]),
	author = S(""),
	date = "",
})

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S("Cave Wheat Seed Puff Recipe"),
	inv_img = "lorebooks_science.png",
	text = S([[Ingredients:

    2 cups of cave wheat seeds
    2 tablespoons of sugar
    1/4 teaspoon of salt
    1/2 teaspoon of baking powder
    1/2 cup of all-purpose flour
    1/2 cup of water

Instructions:

    Preheat the oven to 350°F (180°C). Line a baking sheet with parchment paper.
    In a large bowl, mix the cave wheat seeds, sugar, salt, baking powder, and flour.
    Slowly add water and stir until a batter forms. The batter should be slightly thicker than a pancake batter.
    Spoon spoonfuls of the batter onto the prepared baking sheet, about 2 inches apart.
    Bake for 12-15 minutes or until the puffs are golden brown and puffed up.
    Serve warm and enjoy your delicious Cave Wheat Seed Puffs.

Tip: You can sprinkle a little extra sugar over the puffs before serving for extra sweetness. Enjoy!]]),
	author = S(""),
	date = "",
})

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:cave_wheat_seed", "df_farming:cave_wheat_seed", "df_farming:pig_tail_seed", "df_farming:plump_helmet_spawn"}, name=S("Cave Wheat Seed Risotto"), image="dfcaverns_prepared_food14x16.png", sound = gummy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:sweet_pod_seed", "group:food_flour"}, name=S("Sweet Pod Spore Dumplings"), image="dfcaverns_prepared_food09x16.png", sound = mushy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:sweet_pod_seed", "group:food_flour", "group:sugar"}, name=S("Sweet Pod Spore Single Crust Pie"), image="dfcaverns_prepared_food05x16.png", sound = mushy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:sweet_pod_seed", "group:sugar", "group:food_flour", "df_farming:dwarven_syrup_bucket"}, replacements={{"df_farming:dwarven_syrup_bucket", bucket_empty}}, name=S("Sweet Pod Spore Brule"), image="dfcaverns_prepared_food22x16.png", sound = soft},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:sugar", "group:food_flour"}, name=S("Sweet Pod Sugar Cookie"), image="dfcaverns_prepared_food02x16.png", sound = crisp},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:sugar", "group:food_flour", "df_farming:quarry_bush_leaves"}, name=S("Sweet Pod Sugar Gingerbread"), image="dfcaverns_prepared_food21x16.png", sound = chomp},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:sugar", "group:sugar", "group:food_flour", "group:food_flour"}, name=S("Sweet Pod Sugar Roll"), image="dfcaverns_prepared_food25x16.png", sound = crisp},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"group:plump_helmet", "group:plump_helmet"}, name=S("Plump Helmet Mince"), image="dfcaverns_prepared_food15x16.png", sound = mushy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"group:plump_helmet", "group:plump_helmet", "df_farming:quarry_bush_leaves"}, name=S("Plump Helmet Stalk Sausage"), image="dfcaverns_prepared_food18x16.png", sound = gummy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"group:plump_helmet", "group:food_flour", "df_farming:plump_helmet_spawn", "df_farming:quarry_bush_leaves"}, name=S("Plump Helmet Roast"), image="dfcaverns_prepared_food04x16.png", sound = mushy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:plump_helmet_spawn", "group:plump_helmet"}, name=S("Plump Helmet Spawn Soup"), image="dfcaverns_prepared_food10x16.png", sound = gummy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:plump_helmet_spawn", "df_farming:quarry_bush_seed", "group:plump_helmet"}, name=S("Plump Helmet Spawn Jambalaya"), image="dfcaverns_prepared_food01x16.png", sound = soft},
df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:plump_helmet_spawn", "df_farming:plump_helmet_spawn", "group:plump_helmet", "group:plump_helmet"}, name=S("Plump Helmet Sprout Stew"), image="dfcaverns_prepared_food26x16.png", sound = gummy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:quarry_bush_leaves", "df_farming:cave_bread"}, name=S("Quarry Bush Leaf Spicy Bun"), image="dfcaverns_prepared_food23x16.png", sound = soft},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:quarry_bush_leaves", "group:food_flour", "group:plump_helmet"}, name=S("Quarry Bush Leaf Croissant"), image="dfcaverns_prepared_food29x16.png", sound = soft},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:quarry_bush_leaves", "group:plump_helmet", "group:plump_helmet", "group:plump_helmet"}, name=S("Stuffed Quarry Bush Leaf"), image="dfcaverns_prepared_food27x16.png", sound = chomp},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:quarry_bush_seed", "df_farming:cave_bread"}, name=S("Rock Nut Bread"), image="dfcaverns_prepared_food16x16.png", sound = soft},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:quarry_bush_seed", "group:food_flour", "group:sugar"}, name=S("Rock Nut Cookie"), image="dfcaverns_prepared_food07x16.png", sound = chomp},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:quarry_bush_seed", "group:sugar", "df_farming:sweet_pod_seed", "group:food_flour"}, name=S("Rock Nut Cake"), image="dfcaverns_prepared_food03x16.png", sound = soft},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:dimple_cup_seed", "group:food_flour"}, name=S("Dimple Cup Spore Flatbread"), image="dfcaverns_prepared_food12x16.png", sound = crisp},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:dimple_cup_seed", "group:food_flour", "group:sugar"}, name=S("Dimple Cup Spore Scone"), image="dfcaverns_prepared_food32x16.png", sound = chomp},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:dimple_cup_seed", "df_farming:sweet_pod_seed", "df_farming:quarry_bush_seed", "group:food_flour"}, name=S("Dimple Cup Spore Roll"), image="dfcaverns_prepared_food31x16.png", sound = soft},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:pig_tail_seed", "df_farming:cave_bread"}, name=S("Pig Tail Spore Sandwich"), image="dfcaverns_prepared_food20x16.png", sound = soft},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:pig_tail_seed", "df_farming:pig_tail_seed", "df_farming:dwarven_syrup_bucket"}, name=S("Pig Tail Spore Tofu"), replacements={{"df_farming:dwarven_syrup_bucket", bucket_empty}}, image="dfcaverns_prepared_food30x16.png", sound = gummy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:pig_tail_seed", "df_farming:sweet_pod_seed", "group:food_flour", "group:food_flour"}, name=S("Pig Tail Spore Casserole"), image="dfcaverns_prepared_food34x16.png", sound = mushy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:dwarven_syrup_bucket", "df_farming:dwarven_syrup_bucket"}, replacements={{"df_farming:dwarven_syrup_bucket", bucket_empty}, {"df_farming:dwarven_syrup_bucket", bucket_empty}}, name=S("Dwarven Syrup Taffy"), image="dfcaverns_prepared_food19x16.png", sound = gummy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:dwarven_syrup_bucket", "group:sugar", "group:plump_helmet"}, replacements={{"df_farming:dwarven_syrup_bucket", bucket_empty}}, name=S("Dwarven Syrup Jellies"), image="dfcaverns_prepared_food06x16.png", sound = gummy},

df_lorebooks.register_lorebook({
	title = "lorebooks:",
	desc = S(""),
	inv_img = "lorebooks_science.png",
	text = S([[]]),
	author = S(""),
	date = "",
}){recipe = {"df_farming:dwarven_syrup_bucket", "group:food_flour", "group:sugar", "df_farming:quarry_bush_seed"}, replacements={{"df_farming:dwarven_syrup_bucket", bucket_empty}}, name=S("Dwarven Syrup Delight"), image="dfcaverns_prepared_food24x16.png", sound = mushy},

