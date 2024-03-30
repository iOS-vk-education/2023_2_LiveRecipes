//
//  RecipesModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class RecipesModel: ObservableObject, RecipesModelProtocol {
    let recipeAPI: RecipeAPI
    @Published var foundRecipes: [RecipeDTO] = []

    init(recipeAPI: RecipeAPI) {
        self.recipeAPI = recipeAPI
    }

    func findRecipe(name: String, completion: @escaping ([RecipeDTO])->Void) {
        recipeAPI.getRecipes(name: name, completionHandler: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                completion([])
            }
        })
    }

    func getDesserts(completion: @escaping ([RecipeDTO])->Void) {
        recipeAPI.getDesserts{ [weak self] result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                completion([])
            }
        }
    }
}
