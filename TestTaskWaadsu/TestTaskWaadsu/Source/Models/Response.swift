//
//  Response.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let type: String
    let results: [T]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case results = "features"
    }
}
