@testable import LoadViewControllers
import XCTest

class XIBBasedViewControllerTests: XCTestCase {

    #if false
    func test_loading() {
        let sut = XIBBasedViewController()

        XCTAssertNotNil(sut.label)
    }
    #endif

    func test_loading() {
        let sut = XIBBasedViewController()

        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.label)
    }
}
