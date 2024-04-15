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
        let model = OneDishModel()
        let viewModel = OneDishViewModel(oneDishModel: model)

        container.register(OneDishView.self) { _ in
            return OneDishView(viewState: viewModel)
        }
    }
}
