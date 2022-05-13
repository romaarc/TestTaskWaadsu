import SnapKit
import UIKit
import MapKit

extension MapView {
    struct Appearance {
        let titleColor = UIColor.black
        let titleFont = Font.sber(ofSize: Font.Size.thirdyFour, weight: .regular)
    }
}

final class MapView: UIView {
    let appearance: Appearance
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let routeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(
        frame: CGRect = .zero,
        appearance: Appearance = Appearance()
    ) {
        self.appearance = appearance
        super.init(frame: frame)

        self.setupView()
        self.addSubviews()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        routeLabel.textColor = appearance.titleColor
        routeLabel.font = appearance.titleFont
    }

    func addSubviews() {
        [mapView, routeLabel].forEach { addSubview($0) }
    }

    func makeConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        routeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(27)
            make.trailing.equalToSuperview().offset(-27)
            make.bottom.equalToSuperview().offset(-70)
        }
    }
    
    func update(some text: String) {
        self.routeLabel.text = text
    }
}

extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance) {
      let coordinateRegion = MKCoordinateRegion(
        center: location.coordinate,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
    }
}
