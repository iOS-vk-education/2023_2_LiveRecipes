//
//  FavoritesModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class FavoritesModel: ObservableObject, FavoritesModelProtocol {
    func loadMyRecipes() -> [RecipePreviewDTO] {
        return [
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
        ]
    }
    
    
    func loadAllRecipes() -> [RecipePreviewDTO] {
        return [
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar")
        ]
    }
}
