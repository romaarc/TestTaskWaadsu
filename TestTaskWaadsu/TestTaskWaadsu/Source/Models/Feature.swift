//
//  Feature.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let properties: Properties
    let geometry: Geometry
}
