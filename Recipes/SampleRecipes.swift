//
//  SampleRecipes.swift
//  Recipes
//
//  Created by Riley Marshall on 12/3/23.
//

import Foundation
import SwiftData

// See https://stackoverflow.com/a/36827996

struct ResponseData: Decodable {
    var recipes: [SampleRecipe]
}

struct SampleRecipe : Decodable {
    var title: String
    var author: String
    var date: Date
    var timeRequired: String
    var servings: String
    var expertiseRequired: String
    var caloriesPerServing: String
    var ingredients: String
    var instructions: String
    var category: String
    var favorite: Bool
}

let italianCategory = RecipeCategory(id: UUID(), name: "Italian", recipes: [])
let quickMealsCategory = RecipeCategory(id: UUID(), name: "Quick Meals", recipes: [])
let healthyCategory = RecipeCategory(id: UUID(), name: "Healthy", recipes: [])
let sideAndSaladDishCategory = RecipeCategory(id: UUID(), name: "Salads and Sides", recipes: [])
let mainDishCategory = RecipeCategory(id: UUID(), name: "Main Dish", recipes: [])
let dessertsCategory = RecipeCategory(id: UUID(), name: "Desserts", recipes: [])
let condimentCategory = RecipeCategory(id: UUID(), name: "Condiments", recipes: [])

let sampleRecipes = [
    Recipe(
        title: "Classic Margherita Pizza",
        author: "Chef GoodTaste",
        date: Date(),
        timeRequired: "30 mins",
        servings: "2-3",
        expertiseRequired: "Intermediate",
        caloriesPerServing: "250.0",
        ingredients: """
                      1 pizza dough
                      1/2 cup tomato sauce
                      1 1/2 cups shredded mozzarella cheese
                      1/4 cup fresh basil leaves
                      2 tbsp olive oil
                      Salt and pepper to taste
                      """,
        instructions: """
                      1. Preheat oven to 475°F (245°C).
                      2. Roll out dough on a floured surface.
                      3. Spread tomato sauce evenly over the dough.
                      4. Sprinkle with mozzarella cheese.
                      5. Drizzle with olive oil and season with salt and pepper.
                      6. Bake for 12-15 minutes until crust is golden.
                      7. Garnish with fresh basil leaves before serving.
                      """,
        category: [italianCategory, mainDishCategory],
        favorite: false
    ),
    Recipe(
        title: "Vegan Avocado Toast",
        author: "Healthy Eats",
        date: Date(),
        timeRequired: "10 mins",
        servings: "1",
        expertiseRequired: "Beginner",
        caloriesPerServing: "180.0",
        ingredients: """
                      2 slices of whole grain bread
                      1 ripe avocado
                      1 tsp lemon juice
                      Salt and pepper to taste
                      Red pepper flakes (optional)
                      """,
        instructions: """
                      1. Toast the bread slices to your liking.
                      2. Mash the avocado in a bowl and mix in lemon juice, salt, and pepper.
                      3. Spread the avocado mixture on the toasted bread.
                      4. Sprinkle with red pepper flakes if desired.
                      """,
        category: [healthyCategory],
        favorite: true
    ),
    Recipe(
        title: "Classic Caesar Salad",
        author: "Salad Guru",
        date: Date(),
        timeRequired: "20 mins",
        servings: "4",
        expertiseRequired: "Intermediate",
        caloriesPerServing: "220.0",
        ingredients: """
                      1 head romaine lettuce
                      1/2 cup Caesar dressing
                      1/4 cup grated Parmesan cheese
                      1 cup croutons
                      1 tsp black pepper
                      """,
        instructions: """
                      1. Chop the romaine lettuce and place in a large bowl.
                      2. Add Caesar dressing and toss to coat.
                      3. Mix in Parmesan cheese and croutons.
                      4. Season with black pepper and serve chilled.
                      """,
        category: [quickMealsCategory, healthyCategory, sideAndSaladDishCategory],
        favorite: false
    ),
    Recipe(
        title: "Spicy Thai Noodles",
        author: "World Flavors",
        date: Date(), // current date
        timeRequired: "25 mins",
        servings: "2",
        expertiseRequired: "Advanced",
        caloriesPerServing: "320.0",
        ingredients: """
                      8 oz rice noodles
                      1 tbsp sesame oil
                      1 clove garlic, minced
                      1 tbsp soy sauce
                      1 tbsp sriracha
                      1/2 cup chopped green onions
                      1/4 cup crushed peanuts
                      """,
        instructions: """
                      1. Cook rice noodles according to package instructions.
                      2. Heat sesame oil in a pan and sauté garlic until fragrant.
                      3. Add cooked noodles, soy sauce, and sriracha to the pan. Mix well.
                      4. Serve topped with green onions and crushed peanuts.
                      """,
        category: [mainDishCategory],
        favorite: true
    ),
    Recipe(
        title: "Mediterranean Quinoa Salad",
        author: "Healthy Bites",
        date: Date(),
        timeRequired: "20 mins",
        servings: "4",
        expertiseRequired: "Intermediate",
        caloriesPerServing: "275.0",
        ingredients: """
                      1 cup quinoa
                      2 cups water
                      1/2 cup cherry tomatoes, halved
                      1/2 cucumber, diced
                      1/4 cup red onion, finely chopped
                      1/4 cup kalamata olives, sliced
                      1/4 cup feta cheese, crumbled
                      2 tbsp olive oil
                      1 tbsp lemon juice
                      1 tsp dried oregano
                      Salt and pepper to taste
                      """,
        instructions: """
                      1. Rinse quinoa under cold water and drain.
                      2. In a saucepan, bring water to a boil. Add quinoa, reduce heat, cover, and simmer for 15 minutes.
                      3. Once cooked, fluff the quinoa with a fork and let it cool.
                      4. In a large bowl, combine cooled quinoa, tomatoes, cucumber, red onion, olives, and feta cheese.
                      5. In a small bowl, whisk together olive oil, lemon juice, oregano, salt, and pepper.
                      6. Pour dressing over salad and toss to combine.
                      7. Serve chilled or at room temperature.
                      """,
        category: [healthyCategory, sideAndSaladDishCategory],
        favorite: false
    ),
    Recipe(
        title: "Beef Stroganoff",
        author: "Comfort Cooks",
        date: Date(),
        timeRequired: "45 mins",
        servings: "4",
        expertiseRequired: "Intermediate",
        caloriesPerServing: "450.0",
        ingredients: """
                      1 lb beef sirloin, thinly sliced
                      2 tbsp butter
                      1 medium onion, chopped
                      2 cloves garlic, minced
                      1 cup mushrooms, sliced
                      1 tbsp all-purpose flour
                      1 cup beef broth
                      1 cup sour cream
                      Salt and pepper to taste
                      Cooked egg noodles for serving
                      """,
        instructions: """
                      1. In a skillet, melt butter over medium heat. Add onion and garlic, cook until softened.
                      2. Increase heat, add beef and cook until browned.
                      3. Stir in mushrooms and flour, cook for a few minutes.
                      4. Add beef broth, bring to a boil. Reduce heat and simmer until thickened.
                      5. Remove from heat, stir in sour cream. Season with salt and pepper.
                      6. Serve over cooked egg noodles.
                      """,
        category: [mainDishCategory],
        favorite: true
    ),
    Recipe(
        title: "Chicken Tikka Masala",
        author: "Global Gourmet",
        date: Date(),
        timeRequired: "1 hr",
        servings: "4",
        expertiseRequired: "Advanced",
        caloriesPerServing: "350.0",
        ingredients: """
                      2 lbs chicken breast, cubed
                      1 cup yogurt
                      2 tbsp lemon juice
                      2 tsp turmeric powder
                      2 tbsp garam masala
                      2 tbsp cumin
                      1/2 cup tomato sauce
                      1 cup heavy cream
                      2 tbsp vegetable oil
                      2 garlic cloves, minced
                      1 onion, diced
                      Salt to taste
                      Chopped cilantro for garnish
                      """,
        instructions: """
                      1. Marinate chicken with yogurt, lemon juice, turmeric, garam masala, and cumin for at least 1 hour.
                      2. In a pan, heat oil over medium heat. Add garlic and onions, sauté until golden.
                      3. Add marinated chicken and cook until done.
                      4. Add tomato sauce, cook for 10 minutes.
                      5. Stir in heavy cream and simmer for another 10 minutes.
                      6. Season with salt. Garnish with cilantro before serving.
                      """,
        category: [mainDishCategory],
        favorite: false
    ),
    Recipe(
        title: "Lemon Garlic Shrimp Pasta",
        author: "Pasta Perfection",
        date: Date(),
        timeRequired: "30 mins",
        servings: "3",
        expertiseRequired: "Intermediate",
        caloriesPerServing: "375.0",
        ingredients: """
                      8 oz spaghetti
                      1 lb shrimp, peeled and deveined
                      4 cloves garlic, minced
                      1 lemon, juiced and zested
                      2 tbsp olive oil
                      1/4 cup parsley, chopped
                      Red pepper flakes to taste
                      Salt and pepper to taste
                      """,
        instructions: """
                      1. Cook spaghetti according to package instructions.
                      2. In a pan, heat olive oil. Add garlic and shrimp, cook until shrimp is pink.
                      3. Add lemon juice, zest, red pepper flakes, salt, and pepper.
                      4. Toss cooked spaghetti with shrimp mixture.
                      5. Garnish with parsley and serve.
                      """,
        category: [mainDishCategory, quickMealsCategory],
        favorite: false
    ),
    Recipe(
        title: "Chocolate Lava Cake",
        author: "Sweet Treats",
        date: Date(),
        timeRequired: "25 mins",
        servings: "4",
        expertiseRequired: "Advanced",
        caloriesPerServing: "310.0",
        ingredients: """
                      1/2 cup unsalted butter
                      4 oz bittersweet chocolate
                      2 eggs
                      2 egg yolks
                      1/4 cup sugar
                      2 tsp flour
                      Pinch of salt
                      Powdered sugar for dusting
                      """,
        instructions: """
                      1. Preheat oven to 425°F (220°C).
                      2. Melt butter and chocolate in a double boiler, then cool slightly.
                      3. Whisk eggs, egg yolks, and sugar until light and thick.
                      4. Fold chocolate mixture into egg mixture, then add flour and salt.
                      5. Pour batter into buttered ramekins.
                      6. Bake for 12-14 minutes until sides are firm but center is soft.
                      7. Let stand for 1 minute, then invert onto plates and dust with powdered sugar.
                      """,
        category: [dessertsCategory],
        favorite: true
    ),
    Recipe(
        title: "Lebkuchengewürz (German Gingerbread Spice)",
        author: "Kimberly Killebrew",
        date: Date(),
        timeRequired: "5 mins",
        servings: "4 tablespoons",
        expertiseRequired: "Beginner",
        caloriesPerServing: "21 kcal",
        ingredients: """
                      2 ½ tablespoons ground cinnamon
                      2 teaspoon ground cloves
                      ½ teaspoon ground allspice
                      ½ teaspoon ground coriander
                      ½ teaspoon ground green cardamom
                      ½ teaspoon ground ginger
                      ½ teaspoon ground star anise
                      ¼ teaspoon ground mace
                      ¼ teaspoon ground nutmeg
                      """,
        instructions: """
                      1. Combine the spices together and store in an airtight jar in a cool, dark place for up to one year.
                      2. For superior flavor results, grind these spices from toasted and freshly ground whole spices.
                      """,
        category: [condimentCategory],
        favorite: false
    ),
    Recipe(
        title: "Pfeffernüsse (Spicy German Cookies)",
        author: "The Daring Gourmet",
        date: Date(),
        timeRequired: "48 hrs",
        servings: "48 cookies",
        expertiseRequired: "Intermediate",
        caloriesPerServing: "Varies",
        ingredients: """
                      320g Bread flour
                      scant 1/2 tsp. Baking soda
                      1/4 tsp. Salt
                      4 tsp. Lebkuchengewürz
                      1 tsp. Ground ginger
                      1/4 tsp. White pepper
                      1/4 tsp. Black pepper
                      30g Almond meal
                      100g Brown sugar
                      113g Honey
                      71g Unsalted butter
                      50g Heavy cream
                      25g Molasses
                      2 large Eggs
                      """,
        instructions: """
                      1. Mix dry ingredients in a small bowl. Melt butter, sugar, honey, and molasses in a saucepan.
                      2. Let sit for 5 minutes, then mix in the dry ingredients and eggs. Refrigerate 24-48 hours.
                      3. Roll into balls and place on lined baking sheet. Chill for 20-30 minutes.
                      4. Bake at 375 degrees for ~10 minutes. Cool completely, dip in glaze.
                      """,
        category: [dessertsCategory],
        favorite: false
    ),
    Recipe(
        title: "Nürnberger Elisenlebkuchen (German Lebkuchen)",
        author: "Kimberly Killebrew",
        date: Date(),
        timeRequired: "45 mins",
        servings: "35 lebkuchen",
        expertiseRequired: "Advanced",
        caloriesPerServing: "175 kcal",
        ingredients: """
                      5 large eggs
                      275 g brown sugar
                      85 ml honey
                      1 tsp vanilla extract
                      225 g almond meal
                      225 g hazelnut meal
                      ¼ tsp salt
                      ½ tsp baking powder
                      3 tsp Lebkuchengewürz
                      115 g candied lemon peel
                      115 g candied orange peel
                      ¼ cup all-purpose flour
                      Backoblaten, 70mm
                      Blanched almonds for decoration
                      Chocolate Glaze:
                      85 g chocolate
                      1 tbsp coconut oil
                      Sugar Glaze:
                      120 g powdered sugar
                      3 tbsp water
                      """,
        instructions: """
                      1. Preheat oven to 300°F. Process candied peels with flour in food processor.
                      2. Beat eggs with sugar, honey, and vanilla. Add dry ingredients and peels.
                      3. Scoop onto Backoblaten, bake for 25-28 minutes. Cool completely.
                      4. Glaze with chocolate or sugar glaze and decorate with almonds.
                      """,
        category: [dessertsCategory],
        favorite: false
    )
]
