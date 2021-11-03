//
//  MessagesView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessagesView: View {
  @ObservedObject var viewModel: MessagesViewModel
  
  private let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ZStack {
      Color.dark.edgesIgnoringSafeArea(.all)
      VStack(alignment: .leading) {
        HStack {
          WebImage(url: URL(string: viewModel.chat.avatar ?? ""))
            .resizable()
            .scaledToFill()
            .frame(width: 82, height: 82)
            .clipShape(Circle())
            .padding(16)
          VStack(alignment: .leading) {
            Text(viewModel.chat.title ?? "")
              .foregroundColor(.white)
              .font(.regular(36))
            HStack(spacing: 5) {
              ForEach(viewModel.topics, id: \.self) { topic in
                Text(topic)
                  .font(.regular(14))
                  .foregroundColor(.dark)
                  .padding(.horizontal, 8)
                  .background(Color.orangeLight)
                  .clipShape(Capsule())
              }
            }
          }.padding(.top, -25)
        }.padding(.top, -25)
        VStack {
          ScrollView(.vertical) {
            ForEach(viewModel.messages) { msg in
              let isMyMessage: Bool = msg.userID == viewModel.myID
              HStack {
                if isMyMessage {
                  Spacer()
                }
                VStack(spacing: 8) {
                  Text(msg.text ?? "")
                    .padding(.vertical, 7)
                    .padding(.horizontal, 12)
                    .foregroundColor(isMyMessage ? .dark : .white)
                    .font(.regular(15))
                    .background(isMyMessage ? Color.orangeLight : Color.accent)
                    .cornerRadius(20)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
                  Text(msg.createdAt ?? "")
                    .foregroundColor(.gray)
                    .font(.regular(11))
                }
                if isMyMessage {
                  Spacer()
                }
              }
            }
          }
        }.frame(maxWidth: .infinity)
          .padding()
        HStack(spacing: 19) {
          TextField("",
                    text: $viewModel.message)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .foregroundColor(.white)
            .font(.regular(16))
            .frame(maxWidth: .infinity)
            .background(Color.accentDark)
            .cornerRadius(16)
          Button {
            viewModel.sendMessage()
          } label: {
            Image("send")
          }
        }.padding(.horizontal, 16)
      }
    }.onReceive(timer, perform: { _ in
      viewModel.getMessages()
    }).onAppear {
      if viewModel.messages.isEmpty {
        viewModel.getMessages()
      }
    }
  }
}
