//
//  FavoritesAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation
import Swinject

final class FavoritesAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        let model = FavoritesModel()
        let viewModel = FavoritesViewModel(favoritesModel: model)

        container.register(FavoritesView.self) { _ in
            return FavoritesView(viewState: viewModel)
        }
    }
}
