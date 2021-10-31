//
//  ChatsResponse.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation

struct ChatsResponse: Codable {
  let chat: Chat
  let lastMessage: Message?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    chat = try container.decode(Chat.self, forKey: .chat)
    lastMessage = try container.decodeIfPresent(Message.self,
                                       forKey: .lastMessage)
  }
  
  init() {
    chat = Chat()
    lastMessage = Message()
  }
}
