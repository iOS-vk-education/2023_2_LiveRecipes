//
//  CookingAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/13/24.
//

import Foundation
import Swinject

final class CookingAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        guard let navigation = container.resolve(NavigationService.self) else { return }

        let model = CookingModel()
        let viewModel = CookingViewModel(cookingModel: model)
        let view = CookingView(cookingViewModel: viewModel)

        container.register(CookingView.self) { r in
            return view
        }

    }
}
