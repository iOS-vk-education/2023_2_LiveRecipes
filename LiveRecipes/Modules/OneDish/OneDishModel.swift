//
//  OneDishModel.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 30.03.2024.
//

import Foundation

final class OneDishModel: ObservableObject, OneDishModelProtocol {
    let recipeAPI = RecipeAPI()
    let coreData = RecipeDataManager.shared
    
    @Published var foundRecipe = RecipeDTO(id: 0, name: "", bzy: BZY(calories: "0", protein: "0", fats: "0", carbohydrates: "0"), duration: 0, photo: "", description: "", ingredients: [], steps: [[]], tag: "")

    func findRecipe(id: Int, completion: @escaping (RecipeDTO)->Void) {
        recipeAPI.getRecipeById(id: id, completionHandler: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let result):
                completion(result)
            case .failure(_):
                completion(RecipeDTO(id: 0, name: "", bzy: BZY(calories: "0", protein: "0", fats: "0", carbohydrates: "0"), duration: 0, photo: "", description: "", ingredients: [], steps: [[]], tag: ""))
            }
        })
    }
    
    func getRecipeFromCD(id: Int) -> Dish {
        var recipe = Dish(id: nil, title: "", description: "", timeToPrepare: 0, nutritionValue: Nutrition(bzy: BZY(calories: "", protein: "", fats: "", carbohydrates: "")), dishComposition: [], dishSteps: [])
        coreData.fetch { dishes in
            print("dishes")
            for dish in dishes {
                if dish.myId == id {
                    recipe = dish
                    break
                }
            }
        }
        return recipe
    }
}
