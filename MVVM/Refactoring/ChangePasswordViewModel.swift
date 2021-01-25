struct ChangePasswordViewModel {
    let title: String
    let oldPasswordPlaceholder: String
    let newPasswordPlaceholder: String
    let confirmPasswordPlaceholder: String
    let submitButtonLabel: String
    let enterNewPasswordMessage: String
    let newPasswordTooShortMessage: String
    let confirmationPasswordDoesNotMatchMessage: String
    let successMessage: String
    let okButtonLabel: String
    var isCancelButtonEnabled = true
    var isBlurViewShowing = false
    var isActivityIndicatorShowing = false
    var oldPassword = ""
    var newPassword = ""
    var confirmPassword = ""
    var inputFocus: InputFocus = .noKeyboard

    enum InputFocus {
        case noKeyboard
        case oldPassword
        case newPassword
        case confirmPassword
    }

    var isOldPasswordEmpty: Bool { oldPassword.isEmpty }
    var isNewPasswordEmpty: Bool { newPassword.isEmpty }
    var isNewPasswordTooShort: Bool { newPassword.count < 6 }
    var isConfirmPasswordMismatched: Bool { confirmPassword != newPassword }
}
