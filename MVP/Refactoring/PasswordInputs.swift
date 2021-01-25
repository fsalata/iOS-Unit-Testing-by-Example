struct PasswordInputs {
    #if false
    var oldPassword = ""
    var newPassword = ""
    var confirmPassword = ""
    #endif

    let oldPassword: String
    let newPassword: String
    let confirmPassword: String

    var isOldPasswordEmpty: Bool { oldPassword.isEmpty }
    var isNewPasswordEmpty: Bool { newPassword.isEmpty }
    var isNewPasswordTooShort: Bool { newPassword.count < 6 }
    var isConfirmPasswordMismatched: Bool { confirmPassword != newPassword }

}
