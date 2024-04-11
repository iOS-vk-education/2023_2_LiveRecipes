//
//  ListRecipeItemEntity+CoreDataProperties.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 11.04.2024.
//
//

import Foundation
import CoreData


extension ListRecipeItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListRecipeItemEntity> {
        return NSFetchRequest<ListRecipeItemEntity>(entityName: "ListRecipeItemEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var parentId: Int64

}

extension ListRecipeItemEntity : Identifiable {

}
