import XCTVapor
import NIOHTTP1
import Foundation
@testable import App

final class ArithmeticTests: AppTesting {

    let encoder: JSONEncoder = JSONEncoder()

    func testShouldHandleRootRequests() throws {
        let app = try prepareApp()
        defer { app.shutdown() }

        try app.test(.GET, getPath(), afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "you can POST on basic arithmetic operations... (add, subtract, multiply, divide)")
        })
    }

    func testShouldBeAbleToPost() throws {
        let app = try prepareApp()
        defer { app.shutdown() }

        let input = ArithmeticInput(a: 4, b: 2)

        try validateArithmeticRequest(app, "add", input, { (a: Int, b: Int) -> Int in a + b } )
        try validateArithmeticRequest(app, "subtract", input, { (a: Int, b: Int) -> Int in a - b } )
        try validateArithmeticRequest(app, "multiply", input, { (a: Int, b: Int) -> Int in a * b } )
        try validateArithmeticRequest(app, "divide", input, { (a: Int, b: Int) -> Int in a / b } )
    }

    private func validateArithmeticRequest(
            _ app: Application,
            _ operation: String,
            _ input: ArithmeticInput,
            _ handler: (_ a: Int, _ b: Int) -> Int) throws {
        try app.test(
                .POST,
                getPath(operation),
                beforeRequest: { req in
                    try req.content.encode(input)
                },
                afterResponse: { res in
                    XCTAssertEqual(res.status, .ok)
                    let output = try res.content.decode(ArithmeticOutput.self)
                    XCTAssertEqual(output.result, handler(input.a, input.b))
                }
        )
    }

    override internal func getPath(_ path: String = "") -> String {
        "\(super.getPath(""))/\(ARITHMETIC_PATH.description)/\(path)"
    }

    static let allTests = [
        ("testShouldHandleRootRequests", testShouldHandleRootRequests)
    ]
}
