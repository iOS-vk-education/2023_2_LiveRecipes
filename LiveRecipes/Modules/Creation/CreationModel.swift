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
        let recipes = CoreDataManager.shared.fetch(request: CreationRecipeEntity.fetchRequest())
        for recipe in recipes {
            print("---")
            print("id: \(recipe.id)")
            print("dishTitle: \(recipe.dishTitle)")
            print("dishDescription: \(recipe.dishDescription)")
            print("photoRef: \(String(describing: recipe.photoRef))")
            print("nutritionValueCal: \(recipe.nutritionValueCal)")
            print("nutritionValueProt: \(recipe.nutritionValueProt)")
            print("nutritionValueFats: \(recipe.nutritionValueFats)")
            print("nutritionValueCarb: \(recipe.nutritionValueCarb)")
            print("---")
            if let steps = recipe.step {
                if let stepsArray = Array(steps) as? [CreationRecipeStepEntity] {
                    for step in stepsArray {
                        print("---")
                        print("step.id: \(step.id)")
                        print("step.stepTittle: \(step.stepTittle)")
                        print("step.stepDescription: \(step.stepDescription)")
                    }
                }
            }
        }
        print("[DEBUG] end")
        print("----------------------------")
    }
    func createRecipy(dish: Dish, completion: @escaping() -> Void) {
        CoreDataManager.shared.create(entityName: "CreationRecipeEntity") { entity in
            guard let entity = entity  as? CreationRecipeEntity else {
                return
            }
            let countDishes = CoreDataManager.shared.count(request:CreationRecipeEntity.fetchRequest())
            let newDishId = Int64(countDishes + 1)
            entity.id = newDishId
            entity.dishDescription = dish.description
            entity.dishTitle = dish.title
            entity.nutritionValueCal = Int64(dish.nutritionValue.0)
            entity.nutritionValueProt = Int64(dish.nutritionValue.1)
            entity.nutritionValueFats = Int64(dish.nutritionValue.2)
            entity.nutritionValueCarb = Int64(dish.nutritionValue.3)
            if let photo = dish.photo {
                if let imageData = photo.jpegData(compressionQuality: 0.4) {
                    CreationPhotoFileManager.shared.savePhoto(imageData: imageData) { ref in
                        entity.photoRef = ref
                    }
                }
            } else {
                entity.photoRef = nil
            }
            entity.timeToPrepare = Int64(dish.timeToPrepare)//непонятная хрень
            /*for step in dish.dishSteps {
                CoreDataManager.shared.create(entityName: "CreationRecipeStepEntity") { stepEntity in
                    guard let stepEntity = stepEntity  as? CreationRecipeStepEntity else {
                        return
                    }
                    stepEntity.recipe = entity
                    stepEntity.id = Int64(step.id)
                    stepEntity.stepTittle = step.title
                    stepEntity.stepDescription = step.description
                    stepEntity.photoRef = ""
                }
            }*/
            /*for composition in dish.dishComposition {
                let compositionEntity = CreationRecipeCompositionEntity(context: CoreDataManager.shared.viewContext)
                compositionEntity.product = composition.product
                compositionEntity.quantity = composition.quantity
                entity.addToComposition(compositionEntity)
            }*/
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
