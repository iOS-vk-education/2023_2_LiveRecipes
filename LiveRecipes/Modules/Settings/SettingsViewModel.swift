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
}
