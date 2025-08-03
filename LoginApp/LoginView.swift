//
//  ContentView.swift
//  LoginApp
//
//  Created by Rajesh Yadav on 22/07/25.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var navigateToDashboard = false

    var body: some View {
        NavigationStack {
            
            VStack {
                TextField("Email", text: $loginViewModel.username)
                    .accessibilityIdentifier("usernameField")
                    .autocapitalization(.none)
                    .padding()
                    .disableAutocorrection(true)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                SecureField("Password", text: $loginViewModel.password)
                    .accessibilityIdentifier("passwordField")
                    .disableAutocorrection(true)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                if loginViewModel.isLoading {
                    ProgressView()
                        .accessibilityIdentifier("loadingIndicator")
                } else {
                    Button("Login") {
                        Task{
                            await loginViewModel.login()
                        }
                    }
                    .disabled(!loginViewModel.isLoginEnabled)
                    .accessibilityIdentifier("loginButton")
                    .padding()
                }
                
                Text(loginViewModel.loginStatus)
                    .accessibilityIdentifier("loginStatus")
                    .padding(.top)
                
                if !loginViewModel.errorMessage.isEmpty {
                    Text(loginViewModel.errorMessage)
                        .foregroundColor(.red)
                        .accessibilityIdentifier("errorMessage")
                }
            }
            .padding()
            .onChange(of: loginViewModel.shouldNavigate) { oldValue, newValue in
                if newValue == true {
                    navigateToDashboard = true
                }
            }
            .navigationDestination(isPresented: $navigateToDashboard) {
                DashboardView()
            }
        }
    }
}

#Preview {
    LoginView()
}
