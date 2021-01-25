@testable import Refactoring
import FBSnapshotTestCase
import ViewControllerPresentationSpy

final class ChangePasswordViewControllerSnapshotTests: FBSnapshotTestCase {
    private var sut: ChangePasswordViewController!
    private var passwordChanger: MockPasswordChanger!
    private var alertVerifier: AlertVerifier!

    override func setUp() {
        super.setUp()
        recordMode = false
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
    
    func test_blur() {
        setUpValidPasswordEntries()

        tap(sut.submitButton)

        verifySnapshot()
    }
    
    private func setUpValidPasswordEntries() {
        sut.oldPasswordTextField?.text = "NONEMPTY"
        sut.newPasswordTextField?.text = "123456"
        sut.confirmPasswordTextField?.text = sut.newPasswordTextField?.text
    }
    
    private func verifySnapshot(file: StaticString = #file, line: UInt = #line) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.addSubview(sut.view)
        FBSnapshotVerifyViewController(sut, file: file, line: line)
    }
}
