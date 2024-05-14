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
                    print("step.title: \(step.title)")
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
        /*print("Вытаскиваем прямо из Базы Данных")
        let recipes = CoreDataManager.shared.fetch(request: CreationRecipeEntity.fetchRequest())
        for recipe in recipes {
            print("---")
            print("id: \(recipe.id)")
            print("dishTitle: \(recipe.dishTitle)")
            print("dishDescription: \(recipe.dishDescription)")
            print("timeToPrepare: \(recipe.timeToPrepare)")
            print("photoRef: \(String(describing: recipe.photoRef))")
            print("nutritionValueCal: \(recipe.nutritionValueCal)")
            print("nutritionValueProt: \(recipe.nutritionValueProt)")
            print("nutritionValueFats: \(recipe.nutritionValueFats)")
            print("nutritionValueCarb: \(recipe.nutritionValueCarb)")
            print("---")
            if let steps = recipe.step?.allObjects {
                print(steps)
                if let stepsArray = Array(steps) as? [CreationRecipeStepEntity] {
                    for step in stepsArray {
                        print("---")
                        print("step.id: \(step.id)")
                        print("step.stepTittle: \(step.stepTittle)")
                        print("step.stepDescription: \(step.stepDescription)")
                        print("step.photoRef: \(String(describing: step.photoRef))")
                    }
                }
            }
            if let composition = recipe.composition?.allObjects {
                print(composition)
                if let compositionArray = Array(composition) as? [CreationRecipeCompositionEntity] {
                    for composition in compositionArray {
                        print("---")
                        print("composition.id: \(composition.id)")
                        print("composition.product: \(composition.product)")
                        print("composition.quantity: \(composition.quantity)")
                    }
                }
            }
        }*/
        print("[DEBUG] end")
        print("----------------------------")
    }
    func createRecipy(dish: Dish, completion: @escaping() -> Void) {
        RecipeDataManager.shared.create(dish: dish) {
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
