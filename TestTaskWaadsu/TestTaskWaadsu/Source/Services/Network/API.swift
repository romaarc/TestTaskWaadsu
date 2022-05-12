//
//  API.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import Foundation
/// enum API содержит в себе основной линк на апи и подтипы
enum API {
    static let main = "https://waadsu.com/api"
    
    enum TypeOf {
        static let russia = "/russia.geo.json"
    }
}
