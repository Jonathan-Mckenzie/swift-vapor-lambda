import App
import Vapor

import VaporAWSLambdaRuntime
var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }
try configureApp(
        app,
        app.logger
)

app.servers.use(.lambda)
try app.run()
