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
    case getAllList(page: Int)
    case getDesserts
}

extension RecipeTarget: TargetType {
    var baseURL: String {
        return "http://127.0.0.1:8000"
    }

    var path: String {
        switch self {
        case .getRecipe(let name):
            return "/queryset=\(name)"
        case .getDesserts:
            return "/desserts"
        case .getAllList(let page):
            return "/recipes_feed/?page=\(page)"
        }
    }

    var method: HTTPMethod {
        switch self {
            case .getRecipe, .getDesserts, .getAllList:
            return .get
        }
    }

    var task: NetworkTask {
        switch self {
            case .getRecipe, .getDesserts, .getAllList:
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
}

class RecipeAPI: BaseAPI<RecipeTarget>, RecipeAPIProtocol {
    func getDesserts(completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void) {
        fetchData(target: .getDesserts, responseClass: [RecipeDTO].self) { result in completionHandler(result) }
    }
    
    func getRecipes(name: String, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void) {
        fetchData(target: .getRecipe(name: name), responseClass: [RecipeDTO].self) { result in completionHandler(result) }
    }
    func getAllList(page: Int, completionHandler: @escaping (Result<[RecipeDTO], NSError>) -> Void) {
        fetchData(target: .getAllList(page: page), responseClass: [RecipeDTO].self) { result in
            completionHandler(result)
        }
    }
}

