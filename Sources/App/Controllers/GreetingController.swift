import Foundation
import Vapor

struct GreetingQuery: Content {
    var name: String?
}

public class GreetingController {
    let logger: Logger

    public init(logger: Logger) {
        self.logger = logger;
    }

    func configureRoutes(routes: RoutesBuilder) {
        // test query params
        routes.get { (req: Request) -> String in
            let query: GreetingQuery = try req.query.decode(GreetingQuery.self)
            if let name = query.name {
                return "hello \(name)! Try: '/greeting/acceptable'"
            } else {
                return "hello friend, what is your ?name"
            }
        }

        // test headers
        routes.get("acceptable") { (req: Request) -> String in
            self.logger.info("headers: \(req.headers)")
            let acceptHeaders: String = req.headers["Accept"].first ?? ""
            let contentType: String = req.headers["Content-Type"].first ?? ""
            return "you are acceptable; (Accept: \(acceptHeaders)) (Content-Type: \(contentType))"
        }

        // test url parameters
        routes.get(":parameter") { (req: Request) -> String in
            return "your parameter was: '\(req.parameters.get("parameter") ?? "")'"
        }
    }
}
