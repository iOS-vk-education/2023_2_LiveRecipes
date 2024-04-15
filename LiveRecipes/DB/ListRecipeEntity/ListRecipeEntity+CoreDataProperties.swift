//
//  ListRecipeEntity+CoreDataProperties.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 11.04.2024.
//
//

import Foundation
import CoreData


extension ListRecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListRecipeEntity> {
        return NSFetchRequest<ListRecipeEntity>(entityName: "ListRecipeEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String

}

extension ListRecipeEntity : Identifiable {

}
