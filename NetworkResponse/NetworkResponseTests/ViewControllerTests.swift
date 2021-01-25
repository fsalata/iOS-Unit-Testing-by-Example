@testable import NetworkResponse
import ViewControllerPresentationSpy
import XCTest

final class ViewControllerTests: XCTestCase {
    private var alertVerifier: AlertVerifier!
    private var sut: ViewController!
    private var spyURLSession: SpyURLSession!

    override func setUp() {
        super.setUp()
        alertVerifier = AlertVerifier()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(
                identifier: String(describing: ViewController.self))
        spyURLSession = SpyURLSession()
        sut.session = spyURLSession
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        alertVerifier = nil
        sut = nil
        spyURLSession = nil
        super.tearDown()
    }

    private func jsonData() -> Data {
        """
        {
            "results": [
                {
                    "artistName": "Artist",
                    "trackName": "Track",
                    "averageUserRating": 2.5,
                    "genres": [
                        "Foo",
                        "Bar"
                    ]
                }
            ]
        }
        """.data(using: .utf8)!
    }

    func test_searchForBookNetworkCall_withSuccessResponse_shouldSaveDataInResults() {
    #if false
        let spyURLSession = SpyURLSession()
        sut.session = spyURLSession
        sut.loadViewIfNeeded()
    #endif
        tap(sut.button)
        let handleResultsCalled = expectation(description: "handleResults called")
        sut.handleResults = { _ in
            handleResultsCalled.fulfill()
        }

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                jsonData(), response(statusCode: 200), nil
        )

        waitForExpectations(timeout: 0.01)
        XCTAssertEqual(sut.results, [
            SearchResult(artistName: "Artist", trackName: "Track",
                    averageUserRating: 2.5, genres: ["Foo", "Bar"])
        ])
    }

    func test_searchForBookNetworkCall_withSuccessBeforeAsync_shouldNotSaveDataInResults() {
        tap(sut.button)

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                jsonData(), response(statusCode: 200), nil
        )

        XCTAssertEqual(sut.results, [])
    }
    
    func test_searchForBookNetworkCall_withError_shouldShowAlert() {
        tap(sut.button)
        let alertShown = expectation(description: "alert shown")
        alertVerifier.testCompletion = {
            alertShown.fulfill()
        }

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                nil, nil, TestError(message: "oh no")
        )

        waitForExpectations(timeout: 0.01)
        verifyErrorAlert(message: "oh no")
    }

    func test_searchForBookNetworkCall_withErrorPreAsync_shouldNotShowAlert() {
        tap(sut.button)

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                nil, nil, TestError(message: "DUMMY")
        )

        XCTAssertEqual(alertVerifier.presentedCount, 0)
    }

    private func badDataMissingGenres() -> Data {
        """
        {
            "results": [
                {
                    "artistName": "Artist",
                    "trackName": "Track",
                    "averageUserRating": 2.5
                }
            ]
        }
        """.data(using: .utf8)!
    }

    func test_searchForBookNetworkCall_withBadData_shouldShowAlert() {
        tap(sut.button)
        let alertShown = expectation(description: "alert shown")
        alertVerifier.testCompletion = {
            alertShown.fulfill()
        }

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                badDataMissingGenres(), response(statusCode: 200), nil
        )

        waitForExpectations(timeout: 0.01)
        verifyErrorAlert(message: "The data couldn’t be read because it is missing.")
    }

    func test_searchForBookNetworkCall_withBadDataBeforeAsync_shouldNotShowAlert() {
        tap(sut.button)

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                badDataMissingGenres(), response(statusCode: 200), nil
        )

        XCTAssertEqual(alertVerifier.presentedCount, 0)
    }

    func test_searchForBookNetworkCall_withNon200StatusCode_shouldShowAlert() {
        tap(sut.button)
        let alertShown = expectation(description: "alert shown")
        alertVerifier.testCompletion = {
            alertShown.fulfill()
        }

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                jsonData(), response(statusCode: 500), nil
        )

        waitForExpectations(timeout: 0.01)
        verifyErrorAlert(message: "Response: internal server error")
    }

    func test_searchForBookNetworkCall_withNon200StatusCodeBeforeAsync_shouldNotShowAlert() {
        tap(sut.button)

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                jsonData(), response(statusCode: 500), nil
        )

        XCTAssertEqual(alertVerifier.presentedCount, 0)
    }

    func test_buttonShouldBeInitiallyEnabled() {
        XCTAssertTrue(sut.button.isEnabled)
    }

    func test_searchForBookNetworkCall_shouldDisableButton() {
        tap(sut.button)
        
        XCTAssertFalse(sut.button.isEnabled)
    }
    
    func test_searchForBookNetworkCall_withSuccessResponse_shouldReenableButton() {
        tap(sut.button)
        let handleResultsCalled = expectation(description: "handleResults called")
        sut.handleResults = { _ in
            handleResultsCalled.fulfill()
        }

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                jsonData(), response(statusCode: 200), nil
        )

        waitForExpectations(timeout: 0.01)
        XCTAssertTrue(sut.button.isEnabled)
    }

    func test_searchForBookNetworkCall_withSuccessResponseBeforeAsync_shouldNotReenableButtonYet() {
        tap(sut.button)

        spyURLSession.dataTaskArgsCompletionHandler.first?(
                jsonData(), response(statusCode: 200), nil
        )

        XCTAssertFalse(sut.button.isEnabled)
    }
    
    private func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "http://DUMMY")!,
                statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
    
    private func verifyErrorAlert(
            message: String, file: StaticString = #file, line: UInt = #line) {
        alertVerifier.verify(
                title: "Network problem",
                message: message,
                animated: true,
                actions: [
                    .default("OK"),
                ],
                presentingViewController: sut,
                file: file,
                line: line
        )
        XCTAssertEqual(alertVerifier.preferredAction?.title, "OK",
                "preferred action", file: file, line: line)
    }
}
