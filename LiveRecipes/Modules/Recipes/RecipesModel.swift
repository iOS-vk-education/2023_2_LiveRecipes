//
//  RecipesModel.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/14/24.
//

import Foundation

final class RecipesModel: ObservableObject, RecipesModelProtocol {
    
    
    let recipeAPI: RecipeAPI
    //@Published var foundRecipes: [RecipePreviewDTO] = []
    
    init(recipeAPI: RecipeAPI) {
        self.recipeAPI = recipeAPI
    }
    
    func findRecipe(name: String, completion: @escaping ([RecipePreviewDTO])->Void) {
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
    
    func getAllRecipes(page: Int, completion: @escaping ([RecipePreviewDTO]) -> Void) {
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
    
    func getToTimeRecipes(name: NameToTime, completion: @escaping ([RecipePreviewDTO]) -> Void) {
        recipeAPI.getToTime(name: name) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let result):
                    completion(result)
                case .failure(_):
                    completion([])
            }
        }
    }
    
    func findRecipesToTime(type: NameToTime, name: String, completion: @escaping ([RecipePreviewDTO]) -> Void) {
        recipeAPI.getRecipesToTime(type: type, name: name, completionHandler: { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let result):
                    completion(result)
                case .failure(_):
                    completion([])
            }
        })
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
        
        func loadAllRecipes() -> [RecipePreviewDTO] {
            
            return [
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar")
            ]
        }
        
        func loadRecentRecipes() -> [RecipePreviewDTO] {
            
            return [
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar"),
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", isInFavorites: true, image: "caesar"),
            ]
        }
        
        func loadMyRecipes() -> [RecipePreviewDTO] {
            return [
                //            RecipePreviewDTO(name: "Цезарь с креветками", time: "20-30", cathegory: "Салаты", image: "caesar")
            ]
        }
    }
    
