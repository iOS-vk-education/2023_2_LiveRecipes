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
    func loadRecentRecipes() -> [RecipePreviewDTO]
    func loadMyRecipes() -> [RecipePreviewDTO]
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

struct Recipe: Identifiable {
    let name: String
    let time: String
    let cathegory: String
    var isInFavorites: Bool = false
    let image: String
    
    mutating func changeStateOfFavorites() {
        if(isInFavorites == false) {
            isInFavorites = true
        }
        else {
            isInFavorites = false
        }
    }
    
    let id = UUID()
}
