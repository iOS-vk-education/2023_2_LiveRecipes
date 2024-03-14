//
//  RecipesProtocols.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI

// MARK: - Router
protocol RecipesRouterProtocol: RouterProtocol {
    func openCooking()
}

// MARK: - Presenter
protocol RecipesPresenterProtocol: PresenterProtocol {
    func setupInitialState()
    func buttonPressed()
    var backgroundC: UIColor { get }
}

// MARK: - Interactor
protocol RecipesInteractorProtocol: InteractorProtocol {}

// MARK: - ViewController
protocol RecipesViewProtocol: ViewStateProtocol {
    func update()
}
