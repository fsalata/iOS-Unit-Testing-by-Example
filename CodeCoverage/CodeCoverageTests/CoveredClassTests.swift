@testable import CodeCoverage
import XCTest

class CoveredClassTests: XCTestCase {

    #if false
    func test_zero() {
        XCTFail("Tests not yet implemented in CoveredClassTests")
    }
    #endif

    #if false
    func test_max_with1And2_shouldReturnSomething() {
        let result = CoveredClass.max(1, 2)

        XCTAssertEqual(result, -123)
    }
    #endif

    func test_max_with1And2_shouldReturn2() {
        let result = CoveredClass.max(1, 2)

        XCTAssertEqual(result, 2)
    }

    func test_max_with3And2_shouldReturn3() {
        let result = CoveredClass.max(3, 2)

        XCTAssertEqual(result, 3)
    }

    #if false
    func test_commaSeparated_from2to4_shouldReturnSomething() {
        let result = CoveredClass.commaSeparated(from: 2, to: 4)

        XCTAssertEqual(result, "FOO")
    }
    #endif

    func test_commaSeparated_from2to4_shouldReturn234SeparatedByCommas() {
        let result = CoveredClass.commaSeparated(from: 2, to: 4)

        XCTAssertEqual(result, "2,3,4")
    }

    #if false
    func test_commaSeparated_from2to2_shouldReturnSomething() {
        let result = CoveredClass.commaSeparated(from: 2, to: 2)

        XCTAssertEqual(result, "FOO")
    }
    #endif

    func test_commaSeparated_from2to2_shouldReturn2WithNoComma() {
        let result = CoveredClass.commaSeparated(from: 2, to: 2)

        XCTAssertEqual(result, "2")
    }

    #if false
    func test_area_withWidth7_shouldBeSomething() {
        let sut = CoveredClass()

        sut.width = 7

        XCTAssertEqual(sut.area, -1)
    }
    #endif

    #if true
    func test_area_withWidth7_shouldBe49() {
        let sut = CoveredClass()

        sut.width = 7

        XCTAssertEqual(sut.area, 49)
    }
    #endif

}
