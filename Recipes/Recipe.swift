//
//  Item.swift
//  Recipes
//
//  Created by Riley Marshall on 11/28/23.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    let id: UUID
    var title: String
    var author: String
    var date: Date
    var timeRequired: String
    var servings: String
    var expertiseRequired: String
    var caloriesPerServing: String
    var ingredients: String
    var instructions: String
    @Relationship(inverse: \RecipeCategory.recipes)
    var category: [RecipeCategory] = []
    var favorite: Bool
    
    init(id: UUID = UUID(),title: String, author: String, date: Date, timeRequired: String, servings: String, expertiseRequired: String, caloriesPerServing: String, ingredients: String, instructions: String, category: [RecipeCategory], favorite: Bool) {
        self.id = id
        self.title = title
        self.author = author
        self.date = date
        self.timeRequired = timeRequired
        self.servings = servings
        self.expertiseRequired = expertiseRequired
        self.caloriesPerServing = caloriesPerServing
        self.ingredients = ingredients
        self.instructions = instructions
        self.category = category
        self.favorite = favorite
    }
    
    
    func toggleFavorite() {
            favorite.toggle()
        }

}

@Model
final class RecipeCategory {
    let id: UUID
    var name: String
    //@Relationship(inverse: \Recipe.category)
    var recipes: [Recipe]?
    
    init(id: UUID, name: String, recipes: [Recipe]? = nil) {
        self.id = id
        self.name = name
        self.recipes = recipes
    }

}

//@Model
//final class Ingredient {
//    var ingredients: String
//
//    init(ingredients: String) {
//        self.ingredients = ingredients
//    }
//}
//
//@Model
//final class Instruction {
//    var sequence: Int
//    var instructions: String
//
//    init(sequence: Int, instructions: String) {
//        self.sequence = sequence
//        self.instructions = instructions
//    }
//}

