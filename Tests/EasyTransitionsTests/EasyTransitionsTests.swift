import XCTest
@testable import EasyTransitions

final class EasyTransitionsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(EasyTransitions().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
