import UIKit

class OverrideViewController: UIViewController {
    #if false
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Analytics.shared.track(event: "viewDidAppear - \(type(of: self))")
    }
    #endif

    #if false
    fileprivate func analytics() -> Analytics { Analytics.shared }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analytics().track(event: "viewDidAppear - \(type(of: self))")
    }
    #endif

    func analytics() -> Analytics { Analytics.shared }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        analytics().track(event: "viewDidAppear - \(type(of: self))")
    }
}
