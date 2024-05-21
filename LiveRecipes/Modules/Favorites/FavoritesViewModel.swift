//
//  FavoritesViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class FavoritesViewModel: ObservableObject, FavoritesViewModelProtocol {
    var model: FavoritesModelProtocol
    
    @Published var modalFiltersIsOpen: Bool = false
    @Published var allRecipes: [RecipePreviewDTO] = []
    @Published var favoriteRecipes: [Dish] = []
    @Published var query: String = ""
    @Published var foundRecipes: [Dish] = []
    
    init(favoritesModel: FavoritesModel) {
        self.model = favoritesModel
        loadData()
    }
    
    func loadData() -> Void {
        favoriteRecipes = model.loadFavorites()
    }
    
    func deleteFromFavorites(id: Int) -> Void {
        RecipeDataManager.shared.delete(recipeNetId: id) { _ in }
    }
    func findFavorites() {
        foundRecipes = favoriteRecipes.filter({ $0.title.localizedStandardContains(query) })
    }
}
