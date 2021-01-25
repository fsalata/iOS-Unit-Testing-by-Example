import UIKit

class ClosurePropertyViewController: UIViewController {
    var makeAnalytics: () -> Analytics = { Analytics.shared }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeAnalytics().track(event: "viewDidAppear - \(type(of: self))")
    }
}
