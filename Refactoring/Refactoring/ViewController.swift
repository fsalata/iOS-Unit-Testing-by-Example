import UIKit

final class ViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "changePassword" {
            let changePasswordVC = segue.destination
                    as? ChangePasswordViewController
            changePasswordVC?.securityToken = "TOKEN"
        }
    }
}
