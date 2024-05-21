//
//  Recipe.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/19/24.
//

import Alamofire
import Foundation

enum RecipeTarget {
    case getRecipe(name: String)
    case getRecipeToTime(type: NameToTime, name: String)
    case getAllList(page: Int)
    case getToTime(name: NameToTime)
    case getById(id: Int)
    case getByFilters(query: String, keyWord: [String], duration: String, calories: String, isCalMore: Bool, fats: String, isFatsMore: Bool, carb: String, isCarbMore: Bool, protein: String, isProtMore: Bool, ingrContains: [String], ingrNotContains: [String])
}

enum NameToTime {
    case breakfast
    case lunch
    case dinner
    case snacks
    
    var title: String {
        switch self {
            case .breakfast:
                "recipes.cooktotime.breakfast".localized
            case .lunch:
                "recipes.cooktotime.lunch".localized
            case .dinner:
                "recipes.cooktotime.dinner".localized
            case .snacks:
                "recipes.cooktotime.snack".localized
        }
    }
    
    var image: String {
        switch self {
            case .breakfast:
                "breakfastMain"
            case .lunch:
                "lunchMain"
            case .dinner:
                "dinnerMain"
            case .snacks:
                "snackMain"
        }
    }
}


extension RecipeTarget: TargetType {
    var baseURL: String {
        return "https://liverecipes.online"
        //return "http://127.0.0.1:8000"
    }

    var path: String {
        switch self {
            case .getRecipe(let name):
                return "/filters/?query=\(name)"
            case .getAllList(let page):
                return "/recipes_feed/?page=\(page)"
            case .getToTime(let name):
                    switch name {
                        case .breakfast:
                            return "/salads"
                        case .lunch:
                            return "/first_dishes"
                        case .dinner:
                            return "/second_dishes"
                        case .snacks:
                            return "/snacks"
                    }
            case .getRecipeToTime(let type, let name):
                    switch type {
                        case .breakfast:
                            return "/salads/querysetBreakfast=\(name)/"
                        case .lunch:
                            return "/first_dishes/querysetLunch=\(name)"
                        case .dinner:
                            return "/second_dishes/querysetDinner=\(name)"
                        case .snacks:
                            return "/snacks/querysetSnack=\(name)"
                    }
            case .getById(let id):
                return "/id/\(id)"
                    
            case .getByFilters(let query, let keywords, let duration, let calories, let isCalMore, let fats, let isFatsMore, let carb, let isCarbMore, let protein, let isProtMore, let ingrContains, let ingrNotContains):
                var path = ""
                
                if query == "" {
                    path = "/filters/?"
                } else {
                    path = "/filters/?query=\(query)&"
                }
                
                if !keywords.isEmpty {
                    for index in 0..<keywords.count {
                        path = path + "keyword\(index + 1)=\(keywords[index])&"
                    }
                }
                
                if duration != "" {
                    path = path + "duration=\(duration)&"
                }
                
                if calories != "" {
                    if isCalMore {
                        path = path + "caloriesm=\(calories)&"
                    } else {
                        path = path + "caloriesl=\(calories)&"
                    }
                }
                if protein != "" {
                    if isProtMore {
                        path = path + "proteinm=\(protein)&"
                    } else {
                        path = path + "proteinl=\(protein)&"
                    }
                }
                if carb != "" {
                    if isCarbMore {
                        path = path + "carbohydratesm=\(carb)&"
                    } else {
                        path = path + "carbohydratesl=\(carb)&"
                    }
                }
                if fats != "" {
                    if isFatsMore {
                        path = path + "fatsm=\(fats)&"
                    } else {
                        path = path + "fatsl=\(fats)&"
                    }
                }
                if !ingrContains.isEmpty {
                    for index in 0..<ingrContains.count {
                        print(ingrContains)
                        path = path + "ingredient\(index + 1)y=\(ingrContains[index])&"
                    }
                }
                
                if !ingrContains.isEmpty {
                    for index in 0..<ingrNotContains.count {
                        path = path + "ingredient\(index + 1)n=\(ingrNotContains[index])&"
                    }
                }
                path = path + "/"
                print(path)
                return path
            }
        }

    var method: HTTPMethod {
        switch self {
            case .getRecipe, .getAllList, .getToTime, .getRecipeToTime , .getById, .getByFilters:
              return .get
        }
    }

    var task: NetworkTask {
        switch self {
            case .getRecipe, .getAllList, .getToTime, .getRecipeToTime, .getById, .getByFilters:
              return .requestPlain
        }
    }

    var headers: [String:String]? {
        switch self {
            default: [
                "id" : "id",
                "duration": "duration",
                "tag": "tag",
                "name": "name"
            ]
        }
    }
}

protocol RecipeAPIProtocol {
    func getRecipes(name: String, completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void)
    func getAllList(page: Int, completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void)
    func getToTime(name: NameToTime, completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void)
    func getRecipesToTime(type: NameToTime, name: String, completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void)
    func getRecipeById(id: Int, completionHandler: @escaping (Result<RecipeDTO, NSError>) -> Void)
    func getRecipesByFilter(query: String, keyWords: [String], duration: String, calories: String, protein: String, fats: String, carb: String, isMoreCal: Bool, isMoreProt: Bool, isMoreFats: Bool, isMoreCarb: Bool, contains: [String], notContains: [String], completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void)
    func getRecipeByIdToMain(id: Int, completionHandler: @escaping (Result<RecipePreviewDTO, NSError>) -> Void)
}

class RecipeAPI: BaseAPI<RecipeTarget>, RecipeAPIProtocol {
    func getRecipeByIdToMain(id: Int, completionHandler: @escaping (Result<RecipePreviewDTO, NSError>) -> Void) {
        fetchData(target: .getById(id: id), responseClass: RecipePreviewDTO.self) { result in completionHandler(result) }
    }
    
    func getToTime(name: NameToTime, completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void) {
        fetchData(target: .getToTime(name: name), responseClass: [RecipePreviewDTO].self) { result in
            completionHandler(result)
        }
    }

    func getRecipes(name: String, completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void) {
        fetchData(target: .getRecipe(name: name), responseClass: [RecipePreviewDTO].self) { result in completionHandler(result) }
    }


    func getRecipesToTime(type: NameToTime, name: String, completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void) {
        fetchData(target: .getRecipeToTime(type: type, name: name), responseClass: [RecipePreviewDTO].self) { result in completionHandler(result) }
    }

    func getAllList(page: Int, completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void) {
        fetchData(target: .getAllList(page: page), responseClass: [RecipePreviewDTO].self) { result in
            completionHandler(result)
        }
    }
    func getRecipeById(id: Int, completionHandler: @escaping (Result<RecipeDTO, NSError>) -> Void){
            fetchData(target: .getById(id: id), responseClass: RecipeDTO.self) { result in completionHandler(result) }
    }
    func getRecipesByFilter(query: String, keyWords: [String], duration: String, calories: String, protein: String, fats: String, carb: String, isMoreCal: Bool, isMoreProt: Bool, isMoreFats: Bool, isMoreCarb: Bool, contains: [String], notContains: [String], completionHandler: @escaping (Result<[RecipePreviewDTO], NSError>) -> Void) {
        fetchData(target: .getByFilters(query: query, keyWord: keyWords, duration: duration, calories: calories, isCalMore: isMoreCal, fats: fats, isFatsMore: isMoreFats, carb: carb, isCarbMore: isMoreCarb, protein: protein, isProtMore: isMoreProt, ingrContains: contains, ingrNotContains: notContains), responseClass: [RecipePreviewDTO].self) { result in
            completionHandler(result)
        }
        print(query, keyWords)
    }
}

