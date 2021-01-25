@testable import LifeCycle
import XCTest

#if false
class MyClassTests: XCTestCase {

    func test_methodOne() {
        let sut = MyClass()

        sut.methodOne()

        // Normally, assert something
    }

    func test_methodTwo() {
        let sut = MyClass()

        sut.methodTwo()

        // Normally, assert something
    }

}
#endif

#if false
class MyClassTests: XCTestCase {
    private let sut = MyClass()

    func test_methodOne() {
        sut.methodOne()

        // Normally, assert something
    }

    func test_methodTwo() {
        sut.methodTwo()

        // Normally, assert something
    }
}
#endif

#if true
class MyClassTests: XCTestCase {
    private var sut: MyClass!

    override func setUp() {
        super.setUp()
        sut = MyClass()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_methodOne() {
        sut.methodOne()

        // Normally, assert something
    }

    func test_methodTwo() {
        sut.methodTwo()

        // Normally, assert something
    }
}
#endif

class TestZeroDemoTests: XCTestCase {
    #if false
    func test_zero() {
        XCTFail("Tests not yet implemented in MyClassTests")
    }
    #endif
}
