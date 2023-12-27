//
//  Constants.swift
//  Pet Project
//
//  Created by Danila Bykhovoy on 27.12.2023.
//

import Foundation

struct Constants {
    
    static let baseURLString = "https://api.dtf.ru/v2.4/"
    static let baseImageURLString = "https://leonardo.osnova.io/"
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
    
}
