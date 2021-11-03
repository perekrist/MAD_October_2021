//
//  User.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import Foundation

struct User: Codable {
  let userId: String
  var name: String? = nil
  var aboutMyself: String? = nil
  var avatar: String? = nil
  var topics: [Topic] = []
  
  var matches: Int {
    return (0..<10).randomElement() ?? 0
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    userId = try container.decode(String.self, forKey: .userId)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    aboutMyself = try container.decodeIfPresent(String.self, forKey: .aboutMyself)
    avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
    topics = try container.decodeIfPresent([Topic].self, forKey: .topics) ?? []
  }
  
  init(name: String) {
    self.name = name
    self.userId = UUID().uuidString
  }
}
