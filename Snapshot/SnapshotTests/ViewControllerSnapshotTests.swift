@testable import Snapshot
import FBSnapshotTestCase

class ViewControllerSnapshotTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        recordMode = false
    }

    func test_example() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ViewController = storyboard.instantiateViewController(
                identifier: String(describing: ViewController.self))

        FBSnapshotVerifyViewController(sut)
    }
}

