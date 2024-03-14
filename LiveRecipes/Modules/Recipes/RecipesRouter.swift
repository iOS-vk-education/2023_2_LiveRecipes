//
//  RecipesRouter.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import Swinject

final class RecipesRouter: RecipesRouterProtocol {
    func openCooking() {
//        navigation.items.append(Assembler.sharedAssembler.resolver.resolve(CookingView.self))
//        navigation.items.append( Assembler.sharedAssembler.resolver.resolve(RecipesViewControllerBridge.self))
    }
    
    var navigation: any NavigationServiceType

    init(navigation: any NavigationServiceType) {
        self.navigation = navigation
    }
}
