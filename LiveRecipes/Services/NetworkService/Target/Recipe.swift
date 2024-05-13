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
    case getDesserts
    case getToTime(name: NameToTime)
    case getById(id: Int)
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
        //return "https://api.api-ninjas.com/v1"
        return "https://liverecipes.online"
    }

    var path: String {
        switch self {
        case .getRecipe(let name):
            return "/queryset=\(name)"
        case .getDesserts:
            return "/desserts"
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
        }
        
    }

    var method: HTTPMethod {
        switch self {
            case .getRecipe, .getDesserts, .getAllList, .getToTime, .getRecipeToTime , .getById:
              return .get
        }
    }

    var task: NetworkTask {
        switch self {
            case .getRecipe, .getDesserts, .getAllList, .getToTime, .getRecipeToTime, .getById:
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
    func getRecipes(name: String, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void)
    func getDesserts(completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void)
    func getAllList(page: Int, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void)
    func getToTime(name: NameToTime, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void)
    func getRecipesToTime(type: NameToTime, name: String, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void)
}

class RecipeAPI: BaseAPI<RecipeTarget>, RecipeAPIProtocol {
    
    func getToTime(name: NameToTime, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void) {
        fetchData(target: .getToTime(name: name), responseClass: [RecipeDTO].self) { result in
            completionHandler(result)
        }
    }
    
    func getDesserts(completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void) {
        fetchData(target: .getDesserts, responseClass: [RecipeDTO].self) { result in completionHandler(result) }
    }
    
    func getRecipes(name: String, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void) {
        fetchData(target: .getRecipe(name: name), responseClass: [RecipeDTO].self) { result in completionHandler(result) }
    }

    
    func getRecipesToTime(type: NameToTime, name: String, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void) {
        fetchData(target: .getRecipeToTime(type: type, name: name), responseClass: [RecipeDTO].self) { result in completionHandler(result) }
    }
    
    func getAllList(page: Int, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void) {
        fetchData(target: .getAllList(page: page), responseClass: [RecipeDTO].self) { result in
            completionHandler(result)
        }
    func getRecipeById(id: Int, completionHandler: @escaping (Result<RecipeDTO, NSError>) -> Void){
        fetchData(target: .getById(id: id), responseClass: RecipeDTO.self) { result in completionHandler(result) }
    }
}

