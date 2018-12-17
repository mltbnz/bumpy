import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    private var userTrackingButton: MKUserTrackingButton!
    private var scaleView: MKScaleView!
    
    public var services: MapControllerServices!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupUserTrackingButtonAndScaleView()
        services.bumpyController.start()
    }
    
    private func setupMapView() {
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    private func setupUserTrackingButtonAndScaleView() {
        userTrackingButton = MKUserTrackingButton(mapView: mapView)
        userTrackingButton.layer.borderColor = UIColor.white.cgColor
        userTrackingButton.layer.backgroundColor = UIColor.translucent?.cgColor
        userTrackingButton.layer.borderWidth = 1
        userTrackingButton.layer.cornerRadius = 5
        userTrackingButton.isHidden = false // Unhides when location authorization is given.
        view.addSubview(userTrackingButton)
        
        scaleView = MKScaleView(mapView: mapView)
        scaleView.legendAlignment = .trailing
        view.addSubview(scaleView)
        
        let stackView = UIStackView(arrangedSubviews: [scaleView, userTrackingButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                                     stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)])
    }
}

