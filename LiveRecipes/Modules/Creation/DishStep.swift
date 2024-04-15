//
//  DishStep.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 15.04.2024.
//

import UIKit

class DishStep: Identifiable {
    var id: Int
    var title: String
    var description: String
    var photo: UIImage?
    init(id: Int, title: String, description: String, photo: UIImage? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.photo = photo
    }
    init(entity: CreationRecipeStepEntity) {
        self.id = Int(entity.id)
        self.title = entity.stepTittle
        self.description = entity.stepDescription
        if let ref = entity.photoRef {
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
