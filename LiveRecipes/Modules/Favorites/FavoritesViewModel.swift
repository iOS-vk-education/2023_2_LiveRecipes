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
    @Published var allRecipes: [Recipe] = []
    @Published var myRecipes: [Recipe] = []
    init(favoritesModel: FavoritesModel) {
        self.model = favoritesModel
        loadAllData()
    }
    func loadAllData() {
        //keyWords = model.loadKeyWords()
        allRecipes = model.loadAllRecipes()
        
//        recentRecipes = model.loadRecentRecipes()
        myRecipes = model.loadMyRecipes()
    }
}
