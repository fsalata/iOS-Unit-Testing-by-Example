import UIKit

protocol UserDefaultsProtocol {
    func set(_ value: Int, forKey defaultName: String)
    func integer(forKey defaultName: String) -> Int
}

extension UserDefaults: UserDefaultsProtocol {}

class ViewController: UIViewController {
    @IBOutlet private(set) var counterLabel: UILabel!
    @IBOutlet private(set) var incrementButton: UIButton!

#if false
    var userDefaults = UserDefaults.standard
#endif
    var userDefaults: UserDefaultsProtocol = UserDefaults.standard
    
#if false
    private var count = 0 {
        didSet {
            counterLabel.text = "\(count)"
            UserDefaults.standard.set(count, forKey: "count")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        count = UserDefaults.standard.integer(forKey: "count")
    }
#endif

    private var count = 0 {
        didSet {
            counterLabel.text = "\(count)"
            userDefaults.set(count, forKey: "count")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        count = userDefaults.integer(forKey: "count")
    }

    @IBAction private func incrementButtonTapped() {
        count += 1
    }
}
