//
//  RecipesProtocols.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI

// MARK: - Router
protocol RecipesRouterProtocol: RouterProtocol {}

// MARK: - Presenter
protocol RecipesPresenterProtocol: PresenterProtocol {}

// MARK: - Interactor
protocol RecipesInteractorProtocol: InteractorProtocol {}

// MARK: - ViewState
protocol RecipesViewStateProtocol: ViewStateProtocol {
    func set(with presenter: RecipesPresenterProtocol)
}
