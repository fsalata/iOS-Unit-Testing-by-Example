import UIKit

class InstancePropertyViewController: UIViewController {
    lazy var analytics = Analytics.shared

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analytics.track(event: "viewDidAppear - \(type(of: self))")
    }
}
