//
//  ApplicationViewBuilder.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI
import Swinject

@MainActor
final class ApplicationViewBuilder: ObservableObject {
//    nonisolated func assemble(container: Swinject.Container) {
//    }

    @ViewBuilder
    func build(view: Views) -> some View {
        switch view {
        case .main:
            buildMain()
        case .cooking:
            buildCooking()
        }
    }

    @ViewBuilder
    fileprivate func buildMain() -> some View {
        Assembler.sharedAssembler.resolver.resolve(RecipesViewControllerBridge.self)
    }

    @ViewBuilder
    fileprivate func buildCooking() -> some View {
        Assembler.sharedAssembler.resolver.resolve(CookingView.self)
    }
}

extension ApplicationViewBuilder {
    static var stub: ApplicationViewBuilder {
        return ApplicationViewBuilder()
    }
}
