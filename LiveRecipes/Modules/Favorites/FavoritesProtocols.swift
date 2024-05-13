//
//  FavoritesProtocols.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

protocol FavoritesViewModelProtocol {
    
}

protocol FavoritesModelProtocol {
    func loadAllRecipes() -> [RecipePreviewDTO]
    func loadMyRecipes() -> [RecipePreviewDTO]
}

protocol FavoritesViewProtocol {}
