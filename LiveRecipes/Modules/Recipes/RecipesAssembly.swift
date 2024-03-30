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
        guard let networkAPI = Container.sharedContainer.resolve(RecipeAPI.self) else { return }
        let model = RecipesModel(recipeAPI: networkAPI)
        let viewModel = RecipesViewModel(recipesModel: model)

        container.register(RecipesView.self) { _ in
            return RecipesView(viewModel: viewModel)
        }
    }
}
