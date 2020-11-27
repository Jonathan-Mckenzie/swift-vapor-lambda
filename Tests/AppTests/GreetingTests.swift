import XCTVapor
import NIOHTTP1
@testable import App

final class GreetingTests: AppTesting {

    func testShouldHandleRootRequests() throws {
        let app = try prepareApp()
        defer { app.shutdown() }

        try app.test(HTTPMethod.GET, getPath(""), afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "hello friend, what is your ?name")
        })
    }

    func testShouldHandleQueryParams() throws {
        let app = try prepareApp()
        defer { app.shutdown() }

        let name = "jon"
        try app.test(HTTPMethod.GET, getPath("") + "?name=\(name)", afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "hello \(name)! Try: '/greeting/acceptable'")
        })
    }

    func testShouldHandleHeaders() throws {
        let app = try prepareApp()
        defer { app.shutdown() }

        let acceptHeaders = "application/custom-type"
        let contentType = "some-custom-content-type"
        let headers: HTTPHeaders = HTTPHeaders([
            ("Accept", acceptHeaders),
            ("Content-Type", contentType)
        ])
        try app.test(
                HTTPMethod.GET,
                getPath("acceptable"),
                headers: headers,
                afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "you are acceptable; (Accept: \(acceptHeaders)) (Content-Type: \(contentType))")
        })
    }

    func testShouldHandleUrlParameters() throws {
        let app = try prepareApp()
        defer { app.shutdown() }

        let parameter = "some-id"
        try app.test(
            HTTPMethod.GET,
            getPath(parameter),
            afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
                XCTAssertEqual(res.body.string, "your parameter was: '\(parameter)'")
        })
    }

    override internal func getPath(_ path: String) -> String {
        "\(super.getPath(""))/\(GREETING_PATH.description)/\(path)"
    }

    static let allTests = [
        ("testShouldHandleRootRequests", testShouldHandleRootRequests),
        ("testShouldHandleQueryParams", testShouldHandleQueryParams),
        ("testShouldHandleHeaders", testShouldHandleHeaders),
        ("testShouldHandleUrlParameters", testShouldHandleUrlParameters)
    ]
}

