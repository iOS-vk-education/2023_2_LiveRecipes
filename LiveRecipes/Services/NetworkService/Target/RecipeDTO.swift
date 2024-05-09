//
//  RecipeDTO.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/19/24.
//

import Foundation
import SwiftUI
import UIKit
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

struct RecipeDTO: Codable, Hashable, Identifiable {
    
    let name: String
    let duration: String
    let tag: String
    let photo: String
    let id: Int
    var isInFavorites: Bool?
    mutating func changeStateOfFavorites() {
        if (isInFavorites == nil) {isInFavorites = false}
        if(isInFavorites == false) {
            isInFavorites = true
        }
        else {
            isInFavorites = false
        }
    }
}
