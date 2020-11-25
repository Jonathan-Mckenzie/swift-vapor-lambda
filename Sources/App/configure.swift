import Vapor

// configures your application
public func configure(_ app: Application,
                      _ greetingController: GreetingController,
                      _ arithmeticController: ArithmeticController) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    try routes(app, greetingController, arithmeticController)
}
