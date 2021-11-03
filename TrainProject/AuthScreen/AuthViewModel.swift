//
//  AuthViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI
import NotificationBannerSwift

class AuthViewModel: ObservableObject {
  @Published var isSignIn: Bool
  @Published var canLogin = false
  @Published var email: String = "mail@mail.com"
  @Published var password: String = "qwerty12345"
  @Published var repeatPassword: String = "qwerty12345"
  
  private let networkService = NetworkService()
  
  init(isSignIn: Bool) {
    self.isSignIn = isSignIn
  }
  
  func checkFields() {
    if email.isEmpty || password.isEmpty || (!isSignIn && repeatPassword.isEmpty) {
      ShowBannerSingleton.shared.showErrorBanner("Fill all fields!")
      canLogin = false
    } else if !(email.contains("@") && email.contains(".")) {
      ShowBannerSingleton.shared.showErrorBanner("Email is not correct!")
      canLogin = false
    } else {
      auth {
        self.canLogin = true
      }
    }
  }
  
  private func auth(completion: @escaping () -> ()) {
    if isSignIn {
      signIn(email: email, password: password) {
        completion()
      }
    } else {
      signUp(email: email, password: password) {
        completion()
      }
    }
  }
  
  private func signIn(email: String, password: String,
                      completion: @escaping () -> ()) {
    networkService.login(email: email, password: password) { response in
      UserDefaults.standard.set(response.accessToken, forKey: "token")
      completion()
    }
  }
  
  private func signUp(email: String, password: String,
                      completion: @escaping () -> ()) {
    networkService.register(email: email, password: password) { response in
      UserDefaults.standard.set(response.accessToken, forKey: "token")
      completion()
    }
  }
}
