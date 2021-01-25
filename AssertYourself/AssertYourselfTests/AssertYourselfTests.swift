import XCTest
@testable import AssertYourself

class AssertYourselfTests: XCTestCase {
    func test_fail() {
        XCTFail()
    }

    func test_fail_withSimpleMessage() {
        XCTFail("We have a problem")
    }

    func test_fail_withInterpolatedMessage() {
        let theAnswer = 42
        XCTFail("The Answer to the Great Question is \(theAnswer)")
    }

    func test_avoidConditionalCode() {
        let success = false
        if !success {
            XCTFail()
        }
    }

    func test_assertTrue() {
        let success = false
        XCTAssertTrue(success)
    }

    func test_assertFalse() {
        let success = true
        XCTAssertFalse(success)
    }

    func test_assertNotNil() {
        let optionalValue: Int? = nil
        XCTAssertNotNil(optionalValue)
    }

    func test_assertNil() {
        let optionalValue: Int? = 123
        XCTAssertNil(optionalValue)
    }

    struct SimpleStruct {
        let x: Int
        let y: Int
    }

    func test_assertNil_withSimpleStruct() {
        let optionalValue: SimpleStruct? = SimpleStruct(x: 1, y: 2)
        XCTAssertNil(optionalValue)
    }

    struct StructWithDescription: CustomStringConvertible {
        let x: Int
        let y: Int

        var description: String { "(\(x), \(y))" }
    }

    func test_assertNil_withSelfDescribingType() {
        let optionalValue: StructWithDescription? =
                StructWithDescription(x: 1, y: 2)
        XCTAssertNil(optionalValue)
    }

    func test_assertEqual() {
        let actual = "actual"
        XCTAssertEqual(actual, "expected")
    }

    func test_assertEqual_withOptional() {
        let result: String? = "foo"
        XCTAssertEqual(result, "bar")
    }

    func test_messageOverkill() {
        let actual = "actual"
        XCTAssertEqual(actual, "expected",
                       "Expected \"expected\" but got \"\(actual)\"")
    }

    func test_floatingPointDanger() {
        let result = 0.1 + 0.2
        XCTAssertEqual(result, 0.3)
    }

    func test_floatingPointFixed() {
        let result = 0.1 + 0.2
        XCTAssertEqual(result, 0.3, accuracy: 0.0001)
    }
}
