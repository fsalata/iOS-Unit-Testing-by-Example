@testable import Alert
import ViewControllerPresentationSpy
import XCTest

class ViewControllerTests: XCTestCase {
    private var alertVerifier: AlertVerifier!
    private var sut: ViewController!

    override func setUp() {
        super.setUp()
        alertVerifier = AlertVerifier()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(
                identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        alertVerifier = nil
        sut = nil
        super.tearDown()
    }
    
    func test_tappingButton_shouldShowAlert() {
        tap(sut.button)

        alertVerifier.verify(
                title: "Do the Thing?",
                message: "Let us know if you want to do the thing.",
                animated: true,
                actions: [
                    .cancel("Cancel"),
                    .default("OK"),
                ],
                presentingViewController: sut
        )
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK",
                "preferred action")
    }
    
    func test_executeAlertAction_withOKButton() throws {
        tap(sut.button)

        try alertVerifier.executeAction(forButton: "OK")

        // Normally, assert something
    }

    func test_executeAlertAction_withCancelButton() throws {
        tap(sut.button)

        try alertVerifier.executeAction(forButton: "Cancel")

        // Normally, assert something
    }
}
