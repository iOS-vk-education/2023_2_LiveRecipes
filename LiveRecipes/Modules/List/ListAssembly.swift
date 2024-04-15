//
//  ListAssembly.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation
import Swinject

final class ListAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        let model = ListModel()
        let viewModel = ListViewModel(recipesModel: model)

        container.register(ListView.self) { _ in
            return ListView(viewState: viewModel)
        }
        
    }
}
