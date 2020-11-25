#!/bin/bash
project="RunLambda"

if [[ "$(docker images | grep swift-lambda-builder)" != *"swift-lambda-builder"* ]]; then
  echo "swift-lambda-builder not found, building..."
  docker build -t swift-lambda-builder ./deploy
fi

echo "building $project..."
# compiles the project in release mode
docker run --rm --volume "$(pwd)/:/src" --workdir "/src/" swift-lambda-builder swift build --product $project -c release

echo "packaging $project..."
# packages the compiled project into a zip
docker run --rm --volume "$(pwd)/:/src" --workdir "/src/" swift-lambda-builder deploy/package-helper.sh $project
