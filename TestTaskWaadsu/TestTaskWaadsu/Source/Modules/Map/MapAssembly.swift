import UIKit

final class MapAssembly: Assembly {
    var moduleInput: MapInputProtocol?

    private weak var moduleOutput: MapOutputProtocol?

    init(output: MapOutputProtocol? = nil) {
        self.moduleOutput = output
    }

    func makeModule(with context: ModuleContext?) -> UIViewController {
        guard let context = context else { return UIViewController() }
        let provider = MapProvider(mapNetworkService: context.moduleDependencies.mapNetworkService)
        let presenter = MapPresenter()
        let interactor = MapInteractor(presenter: presenter, provider: provider)
        let viewController = MapViewController(interactor: interactor)

        presenter.viewController = viewController
        self.moduleInput = interactor
        interactor.moduleOutput = self.moduleOutput

        return viewController
    }
}
