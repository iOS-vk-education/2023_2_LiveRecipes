//
//  ListRecipeEntity+CoreDataProperties.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 17.04.2024.
//
//

import Foundation
import CoreData


extension ListRecipeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListRecipeEntity> {
        return NSFetchRequest<ListRecipeEntity>(entityName: "ListRecipeEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var listItem: NSSet?

}

// MARK: Generated accessors for listItem
extension ListRecipeEntity {

    @objc(addListItemObject:)
    @NSManaged public func addToListItem(_ value: ListRecipeItemEntity)

    @objc(removeListItemObject:)
    @NSManaged public func removeFromListItem(_ value: ListRecipeItemEntity)

    @objc(addListItem:)
    @NSManaged public func addToListItem(_ values: NSSet)

    @objc(removeListItem:)
    @NSManaged public func removeFromListItem(_ values: NSSet)

}

extension ListRecipeEntity : Identifiable {

}
