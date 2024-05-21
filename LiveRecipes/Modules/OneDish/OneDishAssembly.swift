//
//  OneDishAssembly.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 30.03.2024.
//

import Foundation
import Swinject
import SwiftUI

final class OneDishAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        //guard let networkAPI = Container.sharedContainer.resolve(RecipeAPI.self) else { return }
        //let model = OneDishModel(recipeAPI: networkAPI)
        

        container.register(OneDishView.self) { _, id, loadFromCD in
            let model = OneDishModel()
            let viewModel = OneDishViewModel(oneDishModel: model, id: id, loadRecipeFromCD: loadFromCD)
            return OneDishView(viewState: viewModel)
            
        }
    }
}
