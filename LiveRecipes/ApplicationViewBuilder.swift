//
//  ApplicationViewBuilder.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI

@MainActor
final class ApplicationViewBuilder: Assembly, ObservableObject {
    required init(container: Container) {
        super.init(container: container)
    }

    @ViewBuilder
    func build(view: Views) -> some View {
        switch view {
        case .main:
            buildMain()
        }
    }

    @ViewBuilder
    fileprivate func buildMain() -> some View {
        container.resolve(RecipesAssembly.self).build()
    }
}

extension ApplicationViewBuilder {
    static var stub: ApplicationViewBuilder {
        return ApplicationViewBuilder(
            container: RootApp().container
        )
    }
}
