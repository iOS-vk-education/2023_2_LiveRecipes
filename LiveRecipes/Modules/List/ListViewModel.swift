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

    }
    
}
