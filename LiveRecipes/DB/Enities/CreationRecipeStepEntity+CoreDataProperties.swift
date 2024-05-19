//
//  CreationRecipeStepEntity+CoreDataProperties.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 18.05.2024.
//
//

import Foundation
import CoreData


extension CreationRecipeStepEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CreationRecipeStepEntity> {
        return NSFetchRequest<CreationRecipeStepEntity>(entityName: "CreationRecipeStepEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var stepPhotoRef: String?
    @NSManaged public var stepDescription: String
    @NSManaged public var stepTime: Int64
    @NSManaged public var recipe: CreationRecipeEntity?

}

extension CreationRecipeStepEntity : Identifiable {

}
