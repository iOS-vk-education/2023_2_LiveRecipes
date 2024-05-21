//
//  NavigationTabs.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation
import SwiftUI

class TabSelectionManager: ObservableObject {
    @Published var selection: Tabs = .recipes

    public func changeSelection(to newSelection: Tabs) {
        selection = newSelection
        
        objectWillChange.send()
      }
}

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
        }
    }
    case recipes
    case cooking
    case favorites
}
