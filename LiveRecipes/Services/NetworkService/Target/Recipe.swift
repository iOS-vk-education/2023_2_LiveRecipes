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
    case getDesserts
    case getById(id: Int)
}

extension RecipeTarget: TargetType {
    var baseURL: String {
        //return "https://api.api-ninjas.com/v1"
        return "https://liverecipes.online"
    }

    var path: String {
        switch self {
        case .getRecipe(let name):
            return "/recipe?query=\(name)"
        case .getDesserts:
            return "/desserts"
        case .getById(let id):
            return "/id/\(id)"
        }
        
    }

    var method: HTTPMethod {
        switch self {
        case .getRecipe, .getDesserts, .getById:
            return .get
        }
    }

    var task: NetworkTask {
        switch self {
        case .getRecipe, .getDesserts, .getById:
            return .requestPlain
        }
    }

    var headers: [String:String]? {
        switch self {
            default: ["X-Api-Key" : "9WYn3TW87sUX36rJ901CpQ==L21Qd6TelIhkHmk6"]
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
    func getRecipeById(id: Int, completionHandler: @escaping (Result<RecipeDTO, NSError>) -> Void){
        fetchData(target: .getById(id: id), responseClass: RecipeDTO.self) { result in completionHandler(result) }
    }
}

