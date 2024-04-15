//
//  DishComposition.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 15.04.2024.
//

import UIKit

class DishComposition: Identifiable {
    var id: Int
    var product: String
    var quantity: String
    init(id: Int, product: String, quantity: String) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }
    init(enity: CreationRecipeCompositionEntity) {
        self.id = Int(enity.id)
        self.product = enity.product
        self.quantity = enity.quantity
    }
}
