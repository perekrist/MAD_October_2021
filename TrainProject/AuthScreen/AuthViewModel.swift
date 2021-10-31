//
//  AuthViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation

struct AuthViewModel {
  let networkService = NetworkService()
  
  func signIn(email: String, password: String,
              completion: @escaping () -> ()) {
    networkService.login(email: email, password: password) { response in
      UserDefaults.standard.set(response.accessToken, forKey: "token")
      completion()
    }
  }
  
  func signUp(email: String, password: String,
              completion: @escaping () -> ()) {
    networkService.register(email: email, password: password) { response in
      UserDefaults.standard.set(response.accessToken, forKey: "token")
      completion()
    }
  }
}
