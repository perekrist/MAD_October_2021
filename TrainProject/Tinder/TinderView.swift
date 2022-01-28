//
//  TinderView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import SwiftUI

struct TinderView: View {
  @ObservedObject private var viewModel = TinderViewModel()
  var body: some View {
    ZStack(alignment: .top) {
      Color.dark.edgesIgnoringSafeArea(.all)
      RoundedRectangle(cornerRadius: 39)
        .foregroundColor(.accent)
        .frame(width: UIScreen.main.bounds.width,
               height: 344)
        .edgesIgnoringSafeArea(.top)
      GeometryReader { geometry in
        VStack {
          Text("Trick or Treat?")
            .foregroundColor(.white)
            .font(.regular(36))
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 21)
          
          ZStack {
            ForEach(viewModel.cardsViewModels, id: \.user.userId) { cardViewModel in
              CardView(viewModel: cardViewModel)
                .frame(width: viewModel.getCardWidth(geometry, id: cardViewModel.user.userId),
                       height: 300)
                .offset(x: 0, y: viewModel.getCardOffset(geometry, id: cardViewModel.user.userId))
            }
          }
          Spacer()
        }
      }
    }
  }
}
