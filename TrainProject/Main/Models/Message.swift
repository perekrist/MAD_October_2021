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
}
