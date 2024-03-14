//
//  LiveRecipesApp.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 2/20/24.
//

import SwiftUI
import Swinject


extension Container {
    static let sharedContainer: Container = {
        let container = Container()
//
//        container.register(NavigationService.self) { r in
////            return NavigationAssembly()
//        }

        return container
    }()
}

extension Assembler {
    static let sharedAssembler: Assembler = {
        return Assembler([
            NavigationAssembly(),
            RecipesAssembly(),
            CookingAssembly()
        ], container: Container.sharedContainer)
    }()
}

@main
class RootApp: App {
    @ObservedObject var appViewBuilder: ApplicationViewBuilder
    @ObservedObject var navigationService: NavigationService

    required init() {
        navigationService = Assembler.sharedAssembler.resolver.resolve(NavigationService.self)!
//        navigationService = StubNavigation.stub.
        appViewBuilder = ApplicationViewBuilder()
        print(navigationService.id)
    }

    var body: some Scene {
        WindowGroup {
            RootView(navigationService: navigationService,
                     appViewBuilder: appViewBuilder)
        }
    }
}
