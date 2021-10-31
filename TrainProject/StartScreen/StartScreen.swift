//
//  StartScreen.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI

struct StartScreen: View {
  var body: some View {
    NavigationView {
      ZStack {
        Color.dark.edgesIgnoringSafeArea(.all)
        VStack(alignment: .center) {
          VStack {
            Spacer()
            Image("icon")
            Spacer()
          }
          NavigationLink {
            AuthScreen(isSignIn: false)
          } label: {
            Text("Sign Up")
              .font(.regular(16))
              .foregroundColor(.dark)
              .frame(maxWidth: .infinity, maxHeight: 56,
                     alignment: .center)
              .background(Color.orangeLight)
              .cornerRadius(16)
          }.padding(.horizontal, 16)
            .shadow(color: .orangeLight,
                    radius: 10,
                    x: 0, y: 0)
          Text("Already have an account?")
            .font(.regular(16))
            .foregroundColor(.orangeDark)
            .padding(.top, 24)
          
          
          NavigationLink {
            AuthScreen(isSignIn: true)
          } label: {
            Text("Sign in")
              .foregroundColor(.orangeLight)
              .font(.regular(16))
              .underline()
          }.padding(.top, 8)
            .padding(.bottom, 30)
        
        }
      }
    }.accentColor(.white)
  }
}


struct StartScreen_Previews: PreviewProvider {
  static var previews: some View {
    StartScreen()
  }
}
