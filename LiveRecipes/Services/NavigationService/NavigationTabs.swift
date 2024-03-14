//
//  NavigationTabs.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

enum Tabs: CaseIterable, Identifiable {
    var id: Self {
        return self
    }

    var tabName: String {
        switch self {
        case .recipes:
            return "tab.recipes".localized
        case .cooking:
            return "tab.cooking".localized
        case .favorites:
            return "tab.favorites".localized
        case .list:
            return "tab.list".localized
        }
    }

    var tabIcon: String {
        switch self {
        case .recipes:
            return "fork.knife".localized
        case .cooking:
            return "oven".localized
        case .favorites:
            return "star".localized
        case .list:
            return "square.and.pencil".localized
        }
    }
    case recipes
    case cooking
    case favorites
    case list
}
