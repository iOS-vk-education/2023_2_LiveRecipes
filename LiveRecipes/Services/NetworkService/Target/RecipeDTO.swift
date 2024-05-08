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
    case "first_dishes":
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


//struct RecipeDTO: Codable, Hashable {
//    var title: String
//    var ingredients: String
//    var servings: String
//    var instructions: String
//}
