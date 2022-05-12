import Foundation
import PromiseKit

protocol MapInteractorProtocol {
    func doSomeAction(request: Map.SomeAction.Request)
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

    func doSomeAction(request: Map.SomeAction.Request) { }

    enum Error: Swift.Error {
        case something
    }
}

extension MapInteractor: MapInputProtocol { }