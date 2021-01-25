@testable import TextField
import XCTest

final class ViewControllerTests: XCTestCase {
    private var sut: ViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(
                identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        executeRunLoop()
        sut = nil
        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(sut.usernameField, "usernameField")
        XCTAssertNotNil(sut.passwordField, "passwordField")
    }

    func test_usernameField_attributesShouldBeSet() {
        let textField = sut.usernameField!
        XCTAssertEqual(textField.textContentType, .username, "textContentType")
        XCTAssertEqual(textField.autocorrectionType, .no, "autocorrectionType")
        XCTAssertEqual(textField.returnKeyType, .next, "returnKeyType")
    }

    func test_passwordField_attributesShouldBeSet() {
        let textField = sut.passwordField!
        XCTAssertEqual(textField.textContentType, .password, "textContentType")
        XCTAssertEqual(textField.returnKeyType, .go, "returnKeyType")
        XCTAssertTrue(textField.isSecureTextEntry, "isSecureTextEntry")
    }

    func test_textFieldDelegates_shouldBeConnected() {
        XCTAssertNotNil(sut.usernameField.delegate, "usernameField")
        XCTAssertNotNil(sut.passwordField.delegate, "passwordField")
    }

    #if false
    func test_shouldChangeCharacters_usernameWithSpaces_shouldPreventChange() {
        let allowChange = sut.usernameField.delegate?.textField?(
                sut.usernameField,
                shouldChangeCharactersIn: NSRange(),
                replacementString: "a b")

        XCTAssertEqual(allowChange, false)
    }
    #endif

    func test_shouldChangeCharacters_usernameWithSpaces_shouldPreventChange() {
        let allowChange = shouldChangeCharacters(in: sut.usernameField,
                replacement: "a b")

        XCTAssertEqual(allowChange, false)
    }

    func test_shouldChangeCharacters_usernameWithoutSpaces_shouldAllowChange() {
        let allowChange = shouldChangeCharacters(in: sut.usernameField,
                replacement: "abc")

        XCTAssertEqual(allowChange, true)
    }

    func test_shouldChangeCharacters_passwordWithSpaces_shouldAllowChange() {
        let allowChange = shouldChangeCharacters(in: sut.passwordField,
                replacement: "a b")

        XCTAssertEqual(allowChange, true)
    }

    func test_shouldChangeCharacters_passwordWithoutSpaces_shouldAllowChange() {
        let allowChange = shouldChangeCharacters(in: sut.passwordField,
                replacement: "abc")

        XCTAssertEqual(allowChange, true)
    }

    #if false
    func test_shouldReturn_withUsername_shouldProcessReturnButton() {
        let allowReturn = sut.usernameField
                .delegate?.textFieldShouldReturn?(sut.usernameField)
        
        XCTAssertEqual(allowReturn, true)
    }
    #endif
    
    #if false
    func test_shouldReturn_withPassword_shouldPerformLogin() {
        sut.usernameField.text = "USERNAME"
        sut.passwordField.text = "PASSWORD"

        _ = sut.passwordField.delegate?.textFieldShouldReturn?(sut.passwordField)

        // Normally, assert something
    }
    #endif

    func test_shouldReturn_withPassword_shouldPerformLogin() {
        sut.usernameField.text = "USERNAME"
        sut.passwordField.text = "PASSWORD"

        shouldReturn(in: sut.passwordField)

        // Normally, assert something
    }
    
    func test_shouldReturn_withUsername_shouldMoveInputFocusToPassword() {
        putInViewHierarchy(sut)

        shouldReturn(in: sut.usernameField)

        XCTAssertTrue(sut.passwordField.isFirstResponder)
    }

    func test_shouldReturn_withPassword_shouldDismissKeyboard() {
        putInViewHierarchy(sut)
        sut.passwordField.becomeFirstResponder()
        XCTAssertTrue(sut.passwordField.isFirstResponder, "precondition")

        shouldReturn(in: sut.passwordField)

        XCTAssertFalse(sut.passwordField.isFirstResponder)
    }
}
