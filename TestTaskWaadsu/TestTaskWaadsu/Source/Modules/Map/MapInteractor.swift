import Foundation
import PromiseKit

protocol MapInteractorProtocol {
    func doMapUpdate(request: Map.MapUpdate.Request)
}

final class MapInteractor: MapInteractorProtocol {
    weak var moduleOutput: MapOutputProtocol?

    private let presenter: MapPresenterProtocol
    private let provider: MapProviderProtocol

    init(
        presenter: MapPresenterProtocol,
        provider: MapProviderProtocol
    ) {
        self.presenter = presenter
        self.provider = provider
    }

    func doMapUpdate(request: Map.MapUpdate.Request) {
        provider.fetch().done { features in
            self.presenter.presentMap(response: .init(result: .success(features)))
        }.catch { _ in
            self.presenter.presentMap(response: .init(result: .failure(Error.unloadable)))
        }
    }

    enum Error: Swift.Error {
        case unloadable
    }
}

extension MapInteractor: MapInputProtocol { }
