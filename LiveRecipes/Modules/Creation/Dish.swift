//
//  Dish.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 15.04.2024.
//

import UIKit

class Dish: Identifiable {
    var id: Int?//если еще нет в базе данных, в процесе создания
    var title: String
    var description: String
    var photo: UIImage?
    var timeToPrepare: Int
    var nutritionValue: (Int, Int, Int, Int)
    var dishComposition: [DishComposition]
    var dishSteps: [DishStep]
    init(id: Int?, title: String, description: String, photo: UIImage? = nil, timeToPrepare: Int, nutritionValue: (Int, Int, Int, Int), dishComposition: [DishComposition], dishSteps: [DishStep]) {
        self.id = id
        self.title = title
        self.description = description
        self.photo = photo
        self.timeToPrepare = timeToPrepare
        self.nutritionValue = nutritionValue
        self.dishComposition = dishComposition
        self.dishSteps = dishSteps
    }

    var recipeDTO: RecipeDTO {
        let photoData = photo?.jpegData(compressionQuality: 0.4)
        let photoDataBase64 = photoData?.base64EncodedString() ?? ""
        return RecipeDTO(id: id ?? 0, name: title, bzy: BZY(calories: String(nutritionValue.0), protein: String(nutritionValue.1), fats: String(nutritionValue.2), carbohydrates: String(nutritionValue.3)), duration: timeToPrepare, photo: photoDataBase64, description: description, ingredients: dishComposition.map({ return ($0.product + " " + $0.quantity) }), steps: [], tag: "")
    }

    init(
        recipeEntity: CreationRecipeEntity,
        dishCompositionsEntities: [CreationRecipeCompositionEntity],
        dishStepsEntities: [CreationRecipeStepEntity]) 
    {
        self.id = Int(recipeEntity.id)
        self.title = recipeEntity.dishTitle
        self.description = recipeEntity.dishDescription
        self.timeToPrepare = Int(recipeEntity.timeToPrepare)
        self.nutritionValue = (
            Int(recipeEntity.nutritionValueCal),
            Int(recipeEntity.nutritionValueProt),
            Int(recipeEntity.nutritionValueFats),
            Int(recipeEntity.nutritionValueCarb))
        self.dishComposition = dishCompositionsEntities.map({ DishComposition(enity: $0) })
        self.dishSteps = dishStepsEntities.map({ DishStep(entity: $0) })
        if let ref = recipeEntity.photoRef {
            CreationPhotoFileManager.shared.getPhoto(ref: ref) { [weak self] data in
                if let data = data {
                    self?.photo = UIImage(data: data)
                }
            }
        } else {
            photo = nil
        }
            
    }
}
