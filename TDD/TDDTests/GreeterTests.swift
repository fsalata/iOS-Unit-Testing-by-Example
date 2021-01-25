@testable import TDD
import XCTest

final class GreeterWithoutNameTests: XCTestCase {
    private var sut: Greeter!

    override func setUp() {
        super.setUp()
        sut = Greeter(name: "")
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    #if false
    func test_greet_with1159am_shouldSayGoodMorning() {
        #if false
        Greeter(name: "")
        #endif

        let sut = Greeter(name: "")
        let components = DateComponents(
                calendar: Calendar.current, hour: 11, minute: 59)
        let time = components.date!

        let result: String = sut.greet(time: time)

        XCTAssertEqual(result, "Good morning.")
    }
    #endif

    func test_greet_with1159am_shouldSayGoodMorning() {
        #if false
        let sut = Greeter(name: "")
        #endif

        #if false
        let result: String = sut.greet(time: date(hour: 11, minute: 59))
        #endif
        let result = sut.greet(time: date(hour: 11, minute: 59))

        XCTAssertEqual(result, "Good morning.")
    }

    func test_greet_with1200pm_shouldSayGoodAfternoon() {
        #if false
        let sut = Greeter(name: "")
        #endif

        let result = sut.greet(time: date(hour: 12, minute: 00))

        XCTAssertEqual(result, "Good afternoon.")
    }

    func test_greet_with200pm_shouldSayGoodAfternoon() {
        let result = sut.greet(time: date(hour: 14, minute: 00))

        XCTAssertEqual(result, "Good afternoon.")
    }

    func test_greet_with459pm_shouldSayGoodAfternoon() {
        let result = sut.greet(time: date(hour: 16, minute: 59))

        XCTAssertEqual(result, "Good afternoon.")
    }

    func test_greet_with500pm_shouldSayGoodEvening() {
        let result = sut.greet(time: date(hour: 17, minute: 00))

        XCTAssertEqual(result, "Good evening.")
    }

    func test_greet_with1159pm_shouldSayGoodEvening() {
        let result = sut.greet(time: date(hour: 23, minute: 59))

        XCTAssertEqual(result, "Good evening.")
    }

    func test_greet_with800pm_shouldSayGoodEvening() {
        let result = sut.greet(time: date(hour: 20, minute: 00))

        XCTAssertEqual(result, "Good evening.")
    }

    func test_greet_with1200am_shouldSayGoodEvening() {
        let result = sut.greet(time: date(hour: 0, minute: 00))

        XCTAssertEqual(result, "Good evening.")
    }

    func test_greet_with459am_shouldSayGoodEvening() {
        let result = sut.greet(time: date(hour: 4, minute: 59))

        XCTAssertEqual(result, "Good evening.")
    }

    func test_greet_with200am_shouldSayGoodEvening() {
        let result = sut.greet(time: date(hour: 2, minute: 00))

        XCTAssertEqual(result, "Good evening.")
    }

    #if false
    private func date(hour: Int, minute: Int) -> Date {
        let components = DateComponents(
                calendar: Calendar.current, hour: hour, minute: minute)
        return components.date!
    }
    #endif
}

final class GreeterWithNameTests: XCTestCase {
    
    func test_greetMorning_withAlberto_shouldSayGoodMorningAlberto() {
        let sut = Greeter(name: "Alberto")

        let result = sut.greet(time: date(hour: 5, minute: 0))

        XCTAssertEqual(result, "Good morning, Alberto.")
    }
    
    func test_greetAfternoon_withBeryl_shouldSayGoodAfternoonBeryl() {
        let sut = Greeter(name: "Beryl")

        let result = sut.greet(time: date(hour: 15, minute: 0))

        XCTAssertEqual(result, "Good afternoon, Beryl.")
    }
}

private func date(hour: Int, minute: Int) -> Date {
    let components = DateComponents(
            calendar: Calendar.current, hour: hour, minute: minute)
    return components.date!
}
