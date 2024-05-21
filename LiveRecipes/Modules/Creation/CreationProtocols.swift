//
//  CreationProtocols.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 26.03.2024.
//

import Foundation

protocol CreationViewModelProtocol {
    func addDishComposition(product: String, quantity: String)
    func deleteDishComposition(index: Int)
}

protocol CreationModelProtocol {
    func showRecipesInDB()
    func createRecipy(dish: Dish, completion: @escaping() -> Void)
    func isCreationPossible(dish: Dish) -> CreationError?
}

protocol CreationViewProtocol {}
