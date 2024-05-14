//
//  CreationRecipeStepEntity+CoreDataProperties.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 13.05.2024.
//
//

import Foundation
import CoreData


extension CreationRecipeStepEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CreationRecipeStepEntity> {
        return NSFetchRequest<CreationRecipeStepEntity>(entityName: "CreationRecipeStepEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var photoRef: String?
    @NSManaged public var stepDescription: String
    @NSManaged public var stepTittle: String
    @NSManaged public var recipe: CreationRecipeEntity?

}

extension CreationRecipeStepEntity : Identifiable {

}
