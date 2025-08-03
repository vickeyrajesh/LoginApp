//
//  LoginAppUITests.swift
//  LoginAppUITests
//
//  Created by Rajesh Yadav on 22/07/25.
//

import XCTest

final class LoginAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExampleFailure() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let username = app.textFields["usernameField"]
        let password = app.secureTextFields["passwordField"]
        let btnLogin = app.buttons["loginButton"]
        let loginStatus = app.staticTexts["loginStatus"]

        username.tap()
        username.typeText("user@user.com")
        
        password.tap()
        password.typeText("pass1111")
        
        XCTAssertTrue(btnLogin.isEnabled)
        btnLogin.tap()
        
        let exists = btnLogin.waitForExistence(timeout: 5)
        XCTAssertTrue(exists, "Login button did not appear")

        let failureText = loginStatus.waitForExistence(timeout: 3)
        XCTAssertTrue(failureText)
        XCTAssertEqual(loginStatus.label, "Failure")
    }
    
    @MainActor
    func testExampleSuccess() throws {
        let app = XCUIApplication()
        app.launch()
        
        let username = app.textFields["usernameField"]
        let password = app.secureTextFields["passwordField"]
        let loginBtn = app.buttons["loginButton"]
        let loginStatus = app.staticTexts["loginStatus"]

        username.tap()
        username.typeText("user@user.com")
        
        password.tap()
        password.typeText("password")
        
        XCTAssertTrue(loginBtn.isEnabled)
        loginBtn.tap()
        
        let successPredicate = NSPredicate(format: "label == %@", "Success")
        expectation(for: successPredicate, evaluatedWith: loginStatus, handler: nil)
        waitForExpectations(timeout: 5)

        let successText = loginStatus.waitForExistence(timeout: 3)
        XCTAssert(successText)
        XCTAssertEqual(loginStatus.label, "Success")
        
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
