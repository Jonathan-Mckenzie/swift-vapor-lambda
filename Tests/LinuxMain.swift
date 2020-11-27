import XCTest
import AppTests

var tests = [XCTestCaseEntry]()
tests += GreetingTests.allTests()
tests += ArithmeticTests.allTests()
XCTMain(tests)
