//
//  RecipesPresenter.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import UIKit

final class RecipesPresenter: RecipesPresenterProtocol {
    func buttonPressed() {
        router.openCooking()
    }
    
    var backgroundC: UIColor
    
    func setupInitialState() {
        backgroundC = .brown
        viewController.update()
    }
    
    private let router: RecipesRouterProtocol
    private let viewController: RecipesViewProtocol
    private let interactor: RecipesInteractorProtocol

    init(router: RecipesRouterProtocol,
         interactor: RecipesInteractorProtocol,
         viewController: RecipesViewProtocol) {
        self.router = router
        self.interactor = interactor
        self.viewController = viewController
        self.backgroundC = .cyan
    }
}
