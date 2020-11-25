import Vapor

let BASE_PATH: PathComponent = "v1";

struct Hello: Content {
    var greeting: String?
}

func routes(_ app: Application, _ greetingController: GreetingController, _ arithmeticController: ArithmeticController) throws {

    app.group(BASE_PATH) { baseRoute in

        baseRoute.get { req -> String in
            "hello friend. try '/greeting' and '/arithmetic'"
        }

        baseRoute.group("greeting", configure: greetingController.configureRoutes)
        baseRoute.group("arithmetic", configure: arithmeticController.configureRoutes)

    }

}
