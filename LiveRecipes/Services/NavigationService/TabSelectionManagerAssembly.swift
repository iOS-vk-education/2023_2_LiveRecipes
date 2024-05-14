//
//  TabSelectionManagerAssembly.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 14.05.2024.
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
