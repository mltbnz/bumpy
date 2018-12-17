import UIKit

class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var coordinator: Coordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.prefersLargeTitles = false
        
        coordinator = MapCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        coordinator.start()
        window.makeKeyAndVisible()
    }
}
