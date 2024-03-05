//
//  RecipesPresenter.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation

final class RecipesPresenter: RecipesPresenterProtocol {
    private let router: RecipesRouterProtocol
    private let viewState: RecipesViewStateProtocol
    private let interactor: RecipesInteractorProtocol

    init(router: RecipesRouterProtocol,
         interactor: RecipesInteractorProtocol,
         viewState: RecipesViewStateProtocol) {
        self.router = router
        self.interactor = interactor
        self.viewState = viewState
    }
}
