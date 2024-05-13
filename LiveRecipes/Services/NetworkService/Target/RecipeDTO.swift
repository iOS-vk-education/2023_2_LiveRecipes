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


//struct RecipeDTO: Codable, Hashable {
//    var title: String
//    var ingredients: String
//    var servings: String
//    var instructions: String
//}
