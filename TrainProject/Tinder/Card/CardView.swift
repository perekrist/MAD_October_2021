//
//  CardView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
  @ObservedObject var viewModel: CardViewModel
  
  @State private var translation: CGSize = .zero
  
  var body: some View {
    GeometryReader { geometry in
      VStack(alignment: .leading) {
        WebImage(url: URL(string: viewModel.user.avatar ?? ""))
          .resizable()
          .scaledToFill()
          .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
          .clipped()
        
        HStack {
          Text(viewModel.user.name ?? "no name")
            .font(.regular(21))
            .foregroundColor(.white)
          Spacer()
          Text("5 Matches")
            .font(.regular(21))
            .foregroundColor(.orangeDark)
        }.padding(16)
          .background(Color.accentDark)
      }
      .padding(.bottom)
      .background(Color.white)
      .cornerRadius(13)
      .shadow(color: .black.opacity(0.04), radius: 1, x: 0, y: 3)
      .shadow(color: .black.opacity(0.12), radius: 8, x: 0, y: 3)
      .offset(x: self.translation.width, y: self.translation.height)
      .gesture(
        DragGesture()
          .onChanged { value in
            self.translation = value.translation
          }.onEnded { value in
            if abs(value.translation.width / geometry.size.width) > 0.5 {
              viewModel.like()
            } else {
              self.translation = .zero
            }
          }
      ).rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25),
                       anchor: .bottom)
        .animation(.interactiveSpring())
    }
  }
}
