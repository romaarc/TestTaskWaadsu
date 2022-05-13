import UIKit

protocol MapPresenterProtocol {
    func presentMap(response: Map.MapLoad.Response)
}

final class MapPresenter: MapPresenterProtocol {
    weak var viewController: MapViewControllerProtocol?

    func presentMap(response: Map.MapLoad.Response) {
        switch response.result {
        case .success(let result):
            ///Преобразую данные во вьюмодели
            let viewModel = MapViewModel(features: result)
            viewController?.displayMap(viewModel: .init(data: viewModel))
        case .failure(_):
            ///Обработать ошибку
            break
        }
    }
}
