//
//  OneDishViewModel.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 30.03.2024.
//

import Foundation

final class OneDishViewModel: ObservableObject, OneDishViewModelProtocol {
    var model: OneDishModel
    var id: Int
    
    @Published var arrayOfRecentsID: [Int] = UserDefaults.standard.array(forKey: "recentsID") as? [Int] ?? []
    @Published var foundRecipe = RecipeDTO(id: 0, name: "", bzy: BZY(calories: "0", protein: "0", fats: "0", carbohydrates: "0"), duration: 0, photo: "", description: "", ingredients: [], steps: [[]], tag: "")

    init(oneDishModel: OneDishModel, id: Int) {
        self.model = oneDishModel
        self.id = id
        
        model.findRecipe(id: id, completion: { [weak self] result in
            self?.foundRecipe = result
        })
    }
    func findRecipe() {
        model.findRecipe(id: id) { [weak self] result in
            self?.foundRecipe = result
        }
    }
    func updateRecentsID(recipe: RecipeDTO) {
        if (recipe.id != 0 && !arrayOfRecentsID.contains(recipe.id)) {
            if (arrayOfRecentsID.count < 15) {
                arrayOfRecentsID.insert(recipe.id, at: 0)
            } else {
                arrayOfRecentsID.insert(recipe.id, at: 0)
                arrayOfRecentsID.remove(at: 15)
            }
            UserDefaults.standard.set(arrayOfRecentsID, forKey: "recentsID")
        }
    }
}
