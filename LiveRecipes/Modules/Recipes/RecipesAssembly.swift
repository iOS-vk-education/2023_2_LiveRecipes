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
        guard let navigation = container.resolve(NavigationService.self) else { return }

        let router = RecipesRouter(navigation: navigation)
        let interactor = RecipesInteractor()
        let view = RecipesViewController()
        let presenter = RecipesPresenter(router: router, interactor: interactor, viewController: view)
        view.presenter = presenter

        container.register(RecipesViewControllerBridge.self) { r in
            return RecipesViewControllerBridge(view: view)
        }
    }
}
