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
    func getMyRecipes() -> [Dish]
    func findRecipe(name: String, completion: @escaping ([RecipePreviewDTO])->Void)
    func findRecipesToTime(type: NameToTime, name: String, completion: @escaping ([RecipePreviewDTO]) -> Void)
    func loadKeyWords() -> [KeyWord]
    func getAllRecipes(page: Int, completion: @escaping([RecipePreviewDTO]) -> Void)
    func getToTimeRecipes(name: NameToTime, completion: @escaping([RecipePreviewDTO]) -> Void)
    func findRecipesByFilter(query: String, keyWords: [String], duration: String, calories: String, protein: String, fats: String, carb: String, isMoreCal: Bool, isMoreProt: Bool, isMoreFats: Bool, isMoreCarb: Bool, contains: [String], notContains: [String], completion: @escaping ([RecipePreviewDTO]) -> Void)
    func findRecipe(id: Int, completion: @escaping (RecipePreviewDTO)->Void)
    func findRecipeForCoreData(id: Int, completion: @escaping (RecipeDTO)->Void)
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
