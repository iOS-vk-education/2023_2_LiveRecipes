//
//  CreationRecipeEntity+CoreDataProperties.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 15.04.2024.
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
    @NSManaged public var nutritionValueCal: Int64
    @NSManaged public var nutritionValueCarb: Int64
    @NSManaged public var nutritionValueFats: Int64
    @NSManaged public var nutritionValueProt: Int64
    @NSManaged public var photoRef: String?
    @NSManaged public var timeToPrepare: Int64

}

extension CreationRecipeEntity : Identifiable {

}
