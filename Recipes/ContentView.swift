//
//  ContentView.swift
//  Recipes
//
//  Created by Riley Marshall on 11/28/23.
//

import MarkdownUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Recipe.title) var recipes: [Recipe]
    @Query private var categories: [RecipeCategory]
    @State private var searchTerm: String = ""
    @State private var isEditViewActive = false
    @State private var isDataInitialized = false
    
    
 
    var body: some View {
        NavigationSplitView {
            List {
                // A section of top-level abilities like browse all, search, favorites
                Section(header: Text("Top Level Actions")) {
                    NavigationLink {
                        browseAllList
                    } label: {
                        Text("All Recipes")
                    }
                    
                    NavigationLink {
                        AddRecipeView(onAdd: addRecipe)
                    } label: {
                        Text("Add Recipe")
                    }
                    
                    NavigationLink {
                        editAllList
                    } label: {
                        Text("Edit Recipe")
                    }
                    
                    NavigationLink {
                        browseCategories
                    } label: {
                        Text("All Categories")
                    }
                    
                    NavigationLink {
                        ManageCategoryView()
                    } label: {
                        Text("Manage Categories")
                    }
                    
                    
                    NavigationLink {
                        //Text("Favorite Recipes")
                        browseFavoriteList
                    } label: {
                        Text("Favorites")
                    }
                    
                    
                    NavigationLink {
                        VStack {
                            // I used chatGPT to help me with the syntax for how to search based on the tittle and some of the styling. I also asked it to explain to me what localizedCaseInsensitiveContains means. I used the prompt "kay now I want to do something ambitious in swift. I am making a recipe app to keep track of recipes and I want to implement a search function. I want to allow the user must be able to search for a recipe by keyword and show a potentially scrolling list of recipes that match.  I think searching by the title field will be sufficient for now. How would I go about doing that?"
                            TextField("Search recipes", text: $searchTerm)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                            
                            List {
                                ForEach(
                                    recipes.filter {
                                        $0.title.localizedCaseInsensitiveContains(searchTerm) || searchTerm.isEmpty
                                    }
                                ) { recipe in
                                    NavigationLink {
                                        recipeInfo(for: recipe)
                                    } label: {
                                        Text("\(recipe.title)")
                                    }
                                }
                            }
                        }
                        .navigationTitle("Search Recipes")
                    } label: {
                        Text("Search")
                    }
                }
            }
            .onAppear {
                if !isDataInitialized{
                    initializeRecipes()
                    isDataInitialized = true
                }
            }
        } content: {
            browseAllList
        } detail: {
            Text("Select an item")
        }
    }
    
    private var browseAllList: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink {
                    recipeInfo(for: recipe)
                } label: {
                    Text(recipe.title)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("All Recipes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                NavigationLink {
                    AddRecipeView(onAdd: addRecipe)
                } label: {
                    Label("Add Recipe", systemImage: "plus")
                }
            }
        }
    }
    
    private var editAllList: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink {

                    EditRecipeView(recipe: recipe)
                } label: {
                    Text(recipe.title)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("Edit Recipes")
    }

    
    
    private var browseFavoriteList: some View {
        List {
            ForEach(recipes.filter { $0.favorite }) { recipe in
                NavigationLink {
                    recipeInfo(for: recipe)
                    
                } label: {
                    HStack {
                        Text(recipe.title)
                        Spacer()
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationTitle("Favorite Recipes")
    }
  
    private var browseCategories: some View {
        List {
            ForEach(uniqueCategories, id: \.id) { category in
                NavigationLink {
                    List(recipes.filter { recipe in
                        recipe.category.contains(where: { $0.id == category.id })
                    }) { recipe in
                        NavigationLink {
                            recipeInfo(for: recipe)
                        } label: {
                            Text(recipe.title)
                        }
                        .navigationTitle("Recipes")
                        
                    }
                } label: {
                    Text(category.name)
                }
            }
            
        }
        
        .navigationTitle("Categories")
    }

    
    private var uniqueCategories: [RecipeCategory] {
        var uniqueCategoriesDict = [PersistentIdentifier: RecipeCategory]()

        for recipe in recipes {
            for category in recipe.category {
                uniqueCategoriesDict[category.id] = category
            }
        }
        return Array(uniqueCategoriesDict.values).sorted { $0.name < $1.name }
    }


    
    private func addRecipe(_ recipe: Recipe) {
        withAnimation {
            modelContext.insert(recipe)
        }
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
            
            do {
                try modelContext.save() // Commit the changes
            } catch {
                // Handle the error, perhaps by presenting an alert to the user
            }
        }
    }
    
    private func initializeRecipes() {
        withAnimation {
            for recipe in sampleRecipes {
                modelContext.insert(recipe)
            }
        }
    }
    
    
    private func recipeInfo(for recipe: Recipe) -> some View {
        //@State var recipeCategories = recipe.category
        
        let categoryNames = recipe.category.map { $0.name }.joined(separator: ", ")
        
        return ScrollView {
                      Markdown(
                        """
                        # \(recipe.title)
                        ### Recipe Information
                        - **Author:** \(recipe.author)
                        - **Time Required:** \(recipe.timeRequired)
                        - **Servings:** \(recipe.servings)
                        - **Expertise Required:** \(recipe.expertiseRequired)
                        - **Calories per Serving:** \(recipe.caloriesPerServing)
                        - **Category:** \(categoryNames)
                        - **Favorite:** \(recipe.favorite ? "Yes" : "No")
                        ### Ingredients
                        \(recipe.ingredients)
                        ### Instructions
                        \(recipe.instructions)
                        """
                      )
                      .padding()
            
            Button(action: {
                recipe.toggleFavorite()
            }) {
                Image(systemName: recipe.favorite ? "heart.fill" : "heart")
                    .foregroundColor(recipe.favorite ? .red : .gray)
                    .font(.system(size: 52))
            }
            Spacer()
            VStack{
                Text("Click Category to Remove from Recipe")
                HStack {
                    ForEach(recipe.category, id: \.id) { category in
                        Button(action: {
                            if let index = recipe.category.firstIndex(where: { $0.id == category.id }) {
                                recipe.category.remove(at: index)
                            }
                        }) {
                            Text(category.name)
                                .padding(8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
        }
    }

    
    
    
    }


#Preview {
  ContentView()
    .modelContainer(for: Recipe.self, inMemory: true)
}

