import UIKit

/*
@UIApplicationMain
*/
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions:
                    [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print(">> Launching with real app delegate")
        return true
    }
}
