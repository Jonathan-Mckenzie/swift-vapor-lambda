import Foundation
import Vapor

struct ArithmeticInput: Content {
    let a: Int
    let b: Int
}

struct ArithmeticOutput: Content {
    let success: Bool
    let result: Int

    init (success: Bool, result: Int) {
        self.success = success
        self.result = result
    }

    init(result: Int) {
        self.success = true
        self.result = result
    }
}

struct ArithmeticRequest {
    var req: Request
    var input: ArithmeticInput
}

extension ArithmeticInput: Validatable {
    public static func validations(_ validations: inout Validations) {
        validations.add("a", as: Int.self, is: .range(0...))
        validations.add("b", as: Int.self, is: .range(0...))
    }
}

class ArithmeticMiddleware: Middleware {
    let logger: Logger
    public init(_ logger: Logger) {
        self.logger = logger
    }

    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        logger.info("arithmetic middleware.")
        return next.respond(to: request)
    }
}

public class ArithmeticController {

    let encoder: JSONEncoder
    let logger: Logger

    public init(logger: Logger) {
        self.logger = logger;
        encoder = JSONEncoder();
    }

    func configureRoutes(routes: RoutesBuilder) {
        let grouped = routes.grouped(ArithmeticMiddleware(self.logger))

        grouped.get { req in
            "you can POST on basic arithmetic operations... (add, subtract, multiply, divide)"
        }

        grouped.post("add") { (req: Request) -> ArithmeticOutput in
            let input: ArithmeticInput = try self.validateAndDecodeInput(req)
            return ArithmeticOutput(result: input.a + input.b)
        }

        grouped.post("subtract") { (req: Request) -> ArithmeticOutput in
            let input: ArithmeticInput = try self.validateAndDecodeInput(req)
            return ArithmeticOutput(result: input.a - input.b)
        }

        grouped.post("multiply") { (req: Request) -> ArithmeticOutput in
            let input: ArithmeticInput = try self.validateAndDecodeInput(req)
            return ArithmeticOutput(result: input.a * input.b)
        }

        grouped.post("divide") { (req: Request) -> ArithmeticOutput in
            let input: ArithmeticInput = try self.validateAndDecodeInput(req)
            guard input.b > 0 else {
                return ArithmeticOutput(success: false, result: 0)
            }
            return ArithmeticOutput(result: input.a / input.b)
        }
    }

    private func validateAndDecodeInput(_ request: Request) throws -> ArithmeticInput {
        try ArithmeticInput.validate(content: request)
        return try request.content.decode(ArithmeticInput.self)
    }
}
