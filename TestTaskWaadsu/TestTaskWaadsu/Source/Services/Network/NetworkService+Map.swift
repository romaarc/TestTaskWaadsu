//
//  NetworkService+Map.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import Foundation
import PromiseKit

/// extension NetworkService реализуем метод протокола NetworkServiceProtocol
extension NetworkService: NetworkServiceProtocol {
    func fetch() -> Promise<Response<Feature>> {
        baseRequest(request: URLFactory.getURL())
    }
}
