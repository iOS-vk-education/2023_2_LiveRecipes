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
                if dish.netId == -1 {
                    recipes.append(dish)
                }
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
        
    func findRecipesByFilter(query: String, keyWords: [String], duration: String, calories: String, protein: String, fats: String, carb: String, isMoreCal: Bool, isMoreProt: Bool, isMoreFats: Bool, isMoreCarb: Bool, contains: [String], notContains: [String], completion: @escaping ([RecipePreviewDTO]) -> Void) {
        recipeAPI.getRecipesByFilter(query: query, keyWords: keyWords, duration: duration, calories: calories, protein: protein, fats: fats, carb: carb, isMoreCal: isMoreCal, isMoreProt: isMoreProt, isMoreFats: isMoreFats, isMoreCarb: isMoreCarb, contains: contains, notContains: notContains) { [weak self] result in
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
                KeyWord(keyWord: "Фрукт"), KeyWord(keyWord: "Мексиканское"), KeyWord(keyWord: "Фрукты"), KeyWord(keyWord: "Нежный"), KeyWord(keyWord: "Утотченный"), KeyWord(keyWord: "Сладкая"), KeyWord(keyWord: "Карамель"), KeyWord(keyWord: "Мучное"), KeyWord(keyWord: "Английское"), KeyWord(keyWord: "Второе блюдо"), KeyWord(keyWord: "Полезное"), KeyWord(keyWord: "Легкое"), KeyWord(keyWord: "Вечер"),KeyWord(keyWord: "Ужин"), KeyWord(keyWord: "Обед"), KeyWord(keyWord: "Драники"), KeyWord(keyWord: "Сырники"), KeyWord(keyWord: "Итальянское"), KeyWord(keyWord: "Огонь"), KeyWord(keyWord: "Отдых"), KeyWord(keyWord: "Простое"), KeyWord(keyWord: "Постное"), KeyWord(keyWord: "Постный"), KeyWord(keyWord: "Лист"), KeyWord(keyWord: "Духовка"),KeyWord(keyWord: "В духовке") , KeyWord(keyWord: "Крепкое"), KeyWord(keyWord: "Крепкий"), KeyWord(keyWord: "Мука"), KeyWord(keyWord: "Сода"), KeyWord(keyWord: "Без молока"), KeyWord(keyWord: "Алкоголь")
            ]
        }
    }
    
