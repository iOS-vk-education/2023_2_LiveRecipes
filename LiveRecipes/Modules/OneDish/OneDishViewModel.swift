//
//  OneDishViewModel.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 30.03.2024.
//

import Foundation

final class OneDishViewModel: ObservableObject, OneDishViewModelProtocol {
    var model: OneDishModel
    var id = 1
    @Published var foundRecipe = RecipeDTO(id: 0, name: "", bzy: BZY(calories: "0", protein: "0", fats: "0", carbohydrates: "0"), duration: "", photo: "", description: "", ingredients: [], steps: [[]], tag: "")

    init(oneDishModel: OneDishModel) {
        self.model = oneDishModel
        
        model.findRecipe(id: id, completion: { [weak self] result in
            self?.foundRecipe = result
            print("smth")
            print(self?.foundRecipe.name)
        })
    }
    func findRecipes() {
        model.findRecipe(id: id) { [weak self] result in
            self?.foundRecipe = result
        }
    }
}
