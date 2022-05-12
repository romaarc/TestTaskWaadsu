import UIKit

protocol MapPresenterProtocol {
    func presentSomeActionResult(response: Map.SomeAction.Response)
}

final class MapPresenter: MapPresenterProtocol {
    weak var viewController: MapViewControllerProtocol?

    func presentSomeActionResult(response: Map.SomeAction.Response) { }
}