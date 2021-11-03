//
//  Message.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import Foundation

struct Message: Identifiable, Codable {
  let id: String
  let text: String?
  let createdAt: String?
  let user: User?
  
  var userID: String? {
    return user?.userId
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    text = try container.decodeIfPresent(String.self, forKey: .text)
    createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
    user = try container.decodeIfPresent(User.self, forKey: .user)
  }
  
  init(id: String, text: String?, createdAt: String?, user: User?) {
    self.id = id
    self.text = text
    self.createdAt = createdAt
    self.user = user
  }
  
  // MARK: - Prototype pattern
  func copy(id: String? = nil,
            text: String? = nil,
            createdAt: String? = nil,
            user: User? = nil) -> Message {
    let cloneID = id == nil ? self.id : id!
    let cloneText = text == nil ? self.text : text
    let cloneCreatedAt = createdAt == nil ? self.createdAt : createdAt
    let cloneUser = user == nil ? self.user : user
    
    return Message(id: cloneID, text: cloneText, createdAt: cloneCreatedAt, user: cloneUser)
  }
}
