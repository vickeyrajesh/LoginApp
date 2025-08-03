//
//  LoginService.swift
//  LoginApp
//
//  Created by Rajesh Yadav on 22/07/25.
//

import Foundation

protocol LoginServiceProtocol {
    func loginWith(_ username: String, _ password: String) async throws -> Bool
}

class MockLoginService: LoginServiceProtocol {
    func loginWith(_ username: String, _ password: String) async throws -> Bool {
        // Simulate network delay
//        try await Task.sleep(nanoseconds: 2_000_000_000) // 1 second

        // Simulate correct credentials
        return username == "user@user.com" && password == "password"
    }
}
