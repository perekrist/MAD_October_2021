//
//  MessagesView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessagesView: View {
  @State var avatar: String?
  @State var id: String
  @State var name: String
  @State var topics: [String] = ["Queens", "Royalty", "Knives"]
  @State var message: String = ""
  @ObservedObject var viewModel = MessagesViewModel()
  
  let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ZStack {
      Color.dark.edgesIgnoringSafeArea(.all)
      VStack(alignment: .leading) {
        HStack {
          WebImage(url: URL(string: avatar ?? ""))
            .resizable()
            .scaledToFill()
            .frame(width: 82, height: 82)
            .clipShape(Circle())
            .padding(16)
          VStack(alignment: .leading) {
            Text(name)
              .foregroundColor(.white)
              .font(.regular(36))
            HStack(spacing: 5) {
              ForEach(topics, id: \.self) { topic in
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
        VStack(alignment: .leading) {
        ScrollView(.vertical) {
          ForEach(viewModel.messages) { msg in
            Text(msg.text ?? "")
              .foregroundColor(.white)
              .font(.regular(15))
          }
        }
        }
        HStack(spacing: 19) {
          TextField("",
                    text: $message)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .foregroundColor(.white)
            .font(.regular(16))
            .frame(maxWidth: .infinity)
            .background(Color.accentDark)
            .cornerRadius(16)
          Button {
            viewModel.sendMessage(id: id, text: message)
            self.message = ""
          } label: {
            Image("send")
          }
        }.padding(.horizontal, 16)
      }
    }.onReceive(timer, perform: { _ in
      viewModel.getMessages(id: id)
    })
    .onAppear {
      viewModel.getMessages(id: id)
    }
  }
}
