//
//  RecipeDTO.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/19/24.
//

import Foundation

struct BZY: Codable, Hashable {
    var calories: String
    var protein: String
    var fats: String
    var carbohydrates: String
}

struct RecipeDTO: Codable, Hashable {
    var id: Int
    var name: String
    var bzy: BZY
    var duration: String
    var photo: String
    var description: String
    var ingredients: [String]
    var steps: [[String]]
    var tag: String
}

//struct RecipeDTO: Codable, Hashable {
//    var title: String
//    var ingredients: String
//    var servings: String
//    var instructions: String
//}
