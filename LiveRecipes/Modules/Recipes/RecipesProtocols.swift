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
    func findRecipe(name: String, completion: @escaping ([RecipePreviewDTO])->Void)
    func findRecipesToTime(type: NameToTime, name: String, completion: @escaping ([RecipePreviewDTO]) -> Void)
    func loadKeyWords() -> [KeyWord]
    func getAllRecipes(page: Int, completion: @escaping([RecipePreviewDTO]) -> Void)
    func getToTimeRecipes(name: NameToTime, completion: @escaping([RecipePreviewDTO]) -> Void)
    func findRecipesByFilter(query: String, keyWords: [String], duration: Int, calories: String, contains: [String], notContains: [String], completion: @escaping ([RecipePreviewDTO]) -> Void)
}

protocol RecipesViewProtocol {}

struct KeyWord: Identifiable {
    let keyWord: String
    var isChoosed: Bool = false
    
    var id = UUID()
    
    mutating func choose() {
        if (isChoosed == false) {
            isChoosed = true
        }
        else {
            isChoosed = false
        }
    }
}
