import UIKit

class ChangePasswordViewController: UIViewController {
    @IBOutlet private(set) var navigationBar: UINavigationBar!
    @IBOutlet private(set) var cancelBarButton: UIBarButtonItem!
    @IBOutlet private(set) var oldPasswordTextField: UITextField!
    @IBOutlet private(set) var newPasswordTextField: UITextField!
    @IBOutlet private(set) var confirmPasswordTextField: UITextField!
    @IBOutlet private(set) var submitButton: UIButton!
    lazy var passwordChanger: PasswordChanging = PasswordChanger()
    var securityToken = ""
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    let activityIndicator = UIActivityIndicatorView(style: .large)
    #if false
    private lazy var presenter = ChangePasswordPresenter(view: self)
    #endif
    #if false
    private lazy var presenter = ChangePasswordPresenter(view: self,
                                                         viewModel: viewModel)
    #endif
    private lazy var presenter =
            ChangePasswordPresenter(
                    view: self,
                    viewModel: viewModel,
                    securityToken: securityToken,
                    passwordChanger: passwordChanger)
    var viewModel: ChangePasswordViewModel!
    
    #if false
    var viewModel: ChangePasswordViewModel! {
        didSet {
            guard isViewLoaded else { return }

            if oldValue.isCancelButtonEnabled != viewModel.isCancelButtonEnabled {
                let enabled = viewModel.isCancelButtonEnabled
                cancelBarButton.isEnabled = enabled
            }
        }
    }
    #endif

    #if false
    private func updateInputFocus() {
        switch viewModel.inputFocus {
    /*
        let inputFocus = viewModel.inputFocus
        switch inputFocus {
    */
        case .noKeyboard:
            view.endEditing(true)
        case .oldPassword:
            oldPasswordTextField.becomeFirstResponder()
        case .newPassword:
            newPasswordTextField.becomeFirstResponder()
        case .confirmPassword:
            confirmPasswordTextField.becomeFirstResponder()
        }
    }
    #endif
    
    #if false
    private func updateInputFocus() {
        updateInputFocus(viewModel.inputFocus)
    }
    #endif

    #if false
    private func updateActivityIndicator() {
        if viewModel.isActivityIndicatorShowing {
            view.addSubview(activityIndicator)
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(
                        equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(
                        equalTo: view.centerYAnchor),
            ])
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    #endif
    
    #if false
    private func updateActivityIndicator() {
        if viewModel.isActivityIndicatorShowing {
            showActivityIndicator()
        } else {
            hideActivityIndicator()
        }
    }
    #endif

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
        setLabels()
    }

    private func setLabels() {
        navigationBar.topItem?.title = viewModel.title
        oldPasswordTextField.placeholder = viewModel.oldPasswordPlaceholder
        newPasswordTextField.placeholder = viewModel.newPasswordPlaceholder
        confirmPasswordTextField.placeholder =
                viewModel.confirmPasswordPlaceholder
        submitButton.setTitle(viewModel.submitButtonLabel, for: .normal)
    }

    #if false
    @IBAction private func cancel() {
        viewModel.inputFocus = .noKeyboard
        updateInputFocus(.noKeyboard)
        dismissModal()
    }
    #endif

    @IBAction private func cancel() {
        presenter.cancel()
    }
    
    #if false
    @IBAction private func changePassword() {
        #if false
        viewModel.passwordInputs.oldPassword = oldPasswordTextField.text ?? ""
        viewModel.passwordInputs.newPassword = newPasswordTextField.text ?? ""
        viewModel.passwordInputs.confirmPassword =
                confirmPasswordTextField.text ?? ""
        #endif
        let passwordInputs = PasswordInputs(
                oldPassword: oldPasswordTextField.text ?? "",
                newPassword: newPasswordTextField.text ?? "",
                confirmPassword: confirmPasswordTextField.text ?? "")
        /*
        guard validateInputs(passwordInputs: viewModel.passwordInputs) else {
        */
        guard presenter.validateInputs(passwordInputs: passwordInputs) else {
            return
        }
        presenter.setUpWaitingAppearance()
        #if false
        presenter.attemptToChangePassword(passwordInputs: viewModel.passwordInputs)
        #endif
        presenter.attemptToChangePassword(passwordInputs: passwordInputs)
    }
    #endif

    @IBAction private func changePassword() {
        let passwordInputs = PasswordInputs(
                oldPassword: oldPasswordTextField.text ?? "",
                newPassword: newPasswordTextField.text ?? "",
                confirmPassword: confirmPasswordTextField.text ?? "")
        presenter.changePassword(passwordInputs)
    }

    #if false
    func zz_changePassword(passwordInputs: PasswordInputs) {
        guard presenter.validateInputs(passwordInputs: passwordInputs) else {
            return
        }
        presenter.setUpWaitingAppearance()
        presenter.attemptToChangePassword(passwordInputs: passwordInputs)
    }
    #endif

    #if false
    private func validateInputs(passwordInputs: PasswordInputs) -> Bool {
        if viewModel.passwordInputs.isOldPasswordEmpty {
            updateInputFocus(.oldPassword)
            return false
        }
        
        if passwordInputs.isNewPasswordEmpty {
            showAlert(message: viewModel.enterNewPasswordMessage) {
                [weak self] _ in
                self?.updateInputFocus(.newPassword)
            }
            return false
        }

        if passwordInputs.isNewPasswordTooShort {
            showAlert(message: viewModel.newPasswordTooShortMessage) {
                [weak self] _ in
                self?.presenter.resetNewPasswords()
            }
            return false
        }

        if passwordInputs.isConfirmPasswordMismatched {
            showAlert(message: viewModel.confirmationPasswordDoesNotMatchMessage) {
                [weak self] _ in
                self?.presenter.resetNewPasswords()
            }
            return false
        }
        
        return true
    }
    #endif

    #if false
    private func resetNewPasswords() {
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
        updateInputFocus(.newPassword)
    }
    #endif

    #if false
    private func attemptToChangePassword() {
        presenter.attemptToChangePassword()
        passwordChanger.change(
                securityToken: securityToken,
                oldPassword: viewModel.oldPassword,
                newPassword: viewModel.newPassword,
                onSuccess: { [weak self] in
                    self?.presenter.handleSuccess()
                },
                onFailure: { [weak self] message in
                    self?.presenter.handleFailure(message)
                })
    }
    #endif
    
    #if false
    private func handleSuccess() {
        hideActivityIndicator()
        showAlert(message: viewModel.successMessage) { [weak self] _ in
            self?.dismiss(animated: true)
        }
    }
    #endif

    #if false
    private func handleSuccess() {
        presenter.handleSuccess()
    }
    #endif

    #if false
    private func handleFailure(_ message: String) {
        viewModel.isActivityIndicatorShowing = false
        hideActivityIndicator()
        showAlert(message: message) { [weak self] _ in
            self?.presenter.startOver()
        }
    }
    #endif
    
    #if false
    private func startOver() {
        oldPasswordTextField.text = ""
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
        updateInputFocus(.oldPassword)
        hideBlurView()
        setCancelButtonEnabled(true)
    }
    #endif
}

extension ChangePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === oldPasswordTextField {
            updateInputFocus(.newPassword)
        } else if textField === newPasswordTextField {
            updateInputFocus(.confirmPassword)
        } else if textField === confirmPasswordTextField {
            changePassword()
        }
        return true
    }
}

extension ChangePasswordViewController: ChangePasswordViewCommands {
    func setCancelButtonEnabled(_ enabled: Bool) {
        cancelBarButton.isEnabled = enabled
    }

    func updateInputFocus(_ inputFocus: InputFocus) {
        switch inputFocus {
        case .noKeyboard:
            view.endEditing(true)
        case .oldPassword:
            oldPasswordTextField.becomeFirstResponder()
        case .newPassword:
            newPasswordTextField.becomeFirstResponder()
        case .confirmPassword:
            confirmPasswordTextField.becomeFirstResponder()
        }
    }

    func showBlurView() {
        view.backgroundColor = .clear
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }

    func hideBlurView() {
        blurView.removeFromSuperview()
        view.backgroundColor = .white
    }

    func showActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }

    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    func dismissModal() {
        self.dismiss(animated: true)
    }

    func clearNewPasswordFields() {
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
    }

    func clearAllPasswordFields() {
        oldPasswordTextField.text = ""
        newPasswordTextField.text = ""
        confirmPasswordTextField.text = ""
    }

    func showAlert(message: String,
                   action: @escaping () -> Void) {
        let wrappedAction: (UIAlertAction) -> Void = { _ in action() }
        showAlert(message: message, okAction: { wrappedAction($0) })
    }

    private func showAlert(message: String,
                   okAction: @escaping (UIAlertAction) -> Void) {
        let alertController = UIAlertController(
                title: nil,
                message: message,
                preferredStyle: .alert)
        let okButton = UIAlertAction(
                title: viewModel.okButtonLabel,
                style: .default,
                handler: okAction)
        alertController.addAction(okButton)
        alertController.preferredAction = okButton
        self.present(alertController, animated: true)
    }
}
