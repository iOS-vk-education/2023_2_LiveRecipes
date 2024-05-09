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
            guard self != nil else { return }
            switch result {
            case .success(let result):
                completion(result)
                case .failure(_):
                completion([])
            }
        })
    }
    
    func loadAllRecipesList(page: Int, completion: @escaping ([RecipeDTO]) -> Void) {
        recipeAPI.getAllList(page: page, completionHandler: {  [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let result):
                completion(result)
                case .failure(_):
                completion([])
            }
        })
    }

    func getDesserts(completion: @escaping ([RecipeDTO])->Void) {
        recipeAPI.getDesserts{ [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let result):
                completion(result)
                case .failure(_):
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
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупыЗавтраки"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "СалатыЗавтраки"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавЗавтракитраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавтраЗавтракики ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "ЗавтракиЗавтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗаЗавтракивтраки"), KeyWord(keyWord: "СаЗавтракилаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупыЗавтраки"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "СалатыЗавтраки"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавЗавтракитраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавтраЗавтракики ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "ЗавтракиЗавтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗаЗавтракивтраки"), KeyWord(keyWord: "СаЗавтракилаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупыЗавтраки"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "СалатыЗавтраки"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавЗавтракитраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавтраЗавтракики ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "ЗавтракиЗавтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗаЗавтракивтраки"), KeyWord(keyWord: "СаЗавтракилаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупыЗавтраки"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "СалатыЗавтраки"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавЗавтракитраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавтраЗавтракики ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "ЗавтракиЗавтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗаЗавтракивтраки"), KeyWord(keyWord: "СаЗавтракилаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупыЗавтраки"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "Супы"), KeyWord(keyWord: "Завтраки"), KeyWord(keyWord: "СалатыЗавтраки"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавЗавтракитраки"), KeyWord(keyWord: "Салаты"),
            KeyWord(keyWord: "СупЗавтракиы"), KeyWord(keyWord: "ЗавтраЗавтракики ЗавтраЗавтракики"), KeyWord(keyWord: "Салаты"),
        ]
    }

    func loadAllRecipes() -> [RecipeDTO] {
        
        return [
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar")
        ]
    }

    func loadRecentRecipes() -> [RecipeDTO] {
        
        return [
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
        ]
    }

    func loadMyRecipes() -> [RecipeDTO] {
        return [
//            RecipeDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar")
        ]
    }
}
