//
//  CreationAssembly.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 26.03.2024.
//

import Foundation
import Swinject

final class CreationAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        let model = CreationModel()
        let viewModel = CreationViewModel(creationModel: model)

        container.register(CreationView.self) { _ in
            return CreationView(viewState: viewModel)
        }
    }
}
