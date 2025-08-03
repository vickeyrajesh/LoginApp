//
//  LoginAppTests.swift
//  LoginAppTests
//
//  Created by Rajesh Yadav on 22/07/25.
//

import XCTest
@testable import LoginApp


final class LoginAppTests: XCTestCase {
    
    class SuccessMockService: LoginServiceProtocol {
        func loginWith(_ username: String, _ password: String) async throws -> Bool {
            true
        }
    }

    class FailureMockService: LoginServiceProtocol {
        func loginWith(_ username: String, _ password: String) async throws -> Bool {
            false
        }
    }
    
    @MainActor func testLoginEnabledWithValidInput() throws {
        let vm = LoginViewModel(loginService: SuccessMockService())
        vm.username = "test@example.com"
        vm.password = "password123"
        XCTAssertTrue(vm.isLoginEnabled)
    }

    @MainActor func testLoginDisabledWithInvalidEmail() throws {
        let vm = LoginViewModel()
        vm.username = "invalid"
        vm.password = "password123"
        XCTAssertFalse(vm.isLoginEnabled)
    }

    @MainActor func testLoginSuccess() async throws {
        let vm = LoginViewModel(loginService: SuccessMockService())
        vm.username = "user@user.com"
        vm.password = "password"
        await vm.login()
        XCTAssertEqual(vm.loginStatus, "Success")
    }

    @MainActor func testLoginFailure() async throws {
        let vm = LoginViewModel(loginService: FailureMockService())
        vm.username = "user@user.com"
        vm.password = "password"
        await vm.login()
        XCTAssertEqual(vm.loginStatus, "Failure")
    }



    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
