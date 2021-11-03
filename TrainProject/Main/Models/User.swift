//
//  User.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import Foundation

struct User: Codable {
  let userId: String
  let name: String?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userId = try container.decode(String.self, forKey: .userId)
    name = try container.decodeIfPresent(String.self, forKey: .name)
  }
  
  init(name: String) {
    self.name = name
    self.userId = UUID().uuidString
  }
}
