//
//  AuthScreen.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI
import NotificationBannerSwift

struct AuthScreen: View {
  @State var isSignIn: Bool
  @State var canLogin = false
  
  @State var email: String = "mail@mail.com"
  @State var password: String = "qwerty12345"
  @State var repeatPassword: String = "qwerty12345"
  @State var viewModel = AuthViewModel()
  
  var body: some View {
    ZStack {
      Color.dark.edgesIgnoringSafeArea(.all)
      VStack {
        VStack(alignment: .leading, spacing: 8) {
          Text(isSignIn ? "Sign In" : "Sign Up")
            .padding(.horizontal, 16)
            .foregroundColor(.white.opacity(0.9))
            .font(.regular(36))
          
          TextField("E-mail",
                    text: $email)
            .autocapitalization(.none)
            .padding(.vertical, 18)
            .padding(.horizontal, 24)
            .foregroundColor(.white)
            .font(.regular(16))
            .frame(maxWidth: .infinity)
            .background(Color.accentDark)
            .cornerRadius(16)
            .padding(.horizontal, 16)
          
          TextField("Password",
                    text: $password)
            .autocapitalization(.none)
            .padding(.vertical, 18)
            .padding(.horizontal, 24)
            .foregroundColor(.white)
            .font(.regular(16))
            .frame(maxWidth: .infinity)
            .background(Color.accentDark)
            .cornerRadius(16)
            .padding(.horizontal, 16)
          
          if !isSignIn {
            TextField("Repeat Password",
                      text: $repeatPassword)
              .accentColor(.white)
              .autocapitalization(.none)
              .padding(.vertical, 18)
              .padding(.horizontal, 24)
              .font(.regular(16))
              .frame(maxWidth: .infinity)
              .background(Color.accentDark)
              .cornerRadius(16)
              .padding(.horizontal, 16)
              .foregroundColor(.white)
          }
        }.padding(.top, -40)
        Spacer()
        
        NavigationLink(isActive: $canLogin) {
          if isSignIn {
            MainView()
          } else {
            ProfileView()
          }
        } label: {
          Text(isSignIn ? "Sign In" : "Sign Up")
            .font(.regular(16))
            .foregroundColor(.dark)
            .frame(maxWidth: .infinity, maxHeight: 56,
                   alignment: .center)
            .background(Color.orangeLight)
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .shadow(color: .orangeLight,
                    radius: 10,
                    x: 0, y: 0)
            .onTapGesture {
              checkFields()
            }
        }
      }
    }
  }
  
  func checkFields() {
    if email.isEmpty || password.isEmpty ||
        (!isSignIn && repeatPassword.isEmpty) {
      GrowingNotificationBanner(title: "Fill all fields!",
                                style: .danger).show()
      canLogin = false
    } else if !(email.contains("@") && email.contains(".")) {
      GrowingNotificationBanner(title: "Email is not correct!",
                                style: .danger).show()
      canLogin = false
    } else {
      if isSignIn {
        viewModel.signIn(email: email,
                         password: password) {
          canLogin = true
        }
        //
        canLogin = true
      } else {
        viewModel.signUp(email: email,
                         password: password) {
          canLogin = true
        }
        //
        canLogin = true
      }
    }
  }
}

