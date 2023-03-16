//
//  Factory.swift
//  CatFacts
//
//  Created by Rameez Khan on 3/10/23.
//

import Foundation

final class Factory {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
