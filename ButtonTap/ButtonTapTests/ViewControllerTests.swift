@testable import ButtonTap
import XCTest

class ViewControllerTests: XCTestCase {

    func test_tappingButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(
                identifier: String(describing: ViewController.self))
        sut.loadViewIfNeeded()

        #if false
        sut.button.sendActions(for: .touchUpInside)
        #endif
        tap(sut.button)

        // Normally, assert something
    }
}
