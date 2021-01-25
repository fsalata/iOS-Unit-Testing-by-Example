@testable import HardDependencies
import XCTest

class ClosurePropertyViewControllerTests: XCTestCase {

    func test_viewDidAppear() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ClosurePropertyViewController =
                storyboard.instantiateViewController(identifier:
                    String(describing: ClosurePropertyViewController.self))
        sut.loadViewIfNeeded()

        sut.makeAnalytics = { Analytics() }
        sut.loadViewIfNeeded()

        sut.viewDidAppear(false)

        // Normally, assert something
    }
}
