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

struct RecipePreviewDTO: Codable, Hashable, Identifiable {
    let name: String
    let duration: Int
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
    func decomposeDuration() -> String {
        let hours = duration / 60
        let minutes = duration % 60
        
        if hours > 0 {
            return "\(hours)" + "cookingPrepare.hours".localized + "\(minutes)" + "cookingPrepare.minutes".localized
        } else {
            return "\(minutes)" + "cookingPrepare.minutes".localized
        }
    }
}

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
    var duration: Int
    var photo: String
    var description: String
    var ingredients: [String]
    var steps: [[String]]
    var tag: String
    
    func decomposeDuration() -> (Int, Int, Int) {
        let days = duration / 60 / 24
        let hours = duration / 60
        let minutes = duration % 60
        
        return (days, hours, minutes)
    }
}

func getTranslation(_ dishType: String) -> String {
    switch dishType {
    case "dessert":
        return "Дессерт".localized
    case "drink":
        return "Напиток".localized
    case "snack":
        return "Закуска".localized
    case "garnish":
        return "Гарнир".localized
    case "firstDish":
        return "Первое блюдо".localized
    case "salad":
        return "Салат".localized
    case "sauce":
        return "Соус".localized
    case "secondDish":
        return "Второе блюдо".localized
    case "bakery":
        return "Выпечка".localized
    case "harvesting":
        return "Заготовка".localized
    default:
        return "Блюдо".localized

    }
}
