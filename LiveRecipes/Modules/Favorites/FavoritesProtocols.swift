//
//  FavoritesProtocols.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

protocol FavoritesViewModelProtocol {
    func deleteFromFavorites(id: Int) -> Void 
    func loadData() -> Void 
}

protocol FavoritesModelProtocol {
    func loadFavorites() -> [Dish]
}

protocol FavoritesViewProtocol {}
