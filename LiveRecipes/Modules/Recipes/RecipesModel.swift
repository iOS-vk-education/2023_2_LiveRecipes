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
    
    func getMyRecipes() -> [Dish] {
        var recipes: [Dish] = []
        RecipeDataManager.shared.fetch { dishes in
            for dish in dishes {
                recipes.append(dish)
            }
        }
        return recipes
    }
    
    func findRecipe(id: Int, completion: @escaping (RecipePreviewDTO)->Void) {
        recipeAPI.getRecipeByIdToMain(id: id, completionHandler: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let result):
                completion(result)
            case .failure(_):
                completion(RecipePreviewDTO(name: "", duration: 0, tag: "", photo: "", id: -1))
            }
        })
    }
    func findRecipeForCoreData(id: Int, completion: @escaping (RecipeDTO)->Void) {
        recipeAPI.getRecipeById(id: id, completionHandler: { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let result):
                completion(result)
            case .failure(_):
                completion(RecipeDTO(id: 0, name: "", bzy: BZY(calories: "0", protein: "0", fats: "0", carbohydrates: "0"), duration: 0, photo: "", description: "", ingredients: [], steps: [[]], tag: ""))
            }
        })
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
        
    func findRecipesByFilter(query: String, keyWords: [String], duration: String, calories: String, contains: [String], notContains: [String],completion: @escaping ([RecipePreviewDTO]) -> Void) {
        recipeAPI.getRecipesByFilter(query: query, keyWords: keyWords, duration: duration, calories: calories, contains: contains, notContains: notContains) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let result):
                    completion(result)
                case .failure(_):
                    completion([])
            }
        }
    }

        func loadKeyWords() -> [KeyWord] {
            return [
                KeyWord(keyWord: "Суп"), KeyWord(keyWord: "Завтрак"), KeyWord(keyWord: "Салат"), KeyWord(keyWord: "Вкус"), KeyWord(keyWord: "Быстрое"), KeyWord(keyWord: "Дессерт"), KeyWord(keyWord: "Секрет"), KeyWord(keyWord: "Тесто"),
                KeyWord(keyWord: "Форма"), KeyWord(keyWord: "Сахар"), KeyWord(keyWord: "Сладкое"), KeyWord(keyWord: "Традиционное"), KeyWord(keyWord: "Легкий"), KeyWord(keyWord: "Диета"), KeyWord(keyWord: "Пудинг"), KeyWord(keyWord: "Сироп"),
                KeyWord(keyWord: "Фрукт")
            ]
        }
    }
    
