//
//  MainView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
  @ObservedObject var viewModel: MainViewModel
  
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
            ForEach(viewModel.chatsItemViewModels) { viewModel in
              NavigationLink {
                MessagesView(viewModel: MessagesViewModel(chat: viewModel.chat))
              } label: {
                ChatsItemView(viewModel: viewModel)
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
