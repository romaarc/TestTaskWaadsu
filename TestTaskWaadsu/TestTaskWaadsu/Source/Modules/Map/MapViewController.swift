import UIKit
import CoreLocation
import MapKit

protocol MapViewControllerProtocol: AnyObject {
    func displayMap(viewModel: Map.MapLoad.ViewModel)
}

final class MapViewController: UIViewController {
    private let interactor: MapInteractorProtocol
    
    var locationManager: CLLocationManager!
    
    var mainView: MapView? { self.view as? MapView }

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
        
        mainView?.mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        interactor.doMapUpdate(request: .init())
    }
}

extension MapViewController: MapViewControllerProtocol {
    func displayMap(viewModel: Map.MapLoad.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.mainView?.mapView.addOverlays([viewModel.data.multiPolygon])
            self?.mainView?.mapView.centerToLocation(
                .init(latitude: 55.7558, longitude: 37.6173),
                regionRadius: 250 * 10000)
            self?.mainView?.update(some: viewModel.data.distance)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer: MKOverlayRenderer
        switch overlay {
        case is MKMultiPolygon:
            let renderer = MKMultiPolygonRenderer(overlay: overlay as! MKMultiPolygon)
            renderer.strokeColor = .magenta
            renderer.lineWidth = 2
            renderer.alpha = 0.5
            return renderer
        default:
            renderer = MKOverlayRenderer(overlay: overlay)
        }
        return renderer
    }
}
