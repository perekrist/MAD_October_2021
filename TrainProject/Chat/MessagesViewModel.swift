//
//  MessagesViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation
import SwiftUI

class MessagesViewModel: ObservableObject {
  @Published var messages: [Message] = []
  let networkService = NetworkService()
  
  func getMessages(id: String) {
    networkService.getMessages(id: id) { messages in
      self.messages = messages.reversed()
    }
  }
  
  func sendMessage(id: String, text: String) {
    networkService.sendMessage(id: id, text: text) { message in
      self.messages.append(message)
    }
  }
}
