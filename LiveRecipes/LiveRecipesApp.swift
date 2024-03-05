//
//  LiveRecipesApp.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 2/20/24.
//

import SwiftUI

@main
class RootApp: App {
    @ObservedObject var appViewBuilder: ApplicationViewBuilder
    @ObservedObject var navigationService: NavigationService

    let container: DependencyContainer = {
        let factory = AssemblyFactory()
        let container = DependencyContainer(assemblyFactory: factory)

        // MARK: - Services
        container.apply(NavigationAssembly.self)

        // MARK: - Modules
        container.apply(RecipesAssembly.self)

        return container
    }()

    required init() {
        // swiftlint:disable force_cast
        navigationService = container.resolve(NavigationAssembly.self).build() as! NavigationService
        // swiftlint:enable force_cast

        appViewBuilder = ApplicationViewBuilder(container: container)
    }

    var body: some Scene {
        WindowGroup {
            RootView(navigationService: navigationService,
                     appViewBuilder: appViewBuilder)
        }
    }
}
