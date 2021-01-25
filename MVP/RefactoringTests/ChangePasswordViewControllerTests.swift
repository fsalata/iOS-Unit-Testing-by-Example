@testable import Refactoring
import ViewControllerPresentationSpy
import XCTest

final class ChangePasswordViewControllerTests: XCTestCase {
    private var sut: ChangePasswordViewController!
    private var passwordChanger: MockPasswordChanger!
    private var alertVerifier: AlertVerifier!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: ChangePasswordViewController.self))
        sut.viewModel = ChangePasswordViewModel(
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
        passwordChanger = MockPasswordChanger()
        sut.passwordChanger = passwordChanger
        alertVerifier = AlertVerifier()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        executeRunLoop() // Clean out UIWindow
        sut = nil
        passwordChanger = nil
        alertVerifier = nil
        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.navigationBar, "navigationBar")
        XCTAssertNotNil(sut.cancelBarButton, "cancelButton")
        XCTAssertNotNil(sut.oldPasswordTextField, "oldPasswordTextField")
        XCTAssertNotNil(sut.newPasswordTextField, "newPasswordTextField")
        XCTAssertNotNil(sut.confirmPasswordTextField,
                "confirmPasswordTextField")
        XCTAssertNotNil(sut.submitButton, "submitButton")
    }

    func test_navigationBar_shouldHaveTitle() {
        XCTAssertEqual(sut.navigationBar.topItem?.title, "Change Password")
    }
    
    func test_cancelBarButton_shouldBeSystemItemCancel() {
        XCTAssertEqual(systemItem(for: sut.cancelBarButton), .cancel)
    }
    
    func test_oldPasswordTextField_shouldHavePlaceholder() {
        XCTAssertEqual(sut.oldPasswordTextField.placeholder, "Current Password")
    }

    func test_newPasswordTextField_shouldHavePlaceholder() {
        XCTAssertEqual(sut.newPasswordTextField.placeholder, "New Password")
    }

    func test_confirmPasswordTextField_shouldHavePlaceholder() {
        XCTAssertEqual(sut.confirmPasswordTextField.placeholder,
                "Confirm New Password")
    }

    func test_submitButton_shouldHaveTitle() {
        XCTAssertEqual(sut.submitButton.titleLabel?.text, "Submit")
    }

    func test_oldPasswordTextField_shouldHavePasswordAttributes() {
        let textField = sut.oldPasswordTextField!
        XCTAssertEqual(textField.textContentType, .password, "textContentType")
        XCTAssertTrue(textField.isSecureTextEntry, "isSecureTextEntry")
        XCTAssertTrue(textField.enablesReturnKeyAutomatically,
                "enablesReturnKeyAutomatically")
    }

    func test_newPasswordTextField_shouldHavePasswordAttributes() {
        let textField = sut.newPasswordTextField!
        XCTAssertEqual(textField.textContentType, .newPassword, "textContentType")
        XCTAssertTrue(textField.isSecureTextEntry, "isSecureTextEntry")
        XCTAssertTrue(textField.enablesReturnKeyAutomatically, "enablesReturnKeyAutomatically")
    }
    
    func test_confirmPasswordTextField_shouldHavePasswordAttributes() {
        let textField = sut.confirmPasswordTextField!
        XCTAssertEqual(textField.textContentType, .newPassword, "textContentType")
        XCTAssertTrue(textField.isSecureTextEntry, "isSecureTextEntry")
        XCTAssertTrue(textField.enablesReturnKeyAutomatically, "enablesReturnKeyAutomatically")
    }

    func test_tappingCancel_withFocusOnOldPassword_shouldResignThatFocus() {
        putFocusOn(.oldPassword)
        XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder, "precondition")

        tap(sut.cancelBarButton)

        XCTAssertFalse(sut.oldPasswordTextField.isFirstResponder)
    }

    func test_tappingCancel_withFocusOnNewPassword_shouldResignThatFocus() {
        putFocusOn(.newPassword)
        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder, "precondition")

        tap(sut.cancelBarButton)

        XCTAssertFalse(sut.newPasswordTextField.isFirstResponder)
    }

    func test_tappingCancel_withFocusOnConfirmPassword_shouldResignThatFocus() {
        putFocusOn(.confirmPassword)
        XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder, "precondition")

        tap(sut.cancelBarButton)

        XCTAssertFalse(sut.confirmPasswordTextField.isFirstResponder)
    }

    func test_tappingCancel_shouldDismissModal() {
        let dismissalVerifier = DismissalVerifier()

        tap(sut.cancelBarButton)
        
        dismissalVerifier.verify(animated: true, dismissedViewController: sut)
    }

    func test_tappingSubmit_withOldPasswordEmpty_shouldNotChangePassword() {
        setUpValidPasswordEntries()
        sut.oldPasswordTextField.text = ""

        tap(sut.submitButton)

        passwordChanger.verifyChangeNeverCalled()
    }

    func test_tappingSubmit_withOldPasswordEmpty_shouldPutFocusOnOldPassword() {
        setUpValidPasswordEntries()
        sut.oldPasswordTextField.text = ""
        putInViewHierarchy(sut)

        tap(sut.submitButton)

        XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder)
    }

    func test_tappingSubmit_withNewPasswordEmpty_shouldNotChangePassword() {
        setUpValidPasswordEntries()
        sut.newPasswordTextField.text = ""

        tap(sut.submitButton)

        passwordChanger.verifyChangeNeverCalled()
    }

    func test_tappingSubmit_withNewPasswordEmpty_shouldShowPasswordBlankAlert() {
        setUpValidPasswordEntries()
        sut.newPasswordTextField.text = ""

        tap(sut.submitButton)

        verifyAlertPresented(message: "Please enter a new password.")
    }
    
    func test_tappingOKInPasswordBlankAlert_shouldPutFocusOnNewPassword() throws {
        setUpValidPasswordEntries()
        sut.newPasswordTextField.text = ""
        tap(sut.submitButton)
        putInViewHierarchy(sut)

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
    }

    func test_tappingSubmit_withNewPasswordTooShort_shouldNotChangePassword() {
        setUpEntriesNewPasswordTooShort()

        tap(sut.submitButton)

        passwordChanger.verifyChangeNeverCalled()
    }

    func test_tappingSubmit_withNewPasswordTooShort_shouldShowTooShortAlert() {
        setUpEntriesNewPasswordTooShort()

        tap(sut.submitButton)

        verifyAlertPresented(
                message: "The new password should have at least 6 characters.")
    }

    func test_tappingOKInTooShortAlert_shouldClearNewAndConfirmation() throws {
        setUpEntriesNewPasswordTooShort()
        tap(sut.submitButton)

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertEqual(sut.newPasswordTextField.text?.isEmpty, true, "new")
        XCTAssertEqual(sut.confirmPasswordTextField.text?.isEmpty, true,
                "confirmation")
    }

    func test_tappingOKInTooShortAlert_shouldNotClearOldPasswordField() throws {
        setUpEntriesNewPasswordTooShort()
        tap(sut.submitButton)

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertEqual(sut.oldPasswordTextField.text?.isEmpty, false)
    }

    func test_tappingOKInTooShortAlert_shouldPutFocusOnNewPassword() throws {
        setUpEntriesNewPasswordTooShort()
        tap(sut.submitButton)
        putInViewHierarchy(sut)

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
    }

    func test_tappingSubmit_withConfirmationMismatch_shouldNotChangePassword() {
        setUpMismatchedConfirmationEntry()

        tap(sut.submitButton)

        passwordChanger.verifyChangeNeverCalled()
    }

    func test_tappingSubmit_withConfirmationMismatch_shouldShowMismatchAlert() {
        setUpMismatchedConfirmationEntry()

        tap(sut.submitButton)

        verifyAlertPresented(
                message: "The new password and the confirmation password " +
                         "don’t match. Please try again.")
    }

    func test_tappingOKInMismatchAlert_shouldClearNewAndConfirmationFields() throws {
        setUpMismatchedConfirmationEntry()
        tap(sut.submitButton)

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertEqual(sut.newPasswordTextField.text?.isEmpty, true, "new")
        XCTAssertEqual(sut.confirmPasswordTextField.text?.isEmpty, true, "confirmation")
    }

    func test_tappingOKInPasswordsMismatchAlert_shouldNotClearOldPassword() throws {
        setUpMismatchedConfirmationEntry()
        tap(sut.submitButton)

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertEqual(sut.oldPasswordTextField.text?.isEmpty, false)
    }

    func test_tappingOKInPasswordsMismatchAlert_shouldPutFocusOnNewPassword() throws {
        setUpMismatchedConfirmationEntry()
        tap(sut.submitButton)
        putInViewHierarchy(sut)

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
    }

    func test_tappingSubmit_withValidFieldsFocusedOnOldPassword_shouldResignFocus() {
        setUpValidPasswordEntries()
        putFocusOn(.oldPassword)
        XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder, "precondition")

        tap(sut.submitButton)

        XCTAssertFalse(sut.oldPasswordTextField.isFirstResponder)
    }

    func test_tappingSubmit_withValidFieldsAndFocusOnNewPassword_shouldResignThatFocus() {
        setUpValidPasswordEntries()
        putFocusOn(.newPassword)
        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder, "precondition")

        tap(sut.submitButton)

        XCTAssertFalse(sut.newPasswordTextField.isFirstResponder)
    }

    func test_tappingSubmit_withValidFieldsAndFocusOnConfirmPassword_shouldResignThatFocus() {
        setUpValidPasswordEntries()
        putFocusOn(.confirmPassword)
        XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder, "precondition")

        tap(sut.submitButton)

        XCTAssertFalse(sut.confirmPasswordTextField.isFirstResponder)
    }

    func test_tappingSubmit_withValidFields_shouldDisableCancelBarButton() {
        setUpValidPasswordEntries()
        XCTAssertTrue(sut.cancelBarButton.isEnabled, "precondition")

        tap(sut.submitButton)

        XCTAssertFalse(sut.cancelBarButton.isEnabled)
    }

    func test_tappingSubmit_withValidFields_shouldShowBlurView() {
        setUpValidPasswordEntries()
        XCTAssertNil(sut.blurView.superview, "precondition")

        tap(sut.submitButton)
        
        XCTAssertNotNil(sut.blurView.superview)
    }

    func test_tappingSubmit_withValidFields_shouldShowActivityIndicator() {
        setUpValidPasswordEntries()
        XCTAssertNil(sut.activityIndicator.superview, "precondition")

        tap(sut.submitButton)
        
        XCTAssertNotNil(sut.activityIndicator.superview)
    }

    func test_tappingSubmit_withValidFields_shouldStartActivityAnimation() {
        setUpValidPasswordEntries()
        XCTAssertFalse(sut.activityIndicator.isAnimating, "precondition")

        tap(sut.submitButton)

        XCTAssertTrue(sut.activityIndicator.isAnimating)
    }

    func test_tappingSubmit_withValidFields_shouldClearBackgroundColorForBlur() {
        setUpValidPasswordEntries()
        XCTAssertNotEqual(sut.view.backgroundColor, .clear, "precondition")

        tap(sut.submitButton)

        XCTAssertEqual(sut.view.backgroundColor, .clear)
    }

    func test_tappingSubmit_withValidFields_shouldRequestChangePassword() {
        sut.securityToken = "TOKEN"
        sut.oldPasswordTextField.text = "OLD456"
        sut.newPasswordTextField.text = "NEW456"
        sut.confirmPasswordTextField.text = sut.newPasswordTextField.text

        tap(sut.submitButton)
        
        passwordChanger.verifyChange(
                securityToken: "TOKEN",
                oldPassword: "OLD456",
                newPassword: "NEW456"
        )
    }

    func test_changePasswordSuccess_shouldStopActivityIndicatorAnimation() {
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        XCTAssertTrue(sut.activityIndicator.isAnimating, "precondition")
        
        passwordChanger.changeCallSuccess()

        XCTAssertFalse(sut.activityIndicator.isAnimating)
    }

    func test_changePasswordSuccess_shouldHideActivityIndicator() {
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        XCTAssertNotNil(sut.activityIndicator.superview, "precondition")
        
        passwordChanger.changeCallSuccess()

        XCTAssertNil(sut.activityIndicator.superview)
    }

    func test_changePasswordFailure_shouldHideActivityIndicator() {
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        XCTAssertNotNil(sut.activityIndicator.superview, "precondition")

        passwordChanger.changeCallFailure(message: "DUMMY")

        XCTAssertNil(sut.activityIndicator.superview)
    }

    func test_changePasswordFailure_shouldStopActivityIndicatorAnimation() {
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        XCTAssertTrue(sut.activityIndicator.isAnimating, "precondition")

        passwordChanger.changeCallFailure(message: "DUMMY")

        XCTAssertFalse(sut.activityIndicator.isAnimating)
    }
    
    func test_changePasswordSuccess_shouldShowSuccessAlert() {
        setUpValidPasswordEntries()
        tap(sut.submitButton)

        passwordChanger.changeCallSuccess()

        verifyAlertPresented(
                message: "Your password has been successfully changed.")
    }

    func test_tappingOKInSuccessAlert_shouldDismissModal() throws {
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        passwordChanger.changeCallSuccess()
        let dismissalVerifier = DismissalVerifier()

        try alertVerifier.executeAction(forButton: "OK")
        
        dismissalVerifier.verify(animated: true, dismissedViewController: sut)
    }

    func test_changePasswordFailure_shouldShowFailureAlertWithGivenMessage() {
        setUpValidPasswordEntries()
        tap(sut.submitButton)

        passwordChanger.changeCallFailure(message: "MESSAGE")

        verifyAlertPresented(message: "MESSAGE")
    }

    private func showPasswordChangeFailureAlert() {
        setUpValidPasswordEntries()
        tap(sut.submitButton)
        passwordChanger.changeCallFailure(message: "DUMMY")
    }

    func test_tappingOKInFailureAlert_shouldClearAllFieldsToStartOver() throws {
        showPasswordChangeFailureAlert()

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertEqual(sut.oldPasswordTextField.text?.isEmpty, true, "old")
        XCTAssertEqual(sut.newPasswordTextField.text?.isEmpty, true, "new")
        XCTAssertEqual(sut.confirmPasswordTextField.text?.isEmpty, true,
                "confirmation")
    }

    func test_tappingOKInFailureAlert_shouldPutFocusOnOldPassword() throws {
        showPasswordChangeFailureAlert()
        putInViewHierarchy(sut)

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertTrue(sut.oldPasswordTextField.isFirstResponder)
    }

    func test_tappingOKInFailureAlert_shouldSetBackgroundBackToWhite() throws {
        showPasswordChangeFailureAlert()
        XCTAssertNotEqual(sut.view.backgroundColor, .white, "precondition")

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertEqual(sut.view.backgroundColor, .white)
    }

    func test_tappingOKInFailureAlert_shouldHideBlur() throws {
        showPasswordChangeFailureAlert()
        XCTAssertNotNil(sut.blurView.superview, "precondition")

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertNil(sut.blurView.superview)
    }
    
    func test_tappingOKInFailureAlert_shouldEnableCancelBarButton() throws {
        showPasswordChangeFailureAlert()
        XCTAssertFalse(sut.cancelBarButton.isEnabled, "precondition")

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertTrue(sut.cancelBarButton.isEnabled)
    }

    func test_tappingOKInFailureAlert_shouldNotDismissModal() throws {
        showPasswordChangeFailureAlert()
        let dismissalVerifier = DismissalVerifier()

        try alertVerifier.executeAction(forButton: "OK")

        XCTAssertEqual(dismissalVerifier.dismissedCount, 0)
    }

    func test_textFieldDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.oldPasswordTextField.delegate,
                "oldPasswordTextField")
        XCTAssertNotNil(sut.newPasswordTextField.delegate,
                "updatedPasswordTextField")
        XCTAssertNotNil(sut.confirmPasswordTextField.delegate,
                "confirmPasswordTextField")
    }
    
    func test_hittingReturnFromOldPassword_shouldPutFocusOnNewPassword() {
        putInViewHierarchy(sut)

        shouldReturn(in: sut.oldPasswordTextField)

        XCTAssertTrue(sut.newPasswordTextField.isFirstResponder)
    }

    func test_hittingReturnFromNewPassword_shouldPutFocusOnConfirmPassword() {
        putInViewHierarchy(sut)

        shouldReturn(in: sut.newPasswordTextField)

        XCTAssertTrue(sut.confirmPasswordTextField.isFirstResponder)
    }

    func test_hittingReturnFromConfirmPassword_shouldRequestPasswordChange() {
        sut.securityToken = "TOKEN"
        sut.oldPasswordTextField.text = "OLD456"
        sut.newPasswordTextField.text = "NEW456"
        sut.confirmPasswordTextField.text = sut.newPasswordTextField.text

        shouldReturn(in: sut.confirmPasswordTextField)

        passwordChanger.verifyChange(
                securityToken: "TOKEN",
                oldPassword: "OLD456",
                newPassword: "NEW456")
    }

    func test_hittingReturnFromOldPassword_shouldNotRequestPasswordChange() {
        setUpValidPasswordEntries()

        shouldReturn(in: sut.oldPasswordTextField)

        passwordChanger.verifyChangeNeverCalled()
    }
    
    func test_hittingReturnFromNewPassword_shouldNotRequestPasswordChange() {
        setUpValidPasswordEntries()

        shouldReturn(in: sut.newPasswordTextField)

        passwordChanger.verifyChangeNeverCalled()
    }

    private func setUpValidPasswordEntries() {
        sut.oldPasswordTextField.text = "NONEMPTY"
        sut.newPasswordTextField.text = "123456"
        sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
    }

    private func setUpEntriesNewPasswordTooShort() {
        sut.oldPasswordTextField.text = "NONEMPTY"
        sut.newPasswordTextField.text = "12345"
        sut.confirmPasswordTextField.text = sut.newPasswordTextField.text
    }

    private func setUpMismatchedConfirmationEntry() {
        sut.oldPasswordTextField.text = "NONEMPTY"
        sut.newPasswordTextField.text = "123456"
        sut.confirmPasswordTextField.text = "abcdef"
    }
    
    #if false
    private func putFocusOn(_ inputFocus: ChangePasswordViewModel.InputFocus) {
        putInViewHierarchy(sut)
        sut.viewModel.inputFocus = inputFocus
        sut.updateInputFocus(inputFocus)
    }
    #endif

    private func putFocusOn(_ inputFocus: InputFocus) {
        putInViewHierarchy(sut)
        sut.updateInputFocus(inputFocus)
    }

    private func verifyAlertPresented(
            message: String, file: StaticString = #file, line: UInt = #line) {
        alertVerifier.verify(
                title: nil,
                message: message,
                animated: true,
                actions: [
                    .default("OK"),
                ],
                presentingViewController: sut,
                file: file,
                line: line
        )
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK",
                "preferred action", file: file, line: line)
    }
}
