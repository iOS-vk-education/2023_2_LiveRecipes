//
//  OneDishAssembly.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 30.03.2024.
//

import Foundation
import Swinject

final class OneDishAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        guard let networkAPI = Container.sharedContainer.resolve(RecipeAPI.self) else { return }
        //let model = OneDishModel(recipeAPI: networkAPI)
        let model = OneDishModel()
        let viewModel = OneDishViewModel(oneDishModel: model)

        container.register(OneDishView.self) { _ in
            return OneDishView(viewState: viewModel)
        }
    }
}
