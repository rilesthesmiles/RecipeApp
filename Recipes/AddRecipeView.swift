//
//  AddRecipeView.swift
//  Recipes
//
//  Created by Riley Marshall on 12/3/23.
//

import Foundation
import SwiftUI
import MarkdownUI
import SwiftData

    // Looked up how to switch back to this view after adding a recipe, found some info about isPresented from these sources
    // https://developer.apple.com/documentation/swiftui/environmentvalues/ispresented
    //https://developer.apple.com/documentation/SwiftUI/View/sheet(isPresented:onDismiss:content:)
    // https://developer.apple.com/documentation/swiftui/environmentvalues/dismiss



struct AddRecipeView: View {
    @Environment(\.dismiss) var dismiss
    @Query private var categories: [RecipeCategory]
    @Environment(\.modelContext) private var modelContext
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var timeRequired: String = ""
    @State private var servings: String = ""
    @State private var expertiseRequired: String = ""
    @State private var caloriesPerServing: String = ""
    @State private var ingredients: String = ""
    @State private var instructions: String = ""
    @State private var selectedCategoryIds: Set<UUID> = []
    @State private var favorite: Bool = false
    @State private var newCategoryName: String = ""

    var onAdd: (Recipe) -> Void
    

    var body: some View {
        NavigationView {
            Form {
                // Recipe detail fields
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                TextField("Time Required", text: $timeRequired)
                TextField("Servings", text: $servings)
                TextField("Expertise Required", text: $expertiseRequired)
                TextField("Calories per Serving", text: $caloriesPerServing)
                TextField("Ingredients", text: $ingredients, axis: .vertical)
                TextField("Instructions", text: $instructions, axis: .vertical)

                // Category selection section
                Section(header: Text("Categories")) {
                    ForEach(categories, id: \.id) { category in
                        Toggle(isOn: Binding(
                            get: { self.selectedCategoryIds.contains(category.id) },
                            set: { isSelected in
                                if isSelected {
                                    self.selectedCategoryIds.insert(category.id)
                                } else {
                                    self.selectedCategoryIds.remove(category.id)
                                }
                            }
                        )) {
                            Text(category.name)
                            
                        }
                    }
                    
                    TextField("New Category", text: $newCategoryName)
                    Button("Add Category") {
                        addCategory(name: newCategoryName)
                        newCategoryName = "" // Reset the text field
                    }
                

                }

                Toggle("Favorite", isOn: $favorite)

                Button("Add Recipe") {
                    let selectedCategories = categories.filter { selectedCategoryIds.contains($0.id) }

                    print("Selected categories: \(selectedCategories.map { "\($0.name) - \($0.id)" })")
                    let newRecipe = Recipe(
                        title: title,
                        author: author,
                        date: Date(),
                        timeRequired: timeRequired,
                        servings: servings,
                        expertiseRequired: expertiseRequired,
                        caloriesPerServing: caloriesPerServing,
                        ingredients: ingredients,
                        instructions: instructions,
                        category: [],
                        favorite: favorite
                    )
                    newRecipe.category = selectedCategories
                    
                    onAdd(newRecipe)
                    
                    
                    
                    
                    
                    dismiss()
                }
            }
            .navigationBarTitle("Add New Recipe")
        }
    }
    
    private func addCategory(name: String) {
        let newCategory = RecipeCategory(id: UUID(), name: name, recipes: [])
        withAnimation {
            modelContext.insert(newCategory)
        }
    }
    
}


#Preview {
    AddRecipeView{ Recipe in
        // code here
    }

}
