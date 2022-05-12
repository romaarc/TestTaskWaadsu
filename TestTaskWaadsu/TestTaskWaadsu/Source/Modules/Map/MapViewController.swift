import UIKit

protocol MapViewControllerProtocol: AnyObject {
    func displayMap(viewModel: Map.MapLoad.ViewModel)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.doMapUpdate(request: .init())
    }
}

extension MapViewController: MapViewControllerProtocol {
    func displayMap(viewModel: Map.MapLoad.ViewModel) {
        //print(viewModel.data)
    }
}
