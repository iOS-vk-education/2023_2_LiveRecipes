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

        // Router
        let router = RecipesRouter(navigation: navigation)

        // Interactor
        let interactor = RecipesInteractor()

        // ViewState
        let viewState =  RecipesViewState()

        // Presenter
        let presenter = RecipesPresenter(router: router,
                                                           interactor: interactor,
                                                           viewState: viewState)

        viewState.set(with: presenter)

        // View
        let view = RecipesView(viewState: viewState)
        return view
    }
}
