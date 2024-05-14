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
    @ViewBuilder
    func build(view: Tabs, tabBinding: Binding<Tabs>) -> some View {
        switch view {
        case .recipes:
            Assembler.sharedAssembly.resolver.resolve(RecipesView.self)
        case .favorites:
            Assembler.sharedAssembly.resolver.resolve(FavoritesView.self)
        case .cooking:
            Assembler.sharedAssembly.resolver.resolve(CookingView.self, argument: tabBinding)
        }
    
        
    }
}

extension ApplicationViewBuilder {
    static var stub: ApplicationViewBuilder {
        return ApplicationViewBuilder()
    }
}
