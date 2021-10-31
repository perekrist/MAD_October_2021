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
}

struct Message: Identifiable, Codable {
  let id: String
  let text: String?
  let createdAt: String?
  let user: User?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    text = try container.decodeIfPresent(String.self,
                                                         forKey: .text)
    createdAt = try container.decodeIfPresent(String.self,
                                                         forKey: .createdAt)
    user = try container.decodeIfPresent(User.self,
                                                         forKey: .user)
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
    
    networkService.getProfile { me in
      UserDefaults.standard.set(me.userId, forKey: "id")
    }
  }
  
  func getChats() {
    networkService.getChats { chats in
      self.chats = chats
    }
  }
}
