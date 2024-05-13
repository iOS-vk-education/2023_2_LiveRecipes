//
//  ListViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

struct ListRecipe {
    var id: Int
    var title: String
    var items: [ListRecipeItem]
}
struct ListRecipeItem {
    var id: Int
    var title: String
}
final class ListViewModel: ObservableObject, ListViewModelProtocol {
    var model: ListModelProtocol
    var counter: Int = 7
    var timer: Timer?
    @Published var recipesList: [ListRecipe] = []
    
    init(recipesModel: ListModelProtocol) {
        self.model = recipesModel
        let recipes = CoreDataManager.shared.fetch(request: ListRecipeEntity.fetchRequest())
        let countRecipes = CoreDataManager.shared.count(request: ListRecipeEntity.fetchRequest())
        //print("\n\nCount objects: \(countRecipes)\n")
        let recipeItems = CoreDataManager.shared.fetch(request: ListRecipeItemEntity.fetchRequest())
        let countRecipeItems = CoreDataManager.shared.count(request: ListRecipeItemEntity.fetchRequest())
        print("\n\nCount objects: \(countRecipeItems)\n")
        recipeItems.forEach { item in
            //let resultStr = "\(item.parentId) \(item.id) \(item.title)\n"
            //print(resultStr)
        }
        recipes.forEach { recipe in
            let resultStr = "\(recipe.id) \(recipe.title)\n"
          var recipeItemsForRecipe: [ListRecipeItem] = []
          
          /*let filteredItems = recipeItems.filter({ $0.parentId == recipe.id })
          filteredItems.forEach { item in
              recipeItemsForRecipe.append(ListRecipeItem(id: Int(item.id), title: item.title))
          }*/
          //recipesList.append(ListRecipe(id: Int(recipe.id), title: recipe.title, items: recipeItemsForRecipe))
          //print(resultStr)
            
        }

    }
    
}
