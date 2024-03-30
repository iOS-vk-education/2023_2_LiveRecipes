//
//  TargetType.swift
//  LiveRecipes
//
//  Created by Leonid Perlin on 3/19/24.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

enum NetworkTask {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

protocol TargetType {
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var task: NetworkTask {get}
    var headers: [String: String]? {get}
}
