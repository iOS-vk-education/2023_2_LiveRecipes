//
//  CreationModel.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 26.03.2024.
//

import Foundation

final class CreationModel: ObservableObject, CreationModelProtocol {
    
    func showRecipesInDB() {
        print("----------------------------")
        print("[DEBUG] begin")
        RecipeDataManager.shared.fetch { dishes in
            print("[DEBUG] dishes:")
            for dish in dishes {
                print("---")
                print("myId: \(String(dish.myId))")
                print("id: \(String(describing: dish.id))")
                print("title: \(dish.title)")
                print("description: \(dish.description)")
                print("timeToPrepare: \(dish.timeToPrepare)")
                print("photoRef: \(dish.photo == nil ? "NO" : "YES")")
                print("nutritionValueCal: \(dish.nutritionValue.calories)")
                print("nutritionValueProt: \(dish.nutritionValue.protein)")
                print("nutritionValueFats: \(dish.nutritionValue.fats)")
                print("nutritionValueCarb: \(dish.nutritionValue.carbohydrates)")
                print("---")
                for step in dish.dishSteps {
                    print("---")
                    print("step.id: \(step.id)")
                    print("step.title: \(step.stepTime)")
                    print("step.description: \(step.description)")
                    print("step.photo: \(step.photo == nil ? "NO" : "YES")")
                }
                for composition in dish.dishComposition {
                    print("---")
                    print("composition.id: \(composition.id)")
                    print("composition.product: \(composition.product)")
                    print("composition.quantity: \(composition.quantity)")
                }
            }
        }
        print("[DEBUG] end")
        print("----------------------------")
    }
    func createRecipy(dish: Dish, completion: @escaping() -> Void) {
        RecipeDataManager.shared.create(id: nil, dish: dish) {
            completion()
        }
    }
    func isCreationPossible(dish: Dish) -> CreationError? {
        if dish.title == "" {
            return .withoutTitle
        }
        if dish.description == "" {
            return .withoutDescription
        }
        if dish.timeToPrepare == 0 {
            return .withoutTime
        }
        if dish.dishComposition.count == 0 {
            return .withoutComposition
        }
        return nil
    }

}
