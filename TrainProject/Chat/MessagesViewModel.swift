//
//  MessagesViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation
import SwiftUI

class MessagesViewModel: ObservableObject {
  @Published var chat: Chat
  @Published var messages: [Message] = []
  @Published var topics: [String] = ["Queens", "Royalty", "Knives"]
  @Published var message: String = ""
  @Published var myID = UserDefaults.standard.value(forKey: "id") as? String ?? ""
  
  private var id: String {
    return chat.id
  }
  
  private let networkService = NetworkService()
  
  init(chat: Chat) {
    self.chat = chat
  }
  
  func getMessages() {
    networkService.getMessages(id: id) { messages in
      self.messages = messages.reversed()
    }
  }
  
  func sendMessage() {
    networkService.sendMessage(id: id, text: message) { message in
      self.messages.append(message)
      self.message = ""
    }
  }
}
