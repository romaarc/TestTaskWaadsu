import UIKit

protocol MapViewControllerProtocol: AnyObject {
    func displaySomeActionResult(viewModel: Map.SomeAction.ViewModel)
}

final class MapViewController: UIViewController {
    private let interactor: MapInteractorProtocol

    init(interactor: MapInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        let view = MapView(frame: UIScreen.main.bounds)
        self.view = view
    }
}

extension MapViewController: MapViewControllerProtocol {
    func displaySomeActionResult(viewModel: Map.SomeAction.ViewModel) { }
}
