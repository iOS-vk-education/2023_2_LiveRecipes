//
//  RecipesModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class RecipesModel: ObservableObject, RecipesModelProtocol {}

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
