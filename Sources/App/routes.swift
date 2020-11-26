import Vapor

public let BASE_PATH: PathComponent = "v1";
public let GREETING_PATH: PathComponent = "greeting"
public let ARITHMETIC_PATH: PathComponent = "arithmetic"

struct Hello: Content {
    var greeting: String?
}

func routes(_ app: Application, _ greetingController: GreetingController, _ arithmeticController: ArithmeticController) throws {

    app.group(BASE_PATH) { baseRoute in

        baseRoute.get { req -> String in
            "hello friend. try '/greeting' and '/arithmetic'"
        }

        baseRoute.group(GREETING_PATH, configure: greetingController.configureRoutes)
        baseRoute.group(ARITHMETIC_PATH, configure: arithmeticController.configureRoutes)

    }

}
