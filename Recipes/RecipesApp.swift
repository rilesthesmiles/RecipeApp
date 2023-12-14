//
//  RecipesApp.swift
//  Recipes
//
//  Created by Riley Marshall on 11/28/23.
//

import SwiftUI
import SwiftData

@main
struct RecipesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Recipe.self, RecipeCategory.self])
    }
}
