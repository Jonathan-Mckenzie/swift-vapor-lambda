import Vapor

public func configureApp(_ app: Application,
                         _ logger: Logger) throws {
    // inject dependencies
    let greetingController = GreetingController(logger: logger)
    let arithmeticController = ArithmeticController(logger: logger)

    // register routes
    try routes(
            app,
            greetingController,
            arithmeticController
    )
}
