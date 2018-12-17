import UIKit

class MapCoordinator: Coordinator {
    private let presenter: UINavigationController
    private var mapViewController: MapViewController?
    private var coordinator: Coordinator?
    private let mapControllerServices: MapControllerServices
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
        self.mapControllerServices = MapControllerServices()
    }
    
    func start() {
        let mapViewController = UIStoryboard.Main.instantiateViewController(withIdentifier: MapViewController.storyboardID) as! MapViewController
        mapViewController.services = self.mapControllerServices
        self.mapViewController = mapViewController
        presenter.pushViewController(mapViewController, animated: false)
    }
}
