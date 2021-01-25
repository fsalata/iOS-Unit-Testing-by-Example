import UIKit

/*
class ChangePasswordViewController: UIViewController, UITextFieldDelegate {
*/
class ChangePasswordViewController: UIViewController {
    @IBOutlet private(set) var navigationBar: UINavigationBar!
    @IBOutlet private(set) var cancelBarButton: UIBarButtonItem!
    @IBOutlet private(set) var oldPasswordTextField: UITextField!
    @IBOutlet private(set) var newPasswordTextField: UITextField!
    @IBOutlet private(set) var confirmPasswordTextField: UITextField!
    @IBOutlet private(set) var submitButton: UIButton!
#if false
    private var passwordChanger = PasswordChanger()
    private var passwordChanger: PasswordChanging = PasswordChanger()
#endif
    lazy var passwordChanger: PasswordChanging = PasswordChanger()
    var securityToken = ""
    #if false
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    #endif
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(
                red: 55/255.0, green: 147/255.0, blue: 251/255.0, alpha: 1
        ).cgColor
        submitButton.layer.cornerRadius = 8
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
    }

    @IBAction private func cancel() {
        #if false
        oldPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        #endif
        view.endEditing(true)
        dismiss(animated: true)
    }
    
    #if false
    @IBAction private func changePassword() {
        // 1. Validate inputs
        if oldPasswordTextField.text?.isEmpty ?? true {
            oldPasswordTextField.becomeFirstResponder()
            return
        }

        if newPasswordTextField.text?.isEmpty ?? true {
            let alertController = UIAlertController(
                    title: nil,
                    message: "Please enter a new password.",
                    preferredStyle: .alert)
            let okButton = UIAlertAction(
                    title: "OK",
                    style: .default) { [weak self] _ in
                self?.newPasswordTextField.becomeFirstResponder()
            }
            alertController.addAction(okButton)
            alertController.preferredAction = okButton
            self.present(alertController, animated: true)
            return
        }

        if newPasswordTextField.text?.count ?? 0 < 6 {
            let alertController = UIAlertController(title: nil,
                message: "The new password should have at least 6 characters.",
                preferredStyle: .alert)
            let okButton = UIAlertAction(
                    title: "OK",
                    style: .default) { [weak self] _ in
                self?.newPasswordTextField.text = ""
                self?.confirmPasswordTextField.text = ""
                self?.newPasswordTextField.becomeFirstResponder()
            }
            alertController.addAction(okButton)
            alertController.preferredAction = okButton
            self.present(alertController, animated: true)
            return
        }

        if newPasswordTextField.text != confirmPasswordTextField.text {
            let alertController = UIAlertController(title: nil,
                    message: "The new password and the confirmation password "
                            + "don’t match. Please try again.",
                    preferredStyle: .alert)
            let okButton = UIAlertAction(
                    title: "OK",
                    style: .default) { [weak self] _ in
                self?.newPasswordTextField.text = ""
                self?.confirmPasswordTextField.text = ""
                self?.newPasswordTextField.becomeFirstResponder()
            }
            alertController.addAction(okButton)
            alertController.preferredAction = okButton
            self.present(alertController, animated: true)
            return
        }

        // 2. Set up waiting appearance
        oldPasswordTextField.resignFirstResponder()
        newPasswordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        cancelBarButton.isEnabled = false
        view.backgroundColor = .clear
        view.addSubview(blurView)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            activityIndicator.centerXAnchor.constraint(
                    equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(
                    equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()

        // 3. Attempt to change password
        passwordChanger.change(
            securityToken: securityToken,
            oldPassword: oldPasswordTextField.text ?? "",
            newPassword: newPasswordTextField.text ?? "",
            onSuccess: { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.removeFromSuperview()
                let alertController = UIAlertController(
                        title: nil,
                        message: "Your password has been successfully changed.",
                        preferredStyle: .alert)
                let okButton = UIAlertAction(
                        title: "OK",
                        style: .default) { [weak self] _ in
                    self?.dismiss(animated: true)
                }
                alertController.addAction(okButton)
                alertController.preferredAction = okButton
                self?.present(alertController, animated: true)
            },
            onFailure: { [weak self] message in
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.removeFromSuperview()
                let alertController = UIAlertController(
                        title: nil,
                        message: message,
                        preferredStyle: .alert)
                let okButton = UIAlertAction(
                        title: "OK",
                        style: .default) { [weak self] _ in
                    self?.oldPasswordTextField.text = ""
                    self?.newPasswordTextField.text = ""
                    self?.confirmPasswordTextField.text = ""
                    self?.oldPasswordTextField.becomeFirstResponder()
                    self?.view.backgroundColor = .white
                    self?.blurView.removeFromSuperview()
                    self?.cancelBarButton.isEnabled = true
                }
                alertController.addAction(okButton)
                alertController.preferredAction = okButton
                self?.present(alertController, animated: true)
            })
    }
    #endif

    @IBAction private func changePassword() {
        guard validateInputs() else {
            return
        }
        setUpWaitingAppearance()
        attemptToChangePassword()
    }
    
    private func validateInputs() -> Bool {
        if oldPasswordTextField.text?.isEmpty ?? true {
            oldPasswordTextField.becomeFirstResponder()
            return false
        }

        #if false
        if newPasswordTextField.text?.isEmpty ?? true {
            let alertController = UIAlertController(
                    title: nil,
                    message: "Please enter a new password.",
                    preferredStyle: .alert)
            let okButton = UIAlertAction(
                    title: "OK",
                    style: .default) { [weak self] _ in
                self?.newPasswordTextField.becomeFirstResponder()
            }
            alertController.addAction(okButton)
            alertController.preferredAction = okButton
            self.present(alertController, animated: true)
            return false
        }
        #endif

        if newPasswordTextField.text?.isEmpty ?? true {
            #if false
            let message = "Please enter a new password."
            let okAction: (UIAlertAction) -> Void = { [weak self] _ in
                self?.newPasswordTextField.becomeFirstResponder()
            }
            showAlert(message: message, okAction: okAction)
            #endif

            #if false
            showAlert(message, okAction)
            #endif

            #if false
            let message = "Please enter a new password."
            let okAction: (UIAlertAction) -> Void = { [weak self] _ in
                self?.newPasswordTextField.becomeFirstResponder()
            }
            showAlert(message: "Please enter a new password.", okAction: okAction)
            #endif
            
            #if false
            showAlert(message: "Please enter a new password.",
                      okAction: { [weak self] _ in
                          self?.newPasswordTextField.becomeFirstResponder()
                      })
            #endif

            showAlert(message: "Please enter a new password.") { [weak self] _ in
                self?.newPasswordTextField.becomeFirstResponder()
            }
            return false
        }
          /*
            let okButton = UIAlertAction(
                    title: "OK",
                    style: .default) okAction
          */

        if newPasswordTextField.text?.count ?? 0 < 6 {
            showAlert(message: "The new password should have at least 6 characters.") { [weak self] _ in
                self?.resetNewPasswords()
            }
            return false
        }

        if newPasswordTextField.text != confirmPasswordTextField.text {
            showAlert(message: "The new password and the confirmation password don’t match. Please try again.") { [weak self] _ in
                self?.resetNewPasswords()
            }
            return false
        }
        
        return true
    }

    private func resetNewPasswords() {
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
        newPasswordTextField.becomeFirstResponder()
    }

    private func setUpWaitingAppearance() {
        view.endEditing(true)
        cancelBarButton.isEnabled = false
        view.backgroundColor = .clear
        view.addSubview(blurView)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }

    private func attemptToChangePassword() {
        passwordChanger.change(
                securityToken: securityToken,
                oldPassword: oldPasswordTextField.text ?? "",
                newPassword: newPasswordTextField.text ?? "",
                onSuccess: { [weak self] in
                    #if false
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.removeFromSuperview()
                    #endif
                    self?.hideSpinner()
                    self?.showAlert(message: "Your password has been successfully changed.") { [weak self] _ in
                        self?.dismiss(animated: true)
                    }
                },
                onFailure: { [weak self] message in
                    self?.hideSpinner()
                    self?.showAlert(message: message) { [weak self] _ in
                        self?.startOver()
                    }
                })
    }

    private func hideSpinner() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    private func startOver() {
        oldPasswordTextField.text = ""
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
        oldPasswordTextField.becomeFirstResponder()
        view.backgroundColor = .white
        blurView.removeFromSuperview()
        cancelBarButton.isEnabled = true
    }

    /*
    private func showAlert(_ message: String,
                           _ okAction: @escaping (UIAlertAction) -> Void) {
    */
    private func showAlert(message: String,
                           okAction: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: .alert)
        let okButton = UIAlertAction(
            title: "OK",
            style: .default,
            handler: okAction)
        alertController.addAction(okButton)
        alertController.preferredAction = okButton
        self.present(alertController, animated: true)
    }
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === oldPasswordTextField {
            newPasswordTextField.becomeFirstResponder()
        } else if textField === newPasswordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else if textField === confirmPasswordTextField {
            changePassword()
        }
        return true
    }
}
