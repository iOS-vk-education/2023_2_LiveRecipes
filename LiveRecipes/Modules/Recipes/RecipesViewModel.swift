//
//  RecipesViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class RecipesViewModel: ObservableObject, RecipesViewModelProtocol {
    var model: RecipesModelProtocol

    init(recipesModel: RecipesModel) {
        self.model = recipesModel
    }
}
