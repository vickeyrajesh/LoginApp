//
//  LoginViewModel.swift
//  LoginApp
//
//  Created by Rajesh Yadav on 22/07/25.
//

import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoginEnabled: Bool = false
    @Published var loginStatus: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var shouldNavigate = false

    private var cancellables = Set<AnyCancellable>()
    private let loginService: LoginServiceProtocol

    init(loginService: LoginServiceProtocol = MockLoginService()) {
        self.loginService = loginService

        Publishers.CombineLatest($username, $password)
            .map { username, password in
                return Self.validateEmail(username) && password.count >= 6
            }
            .assign(to: &$isLoginEnabled)
    }

    func login() async {
        isLoading = true
        errorMessage = ""
        do {
            let success = try await loginService.loginWith(username, password)
            loginStatus = success ? "Success" : "Failure"
            shouldNavigate = success ? true : false
            if !success {
                errorMessage = "Invalid credentials"
            }
        } catch {
            loginStatus = "Error"
            errorMessage = "Something went wrong"
        }
        isLoading = false
    }

    private static func validateEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailFormat).evaluate(with: email)
    }
}
