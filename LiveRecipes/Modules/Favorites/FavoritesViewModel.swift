//
//  FavoritesViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class FavoritesViewModel: ObservableObject, FavoritesViewModelProtocol {
    var model: FavoritesModelProtocol

    init(favoritesModel: FavoritesModel) {
        self.model = favoritesModel
    }
}
