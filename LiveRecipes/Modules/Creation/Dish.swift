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
    var nutritionValue: Nutrition
    var dishComposition: [DishComposition]
    var dishSteps: [DishStep]
    init(id: Int?, title: String, description: String, photo: UIImage? = nil, timeToPrepare: Int, nutritionValue: Nutrition, dishComposition: [DishComposition], dishSteps: [DishStep]) {
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
        return RecipeDTO(id: id ?? 0, 
                         name: title,
                         bzy: BZY(
            calories: nutritionValue.calories,
            protein: nutritionValue.protein,
            fats: nutritionValue.fats,
            carbohydrates: nutritionValue.carbohydrates), 
                         duration: timeToPrepare,
                         photo: photoDataBase64,
                         description: description,
                         ingredients: dishComposition.map({ return ($0.product + " " + $0.quantity) }),
                         steps: [],
                         tag: "")
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
        self.nutritionValue = Nutrition(
            calories: recipeEntity.nutritionValueCal,
            protein: recipeEntity.nutritionValueProt,
            fats: recipeEntity.nutritionValueFats,
            carbohydrates: recipeEntity.nutritionValueCarb)
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
