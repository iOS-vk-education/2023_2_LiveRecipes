//
//  NavigationAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation

final class NavigationAssembly: Assembly {

    // Only one navigation should use in app
    static let navigation: any NavigationServiceType = NavigationService()

    func build() -> any NavigationServiceType {
        return NavigationAssembly.navigation
    }
}
