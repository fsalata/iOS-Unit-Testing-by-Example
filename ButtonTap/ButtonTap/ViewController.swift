import UIKit

class ViewController: UIViewController {
    #if false
    @IBOutlet private var button: UIButton!
    #endif

    @IBOutlet private(set) var button: UIButton!

    @IBAction private func buttonTap() {
        print(">> Button was tapped")
    }
}
