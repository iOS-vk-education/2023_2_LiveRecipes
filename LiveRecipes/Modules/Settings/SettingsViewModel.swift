//
//  SettingsViewModel.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 11.04.2024.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject, SettingsViewModelProtocol {
    var model: SettingsModelProtocol

    let segments = ["light.theme".localized, "system.theme".localized, "dark.theme".localized]
    @Published var selectedSegment = 1
    @Published var colorScheme: ColorScheme?
    
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
    func clearRecents() {
        var recentsID = UserDefaults.standard.array(forKey: "recentsID") as? [Int] ?? []
        if !recentsID.isEmpty {
            recentsID = []
            UserDefaults.standard.setValue(recentsID, forKey: "recentsID")
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
    func changeTheme() {
        switch selectedSegment {
            case 0:
                colorScheme = .light
            case 1:
                colorScheme = nil
            case 2:
                colorScheme = .dark
            default:
                break
        }
        print(segments[selectedSegment])
    }
}
