//
//  FavoritesModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class FavoritesModel: ObservableObject, FavoritesModelProtocol {
    
    func loadFavorites() -> [Dish] {
        var recipes: [Dish] = []
        RecipeDataManager.shared.fetch { dishes in
            for dish in dishes {
                if dish.netId != -1 {
                    recipes.append(dish)
                }
            }
        }
        return recipes
        }

}
