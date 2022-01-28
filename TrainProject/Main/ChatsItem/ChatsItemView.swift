//
//  ChatsItemView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatsItemView: View {
  @ObservedObject var viewModel: ChatsItemViewModel
  
  var body: some View {
    HStack {
      WebImage(url: URL(string: viewModel.chat.avatar ?? ""))
        .resizable()
        .scaledToFill()
        .frame(width: 64, height: 64)
        .clipShape(Circle())
        .padding(16)
      VStack(alignment: .leading) {
        Text(viewModel.chat.title ?? "-")
          .foregroundColor(.white)
          .font(.regular(16))
        Text(viewModel.lastMessage?.text ?? "no messages yet")
          .lineLimit(10)
          .multilineTextAlignment(.leading)
          .foregroundColor(.white)
          .font(.regular(16))
          .padding(.trailing, 16)
        Rectangle()
          .foregroundColor(.orangeDark)
          .frame(width: 280, height: 1, alignment: .trailing)
      }
    }
  }
}
