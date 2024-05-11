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
        container.register(RecentRecipesView.self) { _ in
            return RecentRecipesView(viewModel: viewModel)
        }
        container.register(AllRecipesView.self) { _ in
            return AllRecipesView(viewModel: viewModel)
        }
        container.register(MyRecipesView.self) { _ in
            return MyRecipesView(viewModel: viewModel)
        }
        container.register(KeyWordsView.self) { _ in
            return KeyWordsView(viewModel: viewModel)
        }
        container.register(FiltersView.self) { _ in
            return FiltersView(viewModel: viewModel)
        }
        container.register(CookToTimeView.self) { _ in
            return CookToTimeView(viewModel: viewModel)
        }
    }
}
