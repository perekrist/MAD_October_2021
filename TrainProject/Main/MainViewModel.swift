//
//  MainViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation
import SwiftUI

struct Chat: Identifiable, Codable {
  let id: String
  let title: String?
  let avatar: String?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    title = try container.decodeIfPresent(String.self,
                                                         forKey: .title)
    avatar = try container.decodeIfPresent(String.self,
                                                         forKey: .avatar)
  }
  
  init() {
    id = "f8782738-1432-46d6-8edd-f504e22ec1c5"
    title = "chat name"
    avatar = nil
  }
}

struct Message: Identifiable, Codable {
  let id: String
  let text: String?
  let date: String?
  let user: User?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    text = try container.decodeIfPresent(String.self,
                                                         forKey: .text)
    date = try container.decodeIfPresent(String.self,
                                                         forKey: .date)
    user = try container.decodeIfPresent(User.self,
                                                         forKey: .user)
  }
  
  init() {
    id = ""
    text = "I hope we will meet with you. May be not today...\nI hope we will meet with you. May be not today...I hope we will meet with you. May be not today...I hope we will meet with you. May be not today..."
    date = nil
    user = nil
  }
}

struct User: Codable {
  let userId: String
  let name: String?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userId = try container.decode(String.self, forKey: .userId)
    name = try container.decodeIfPresent(String.self,
                                                         forKey: .name)
  }
  
  init(name: String) {
    self.name = name
    self.userId = UUID().uuidString
  }
}

class MainViewModel: ObservableObject {
  var names: [String] = ["Mary", "Kristine", "Meggy", "Lilit"]
  @Published var last: [User] = []
  @Published var chats: [ChatsResponse] = []
  let networkService = NetworkService()
  
  init() {
    self.last = names.sorted().map { User(name: $0) }
  }
  
  func getChats() {
    networkService.getChats { chats in
      self.chats = chats
    }
  }
}
