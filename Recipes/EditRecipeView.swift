//
//  EditRecipeView.swift
//  Recipes
//
//  Created by Riley Marshall on 12/5/23.
//
// I followed this video
// https://www.youtube.com/watch?v=w4BQnVn7H6M
// to learn how to implement this edit functionality
import Foundation
import SwiftData
import SwiftUI

struct EditRecipeView: View {
    @Bindable var recipe: Recipe
    @Environment(\.dismiss) var dismiss
    @Query var categories: [RecipeCategory]
    @State var selectedCategoryIds: Set<UUID>

    // Got a lot of errors and after some googling, I tried lots of ways to initalize and ending up trying this and it worked
    // https://developer.apple.com/documentation/swift/int
    init(recipe: Recipe) {
        _recipe = Bindable(recipe)
        _selectedCategoryIds = State(initialValue: Set(recipe.category.map { $0.id }))
    }

    var body: some View {
        Form {
            TextField("Title", text: $recipe.title)
            TextField("Author", text: $recipe.author)
            TextField("Time Required", text: $recipe.timeRequired)
            TextField("Servings", text: $recipe.servings)
            TextField("Expertise Required", text: $recipe.expertiseRequired)
            TextField("Calories per Serving", text: $recipe.caloriesPerServing)
                .keyboardType(.decimalPad) // To allow decimal input
            TextField("Ingredients", text: $recipe.ingredients, axis: .vertical)
            TextField("Instructions", text: $recipe.instructions, axis: .vertical)

            Section(header: Text("Categories")) {
                ForEach(categories, id: \.id) { category in
                    Toggle(isOn: Binding(
                        get: { self.selectedCategoryIds.contains(category.id) },
                        set: { isSelected in
                            if isSelected {
                                self.selectedCategoryIds.insert(category.id)
                                if !self.recipe.category.contains(where: { $0.id == category.id }) {
                                    self.recipe.category.append(category)
                                }
                            } else {
                                self.selectedCategoryIds.remove(category.id)
                                if let index = self.recipe.category.firstIndex(where: { $0.id == category.id }) {
                                    self.recipe.category.remove(at: index)
                                }
                            }
                        }
                    )) {
                        Text(category.name)
                    }
                }
            }

            Toggle("Favorite", isOn: $recipe.favorite)
        }
        .navigationBarItems(trailing: Button(action: {
            dismiss()
        }) {
            Text("Done")
        })
    }
}


//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Recipe.self, configurations: config)
//        let quickMealsCategory = RecipeCategory(id: UUID(), name: "Quick Meals", recipes: [])
//        let example = Recipe(title: "Example", author: "Example author", date: Date(), timeRequired: "100 days", servings: "10", expertiseRequired: "Yes", caloriesPerServing: "40", ingredients: "List here", instructions: "List here", category: [quickMealsCategory], favorite: true)
//        return EditRecipeView(recipe: example)
//            .modelContainer(container)
//    } catch{
//        fatalError("Something went wrong")
//    }
//}


