//
//  RecipeDTO.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/19/24.
//

import Foundation

//struct RecipeDTO: Codable, Hashable {
//    var id: Int
//    var name: String
//    var bzy: [String: String]
//    var photo: String
//    var duration: String
//    var ingredients: [String]
//    var steps: [String: [String]]
//    var tag: [Int]
//}

struct RecipeDTO: Codable, Hashable {
    var title: String
    var ingredients: String
    var servings: String
    var instructions: String
}
