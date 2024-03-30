//
//  RecipesProtocols.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/5/24.
//

import Foundation
import SwiftUI

protocol RecipesViewModelProtocol {}

protocol RecipesModelProtocol {
    func findRecipe(name: String, completion: @escaping ([RecipeDTO])->Void)
    func getDesserts(completion: @escaping ([RecipeDTO])->Void)
}

protocol RecipesViewProtocol {}
