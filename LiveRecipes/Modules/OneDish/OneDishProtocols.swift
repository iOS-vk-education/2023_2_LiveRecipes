//
//  OneDishProtocols.swift
//  LiveRecipes
//
//  Created by Сергей Мирошниченко on 30.03.2024.
//

import Foundation

protocol OneDishModelProtocol {
    func findRecipe(id: Int, completion: @escaping (RecipeDTO) -> Void)
}

protocol OneDishViewModelProtocol {
    func findRecipe() -> Void
}


