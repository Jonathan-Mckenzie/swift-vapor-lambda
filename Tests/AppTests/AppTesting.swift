import XCTVapor
@testable import App

class AppTesting: XCTestCase {

    internal func prepareApp() throws -> Application {
        let app = Application(.testing)
        try configureApp(
                app,
                GreetingController(logger: app.logger),
                ArithmeticController(logger: app.logger)
        )
        return app;
    }

    internal func getPath(_ path: String) -> String {
        "\(BASE_PATH)/\(path)"
    }

}
