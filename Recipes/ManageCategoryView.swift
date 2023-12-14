//
//  AddCategoryView.swift
//  Recipes
//
//  Created by Riley Marshall on 12/8/23.
//


import Foundation
import SwiftUI
import MarkdownUI
import SwiftData

struct ManageCategoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var categories: [RecipeCategory]

    @State private var newCategoryName: String = ""
    @State private var isEditing: Bool = false
    @State private var selectedCategory: RecipeCategory?

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add New Category")) {
                    TextField("Category Name", text: $newCategoryName)
                    Button(isEditing ? "Update Category" : "Add Category") {
                        isEditing ? updateCategory() : addCategory()
                    }
                }

                Section(header: Text("Existing Categories")) {
                    ForEach(categories, id: \.id) { category in
                        HStack {
                            Text(category.name)
                            Spacer()
                            Button("Edit") {
                                self.selectedCategory = category
                                self.newCategoryName = category.name
                                self.isEditing = true
                            }
                            .foregroundColor(.blue)
                        }
                    }
                    .onDelete(perform: deleteCategory)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Manage Categories")
            .toolbar {
                EditButton()
            }
        }
    }

    private func addCategory() {
        let newCategory = RecipeCategory(id: UUID(), name: newCategoryName, recipes: [])
        modelContext.insert(newCategory)
        try? modelContext.save()
        newCategoryName = ""
    }

    private func updateCategory() {
        if let selectedCategory = selectedCategory {
            selectedCategory.name = newCategoryName
            try? modelContext.save()
            self.isEditing = false
            self.selectedCategory = nil
            newCategoryName = ""
        }
    }

    private func deleteCategory(at offsets: IndexSet) {
        offsets.forEach { index in
            let category = categories[index]
            modelContext.delete(category)
        }
        try? modelContext.save()
    }
}



#Preview {
    ManageCategoryView()
}
