//
//  RecipesRouter.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation

final class RecipesRouter: RecipesRouterProtocol {
    var navigation: any NavigationServiceType

    init(navigation: any NavigationServiceType) {
        self.navigation = navigation
    }

}
