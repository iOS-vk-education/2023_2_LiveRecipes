//
//  DishStep.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 15.04.2024.
//

import UIKit

class DishStep: Identifiable {
    var id: Int
    var num: Int?
    var stepTime: Int
    var description: String
    var photo: UIImage?
    init(id: Int, stepTime: Int, description: String, photo: UIImage? = nil) {
        self.id = id
        self.stepTime = stepTime
        self.description = description
        self.photo = photo
    }
    
    init(entity: CreationRecipeStepEntity) {
        self.id = Int(entity.id)
        self.stepTime = Int(entity.stepTime)
        self.description = entity.stepDescription
        if let ref = entity.stepPhotoRef {
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
