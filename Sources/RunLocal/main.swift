import App
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try configure(app, GreetingController(logger: app.logger), ArithmeticController(logger: app.logger))
try app.run()
