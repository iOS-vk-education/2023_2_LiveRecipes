//
//  Nutrition.swift
//  LiveRecipes
//
//  Created by  Alexander Fedoseev on 13.05.2024.
//

import Foundation

struct Nutrition : Codable, Hashable {
    var calories: String
    var protein: String
    var fats: String
    var carbohydrates: String
    init(calories: String, protein: String, fats: String, carbohydrates: String) {
        self.calories = calories
        self.protein = protein
        self.fats = fats
        self.carbohydrates = carbohydrates
    }
    init(bzy: BZY) {
        self.calories = bzy.calories
        self.protein = bzy.protein
        self.fats = bzy.fats
        self.carbohydrates = bzy.carbohydrates
    }
}
