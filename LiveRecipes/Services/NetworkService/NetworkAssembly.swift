//
//  NetworkAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/19/24.
//

import Foundation
import Swinject

final class NetworkServiceAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(RecipeAPI.self) { _ in
            return RecipeAPI()
        }
    }
}
