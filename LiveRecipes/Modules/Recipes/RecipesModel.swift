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
        
    func findRecipesByFilter(query: String, keyWords: [String], duration: Int, calories: String, contains: [String], notContains: [String],completion: @escaping ([RecipePreviewDTO]) -> Void) {
        print(contains)
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
    
