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
            ]
        }
    }
    
