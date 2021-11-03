//
//  AuthView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI

struct AuthView: View {
  @ObservedObject var viewModel: AuthViewModel
  
  var body: some View {
    ZStack {
      Color.dark.edgesIgnoringSafeArea(.all)
      VStack {
        VStack(alignment: .leading, spacing: 8) {
          Text(viewModel.isSignIn ? "Sign In" : "Sign Up")
            .padding(.horizontal, 16)
            .foregroundColor(.white.opacity(0.9))
            .font(.regular(36))
          
          TextField("E-mail",
                    text: $viewModel.email)
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
                    text: $viewModel.password)
            .autocapitalization(.none)
            .padding(.vertical, 18)
            .padding(.horizontal, 24)
            .foregroundColor(.white)
            .font(.regular(16))
            .frame(maxWidth: .infinity)
            .background(Color.accentDark)
            .cornerRadius(16)
            .padding(.horizontal, 16)
          
          if !viewModel.isSignIn {
            TextField("Repeat Password",
                      text: $viewModel.repeatPassword)
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
        
        NavigationLink(isActive: $viewModel.canLogin) {
          if viewModel.isSignIn {
            MainView(viewModel: MainViewModel())
          } else {
            ProfileView()
          }
        } label: {
          Text(viewModel.isSignIn ? "Sign In" : "Sign Up")
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
              viewModel.checkFields()
            }
        }
      }
    }
  }
}

