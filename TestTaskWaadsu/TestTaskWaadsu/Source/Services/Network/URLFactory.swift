//
//  URLFactory.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import Foundation

/// enum URLFactory создает URLRequest
enum URLFactory {
    
    private static var baseURL: URL {
        return baseURLComponents.url!
    }
    
    private static let baseURLComponents: URLComponents = {
        let url = URL(string: API.main)!
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = []
        return urlComponents
    }()
    
    static func get() -> URLRequest {
        let urlComponents = baseURLComponents
        var request = URLRequest(url: urlComponents.url!.appendingPathComponent(API.TypeOf.russia))
        request.httpMethod = HTTPMethod.get.rawValue
        request.timeoutInterval = 30
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
