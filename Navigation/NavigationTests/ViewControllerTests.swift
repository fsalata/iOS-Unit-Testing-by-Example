@testable import Navigation
import ViewControllerPresentationSpy
import XCTest

class ViewControllerTests: XCTestCase {
    private var sut: ViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        executeRunLoop()
        sut = nil
        super.tearDown()
    }

    func test_navigationController_shouldNotBeNil() {
        sut.loadViewIfNeeded()
        let navigation = UINavigationController(rootViewController: sut)

        XCTAssertNotNil(sut.navigationController)
    }

    func test_tappingCodePushButton_shouldPushCodeNextViewController() {
        #if false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(
                withIdentifier: "ViewController") as! ViewController
        sut.loadViewIfNeeded()
        #endif
        let navigation = UINavigationController(rootViewController: sut)

        tap(sut.codePushButton)

        executeRunLoop()
        XCTAssertEqual(navigation.viewControllers.count, 2, "navigation stack")
        #if false
        let pushedVC = navigation.viewControllers.last
        XCTAssertTrue(pushedVC is CodeNextViewController,
                "Expected CodeNextViewController, "
                + "but was \(String(describing: pushedVC))")
        #endif
        let pushedVC = navigation.viewControllers.last
        guard let codeNextVC = pushedVC as? CodeNextViewController else {
            XCTFail("Expected CodeNextViewController, "
                    + "but was \(String(describing: pushedVC))")
            return
        }
        XCTAssertEqual(codeNextVC.label.text, "Pushed from code")
    }


    func test_INCORRECT_tappingCodeModalButton_shouldPresentCodeNextViewController() {
        UIApplication.shared.windows.first?.rootViewController = sut

        tap(sut.codeModalButton)

        let presentedVC = sut.presentedViewController
        guard let codeNextVC = presentedVC as? CodeNextViewController else {
            XCTFail("Expected CodeNextViewController, "
                    + "but was \(String(describing: presentedVC))")
            return
        }
        XCTAssertEqual(codeNextVC.label.text, "Modal from code")
    }

    func test_tappingCodeModalButton_shouldPresentCodeNextViewController() {
        let presentationVerifier = PresentationVerifier()

        tap(sut.codeModalButton)

        let codeNextVC: CodeNextViewController? = presentationVerifier.verify(
                animated: true, presentingViewController: sut)
        XCTAssertEqual(codeNextVC?.label.text, "Modal from code")
    }

    func test_tappingSeguePushButton_shouldShowSegueNextViewController() {
        let presentationVerifier = PresentationVerifier()
        putInWindow(sut)

        tap(sut.seguePushButton)

        let segueNextVC: SegueNextViewController? = presentationVerifier.verify(
                animated: true, presentingViewController: sut)
        XCTAssertEqual(segueNextVC?.labelText, "Pushed from segue")
    }

    func test_tappingSegueModalButton_shouldShowSegueNextViewController() {
        let presentationVerifier = PresentationVerifier()

        tap(sut.segueModalButton)

        let segueNextVC: SegueNextViewController? = presentationVerifier.verify(
                animated: true, presentingViewController: sut)
        XCTAssertEqual(segueNextVC?.labelText, "Modal from segue")
    }
}

// We can't use this for a view controller that comes from a storyboard.
private class TestableViewController: ViewController {
    var presentCallCount = 0
    var presentArgsViewController: [UIViewController] = []
    var presentArgsAnimated: [Bool] = []
    var presentArgsClosure: [(() -> Void)?] = []
    
    override func present(_ viewControllerToPresent: UIViewController,
                          animated flag: Bool,
                          completion: (() -> Void)? = nil) {
        presentCallCount += 1
        presentArgsViewController.append(viewControllerToPresent)
        presentArgsAnimated.append(flag)
        presentArgsClosure.append(completion)
    }
}
