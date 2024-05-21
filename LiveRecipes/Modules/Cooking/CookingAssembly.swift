//
//  CookingAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation
import Swinject

final class CookingAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        let model = CookingModel()
        let viewModel = CookingViewModel(cookingModel: model)

        container.register(CookingView.self) { _, arg in
            return CookingView(tabSelected: arg, viewModel: viewModel)
        }
    }
}
