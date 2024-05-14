//
//  CreationRecipeEntity+CoreDataProperties.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 13.05.2024.
//
//

import Foundation
import CoreData


extension CreationRecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CreationRecipeEntity> {
        return NSFetchRequest<CreationRecipeEntity>(entityName: "CreationRecipeEntity")
    }

    @NSManaged public var dishDescription: String
    @NSManaged public var dishTitle: String
    @NSManaged public var id: Int64
    @NSManaged public var nutritionValueCal: String
    @NSManaged public var nutritionValueCarb: String
    @NSManaged public var nutritionValueFats: String
    @NSManaged public var nutritionValueProt: String
    @NSManaged public var photoRef: String?
    @NSManaged public var timeToPrepare: Int64
    @NSManaged public var composition: NSSet?
    @NSManaged public var step: NSSet?

}

// MARK: Generated accessors for composition
extension CreationRecipeEntity {

    @objc(addCompositionObject:)
    @NSManaged public func addToComposition(_ value: CreationRecipeCompositionEntity)

    @objc(removeCompositionObject:)
    @NSManaged public func removeFromComposition(_ value: CreationRecipeCompositionEntity)

    @objc(addComposition:)
    @NSManaged public func addToComposition(_ values: NSSet)

    @objc(removeComposition:)
    @NSManaged public func removeFromComposition(_ values: NSSet)

}

// MARK: Generated accessors for step
extension CreationRecipeEntity {

    @objc(addStepObject:)
    @NSManaged public func addToStep(_ value: CreationRecipeStepEntity)

    @objc(removeStepObject:)
    @NSManaged public func removeFromStep(_ value: CreationRecipeStepEntity)

    @objc(addStep:)
    @NSManaged public func addToStep(_ values: NSSet)

    @objc(removeStep:)
    @NSManaged public func removeFromStep(_ values: NSSet)

}

extension CreationRecipeEntity : Identifiable {

}
