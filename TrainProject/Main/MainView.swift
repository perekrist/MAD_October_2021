//
//  MainView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
  @ObservedObject var viewModel = MainViewModel()
  
  var body: some View {
    ZStack(alignment: .leading) {
      Color.dark.edgesIgnoringSafeArea(.all)
      ScrollView(.vertical) {
        VStack(alignment: .leading) {
          Text("Last")
            .foregroundColor(.white)
            .font(.regular(36))
          
          ScrollView(.horizontal) {
            HStack {
              ForEach(viewModel.last, id: \.userId) { user in
                VStack {
                  Image("logo")
                    .resizable()
                    .frame(width: 82, height: 82)
                  Text(user.name ?? "-")
                    .foregroundColor(.white)
                    .font(.regular(14))
                    .padding(.top, 8)
                }
              }
            }
          }.padding(.top, -50)
          
          Text("Messages")
            .foregroundColor(.white)
            .font(.regular(36))
          VStack(alignment: .leading) {
            ForEach(viewModel.chats, id: \.chat.id) { chat in
              NavigationLink {
                MessagesView(avatar: chat.chat.avatar,
                             id: chat.chat.id,
                             name: chat.chat.title ?? "-")
              } label: {
                HStack {
                  WebImage(url: URL(string: chat.chat.avatar ?? ""))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .padding(16)
                  VStack(alignment: .leading) {
                    Text(chat.chat.title ?? "-")
                      .foregroundColor(.white)
                      .font(.regular(16))
                    Text(chat.lastMessage?.text ?? "no last message")
                      .lineLimit(10)
                      .multilineTextAlignment(.leading)
                      .foregroundColor(.white)
                      .font(.regular(16))
                      .padding(.trailing, 16)
                    Rectangle()
                      .foregroundColor(.orangeDark)
                      .frame(width: 280,
                             height: 1,
                             alignment: .trailing)
                  }
                }
              }

            }
          }.padding(.top, -50)
        }.padding(.leading, 21)
      }
    }.onAppear {
      viewModel.getChats()
    }
    .navigationBarHidden(true)
  }
}
