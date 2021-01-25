#if false
class ChangePasswordPresenter {
    private unowned var view: ChangePasswordViewCommands!

    init(view: ChangePasswordViewCommands) {
        self.view = view
    }
}
#endif

class ChangePasswordPresenter {
    private unowned var view: ChangePasswordViewCommands!
    #if false
    private var viewModel: ChangePasswordViewModel
    #endif
    private let viewModel: ChangePasswordViewModel
    private let securityToken: String
    private let passwordChanger: PasswordChanging

    #if false

    init(view: ChangePasswordViewCommands,
         viewModel: ChangePasswordViewModel) {
        self.view = view
        self.viewModel = viewModel
    }
    #endif

    init(view: ChangePasswordViewCommands,
         viewModel: ChangePasswordViewModel,
         securityToken: String,
         passwordChanger: PasswordChanging) {
        self.view = view
        self.viewModel = viewModel
        self.securityToken = securityToken
        self.passwordChanger = passwordChanger
    }

    func cancel() {
        view.updateInputFocus(.noKeyboard)
        view.dismissModal()
    }

    func changePassword(_ passwordInputs: PasswordInputs) {
        guard validateInputs(passwordInputs: passwordInputs) else {
            return
        }
        setUpWaitingAppearance()
        attemptToChangePassword(passwordInputs: passwordInputs)
    }

    private
    func validateInputs(passwordInputs: PasswordInputs) -> Bool {
        if passwordInputs.isOldPasswordEmpty {
            view.updateInputFocus(.oldPassword)
            return false
        }

        if passwordInputs.isNewPasswordEmpty {
            view.showAlert(message: viewModel.enterNewPasswordMessage) {
                [weak self] in
                self?.view.updateInputFocus(.newPassword)
            }
            return false
        }

        if passwordInputs.isNewPasswordTooShort {
            view.showAlert(message: viewModel.newPasswordTooShortMessage) {
                [weak self] in
                self?.resetNewPasswords()
            }
            return false
        }

        if passwordInputs.isConfirmPasswordMismatched {
            view.showAlert(
                    message: viewModel.confirmationPasswordDoesNotMatchMessage) {
                [weak self] in
                self?.resetNewPasswords()
            }
            return false
        }

        return true
    }

    private func resetNewPasswords() {
        view.clearNewPasswordFields()
        view.updateInputFocus(.newPassword)
    }

    private func setUpWaitingAppearance() {
        view.updateInputFocus(.noKeyboard)
        view.setCancelButtonEnabled(false)
        view.showBlurView()
        view.showActivityIndicator()
    }

    private func attemptToChangePassword(passwordInputs: PasswordInputs) {
        passwordChanger.change(
                securityToken: securityToken,
                oldPassword: passwordInputs.oldPassword,
                newPassword: passwordInputs.newPassword,
                onSuccess: { [weak self] in
                    self?.handleSuccess()
                },
                onFailure: { [weak self] message in
                    self?.handleFailure(message)
                })
    }

    private
    func handleSuccess() {
        view.hideActivityIndicator()
        view.showAlert(message: viewModel.successMessage) { [weak self] in
            self?.view.dismissModal()
        }
    }

    private
    func handleFailure(_ message: String) {
        view.hideActivityIndicator()
        view.showAlert(message: message) { [weak self] in
            self?.startOver()
        }
    }

    private
    func startOver() {
        view.clearAllPasswordFields()
        view.updateInputFocus(.oldPassword)
        view.hideBlurView()
        view.setCancelButtonEnabled(true)
    }

}
