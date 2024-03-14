//
//  RecipesAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI
import Swinject

final class RecipesAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        let model = RecipesModel()
        let viewModel = RecipesViewModel(recipesModel: model)

        container.register(RecipesView.self) { _ in
            return RecipesView(viewState: viewModel)
        }
    }
}
