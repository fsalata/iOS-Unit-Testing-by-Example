import UIKit

final class ViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "changePassword" {
            let changePasswordVC = segue.destination
                    as! ChangePasswordViewController
            changePasswordVC.securityToken = "TOKEN"
            changePasswordVC.viewModel = ChangePasswordViewModel(
                    title: "Change Password",
                    oldPasswordPlaceholder: "Current Password",
                    newPasswordPlaceholder: "New Password",
                    confirmPasswordPlaceholder: "Confirm New Password",
                    submitButtonLabel: "Submit",
                    enterNewPasswordMessage: "Please enter a new password.",
                    newPasswordTooShortMessage: "The new password should have at least 6 characters.",
                    confirmationPasswordDoesNotMatchMessage: "The new password and the confirmation password don’t match. Please try again.",
                    successMessage: "Your password has been successfully changed.",
                    okButtonLabel: "OK"
            )
        }
    }
}
