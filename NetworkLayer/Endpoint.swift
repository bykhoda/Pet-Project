//
//  Endpoint.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum UserEndpoint: APIConfiguration {
    
    case getFeed
    case getPaginatedFeed(lastId: Int, lastSortingValue: Double)
    
    var method: HTTPMethod {
        switch self {
        case .getFeed, .getPaginatedFeed:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var path: String {
        switch self {
        case .getFeed, .getPaginatedFeed:
            return "feed"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getFeed:
            return nil
        case .getPaginatedFeed(let lastId, let lastSortingValue):
            return ["lastId" : lastId, "lastSortingValue": lastSortingValue]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        switch self {
        case .getFeed:
            let router = APIRouter.getFeed
            return try router.asURLRequest()
        case .getPaginatedFeed(let lastId, let lastSortingValue):
            let router = APIRouter.getPaginatedFeed(lastId: lastId, lastSortingValue: lastSortingValue)
            return try router.asURLRequest()
        }
    }
}
