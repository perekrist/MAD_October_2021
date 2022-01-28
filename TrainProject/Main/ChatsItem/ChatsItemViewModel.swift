//
//  ChatsItemViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import Foundation
import SwiftUI

class ChatsItemViewModel: ObservableObject, Identifiable {
  let id: String = UUID().uuidString
  @Published var chat: Chat
  @Published var lastMessage: Message?
  
  init(response: ChatsResponse) {
    self.chat = response.chat
    self.lastMessage = response.lastMessage
  }
}

