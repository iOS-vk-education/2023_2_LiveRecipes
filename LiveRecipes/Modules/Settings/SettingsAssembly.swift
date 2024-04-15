//
//  SettingsAssembly.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 11.04.2024.
//

import Foundation
import Swinject

final class SettingsAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        let model = SettingsModel()
        let viewModel = SettingsViewModel(settingsModel: model)

        container.register(SettingsView.self) { _ in
            return SettingsView(viewState: viewModel)
        }
    }
}
