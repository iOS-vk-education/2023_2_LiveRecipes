//
//  NavigationAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import Swinject

final class NavigationAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(NavigationService.self) { r in
            return NavigationService()
        }
    }
    
    static let navigation: any NavigationServiceType = NavigationService()

    func build() -> any NavigationServiceType {
        return NavigationAssembly.navigation
    }
}
