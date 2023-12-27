//
//  APIRouter.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
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
        let url = try Constants.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.contentType.rawValue)
        urlRequest.setValue(Constants.ContentType.json.rawValue, forHTTPHeaderField: Constants.HttpHeaderField.acceptType.rawValue)
        
        if let parameters = parameters {
            do {
                urlRequest = try encoding.encode(urlRequest, with: parameters)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
