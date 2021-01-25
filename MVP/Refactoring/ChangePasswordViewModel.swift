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
    #if false
    var oldPassword: String {
        get { passwordInputs.oldPassword }
        set { passwordInputs.oldPassword = newValue }
    }
    #endif
    #if false
    var passwordInputs = PasswordInputs()
    #endif
    
    #if false
    typealias InputFocus = Refactoring.InputFocus
    #endif

    #if false
    var isOldPasswordEmpty: Bool { passwordInputs.oldPassword.isEmpty }
    #endif
    #if false
    var isOldPasswordEmpty: Bool { passwordInputs.isOldPasswordEmpty }
    #endif
}
