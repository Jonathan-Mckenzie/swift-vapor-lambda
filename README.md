# SwiftVaporLambda
Demonstrates some functionality of Vapor and how it can drop into an AWS Lambda & API Gateway environment.  

Uses the following:  
[Swift](https://github.com/apple/swift)  
[Vapor](https://vapor.codes/)  
[vapor-aws-lambda-runtime](https://github.com/vapor-community/vapor-aws-lambda-runtime)

## Run Locally
`Sources/RunLocal`  
Runs vapor app locally without lambda or api gateway runtime.

#### Setup
Launch xcode, run the `RunLocal` app

## Run on Lambda
`Sources/RunLambda`  
Builds vapor app and injects the lambda runtime into the app specifically looking for the invocations from api gateway.

#### Build

1. Run `$ ./deploy/build.sh`
1. Upload `.build/lambda/RunLambda/lambda.zip` to AWS Lambda

#### AWS API Gateway

This vapor app is designed to run with a lightweight HTTP API gateway with a single root path /v1 where all subsequent routes are handled by the vapor routing library.

