//
//  ListViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

struct Recipe {
    var id: Int
    var title: String
    var item: [RecipeItem]
}
struct RecipeItem {
    var id: Int
    var title: String
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
    init(entity: ListRecipeItemEntity) {
        self.id = Int(entity.id)
        self.title = entity.title
    }
}

final class ListViewModel: ObservableObject, ListViewModelProtocol {
    var model: ListModelProtocol
    var counter: Int = 7
    var timer: Timer?
    @Published var recipesList: [Recipe] = [
        
    ]
    /*@Published var recipesList: [Recipe] = [
        Recipe(id: 0, title: "Хреновины-0", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2")
        ]),
        Recipe(id: 1, title: "Хреновины-1", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2"),
            RecipeItem(id: 3, title: "Хрень-3"),
            RecipeItem(id: 4, title: "Хрень-4")
        ]),
        Recipe(id: 2, title: "Хреновины-2", item: [
            RecipeItem(id: 0, title: "Хрень-0")
        ]),
        Recipe(id: 3, title: "Хреновины-3", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2"),
            RecipeItem(id: 3, title: "Хрень-3"),
            RecipeItem(id: 4, title: "Хрень-4")
        ]),
        Recipe(id: 4, title: "Хреновины-4", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2")
        ]),
        Recipe(id: 5, title: "Хреновины-5", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1"),
            RecipeItem(id: 2, title: "Хрень-2"),
            RecipeItem(id: 3, title: "Хрень-3")
        ]),
        Recipe(id: 6, title: "Хреновины-6", item: [
            RecipeItem(id: 0, title: "Хрень-0"),
            RecipeItem(id: 1, title: "Хрень-1")
        ])
    ]*/
    init(recipesModel: ListModelProtocol) {
        self.model = recipesModel
        let recipes = CoreDataManager.shared.fetch(request: ListRecipeEntity.fetchRequest())
        let countRecipes = CoreDataManager.shared.count(request: ListRecipeEntity.fetchRequest())
        print("\n\nCount objects: \(countRecipes)\n")
        let recipeItems = CoreDataManager.shared.fetch(request: ListRecipeItemEntity.fetchRequest())
        let countRecipeItems = CoreDataManager.shared.count(request: ListRecipeItemEntity.fetchRequest())
        print("\n\nCount objects: \(countRecipeItems)\n")
        recipeItems.forEach { item in
            let resultStr = "\(item.parentId) \(item.id) \(item.title)\n"
            print(resultStr)
        }
        recipes.forEach { recipe in
            let resultStr = "\(recipe.id) \(recipe.title)\n"
            print(resultStr)
            let recipeItemsArray = recipeItems.filter({ $0.parentId == recipe.id }).map({ RecipeItem(entity: $0) })
            recipesList.append(Recipe(id: Int(recipe.id), title: recipe.title, item: recipeItemsArray))
        }

    }
    
}
