import XCTVapor
@testable import App

final class GreetingTests: AppTesting {

    func testShouldHandleRootRequests() throws {
        let app = try prepareApp()
        defer { app.shutdown() }
        try configureApp(
                app,
                GreetingController(logger: app.logger),
                ArithmeticController(logger: app.logger)
        )
        try app.test(HTTPMethod.GET, getPath(""), afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "hello friend, what is your ?name")
        })
    }

    override internal func getPath(_ path: String) -> String {
        "\(super.getPath(""))/greeting\(path)"
    }

    static let allTests = [
        ("testShouldHandleRootRequests", testShouldHandleRootRequests)
    ]
}

