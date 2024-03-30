//
//  RecipesViewModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class RecipesViewModel: ObservableObject, RecipesViewModelProtocol {
    var model: RecipesModelProtocol

    init(recipesModel: RecipesModel) {
        self.model = recipesModel
    }
}

func loadKeyWords() async throws -> [KeyWord] {
    return [
        KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
        KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
        KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
        KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
        KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты")
    ]
}

func loadAllRecipes() async throws -> [Recipe] {
    return [
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar"),
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "cesar"),
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar"),
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar"),
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "cesar"),
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar"),
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar"),
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "cesar"),
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar")
    ]
}

func loadRecentRecipes() async throws -> [Recipe] {
    return [
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar"),
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "cesar"),
    ]
}

func loadMyRecipes() async throws -> [Recipe] {
    return [
        Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar")
    ]
}
