//
//  SettingsViewModel.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 11.04.2024.
//

import Foundation

final class SettingsViewModel: ObservableObject, SettingsViewModelProtocol {
    var model: SettingsModelProtocol

    init(settingsModel: SettingsModelProtocol) {
        self.model = settingsModel
    }
    
    func clearFavorites() {
        var favoritesID = UserDefaults.standard.array(forKey: "favoritesID") as? [Int] ?? []
        if !favoritesID.isEmpty {
            for favId in favoritesID {
                RecipeDataManager.shared.delete(recipeNetId: favId) { _ in }
            }
            favoritesID = []
            UserDefaults.standard.setValue(favoritesID, forKey: "favoritesID")
        }
    }
    func clearMyRecipes () {
        RecipeDataManager.shared.fetch { dishes in
            for dish in dishes {
                if dish.netId == -1 {
                    RecipeDataManager.shared.delete(recipeMyId: dish.id ?? 0) { _ in }
                }
            }
        }
    }
}
