@testable import LoadViewControllers
import XCTest

class CodeBasedViewControllerTests: XCTestCase {

    func test_loading() {
        let sut = CodeBasedViewController(data: "DUMMY")

        sut.loadViewIfNeeded()


        // Normally, assert something
    }
}
