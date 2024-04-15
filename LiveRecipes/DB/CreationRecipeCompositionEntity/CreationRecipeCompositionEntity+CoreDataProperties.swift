//
//  CreationRecipeCompositionEntity+CoreDataProperties.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 15.04.2024.
//
//

import Foundation
import CoreData


extension CreationRecipeCompositionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CreationRecipeCompositionEntity> {
        return NSFetchRequest<CreationRecipeCompositionEntity>(entityName: "CreationRecipeCompositionEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var quantity: String
    @NSManaged public var product: String

}

extension CreationRecipeCompositionEntity : Identifiable {

}
