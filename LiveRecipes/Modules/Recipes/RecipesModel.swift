//
//  RecipesModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class RecipesModel: ObservableObject, RecipesModelProtocol {
    let recipeAPI: RecipeAPI
    @Published var foundRecipes: [RecipeDTO] = []

    init(recipeAPI: RecipeAPI) {
        self.recipeAPI = recipeAPI
    }

    func findRecipe(name: String, completion: @escaping ([RecipeDTO])->Void) {
        recipeAPI.getRecipes(name: name, completionHandler: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                completion([])
            }
        })
    }

    func getDesserts(completion: @escaping ([RecipeDTO])->Void) {
        recipeAPI.getDesserts{ [weak self] result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(let error):
                completion([])
            }
        }
    }
    
    //мок на главную и переходы
    func loadKeyWords() -> [KeyWord] {
        return [
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "ЗавтракиЗавтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗаЗавтракивтраки"), KeyWord(keyWord: "СаЗавтракилаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупыЗавтраки"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "СалатыЗавтраки"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавЗавтракитраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты")
        ]
    }

    func loadAllRecipes() -> [Recipe] {
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

    func loadRecentRecipes() -> [Recipe] {
        return [
            Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar"),
            Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "cesar"),
        ]
    }

    func loadMyRecipes() -> [Recipe] {
        return [
//            Recipe(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "cesar")
        ]
    }
}
