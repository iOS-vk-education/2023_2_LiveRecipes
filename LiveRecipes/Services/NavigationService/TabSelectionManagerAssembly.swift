//
//  TabSelectionManagerAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 5/13/24.
//

import Foundation
import Swinject

final class TabSelectionManagerAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.register(TabSelectionManager.self) { _ in
            return TabSelectionManager()
        }
    }
}

