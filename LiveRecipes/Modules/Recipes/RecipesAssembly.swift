//
//  RecipesAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI

final class RecipesAssembly: Assembly {
    func build() -> some View {
        let navigation = container.resolve(NavigationAssembly.self).build()

        let router = RecipesRouter(navigation: navigation)
        let interactor = RecipesInteractor()
        let viewState = RecipesViewState()
        let presenter = RecipesPresenter(router: router, interactor: interactor, viewState: viewState)

        viewState.set(with: presenter)

        return RecipesView(viewState: viewState)
    }
}
