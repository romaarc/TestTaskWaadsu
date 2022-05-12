import Foundation
import PromiseKit

protocol MapProviderProtocol {
    func fetch() -> Promise<[Feature]>
}

final class MapProvider: MapProviderProtocol {
    private let mapNetworkService: NetworkServiceProtocol
    
    init(mapNetworkService: NetworkServiceProtocol) {
        self.mapNetworkService = mapNetworkService
    }
    
    func fetch() -> Promise<[Feature]> {
        Promise { seal in
            self.mapNetworkService.fetch().done { response in
                seal.fulfill(response.results)
            }.catch() { _ in
                seal.reject(Error.mapsDataFetchFailed)
            }
        }
    }
    
    enum Error: Swift.Error {
        case mapsDataFetchFailed
    }
}
