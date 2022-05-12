//
//  AppDependency.swift
//  TestTaskWaadsu
//
//  Created by Roman Gorshkov on 12.05.2022.
//

import Foundation

protocol HasDependencies {
    var mapNetworkService: NetworkServiceProtocol { get }
}

///class AppDependency - зависимость контейнер с сервисами, для передачи в модули VIP
final class AppDependency {
    let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    static func makeDefault() -> AppDependency {
        let networkService = NetworkService()
        return AppDependency(networkService: networkService)
    }
}

extension AppDependency: HasDependencies {
    var mapNetworkService: NetworkServiceProtocol {
        return self.networkService
    }
}
