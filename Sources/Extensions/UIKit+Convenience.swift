import UIKit

extension UIViewController {
    static var storyboardID: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    static var Main: UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
}

extension UIColor {
    static let translucent = UIColor(named: "translucent")
}
