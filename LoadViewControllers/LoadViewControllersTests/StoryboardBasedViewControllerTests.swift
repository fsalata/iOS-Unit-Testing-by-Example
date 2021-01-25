@testable import LoadViewControllers
import XCTest

class StoryboardBasedViewControllerTests: XCTestCase {

    #if false
    func test_loading() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sut = sb.instantiateViewController(
              identifier: String(describing: StoryboardBasedViewController.self))
    }
    #endif

    func test_loading() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let sut: StoryboardBasedViewController = sb.instantiateViewController(
              identifier: String(describing: StoryboardBasedViewController.self))

        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.label)
    }
}
