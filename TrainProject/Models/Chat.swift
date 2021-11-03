//
//  Chat.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import Foundation

struct Chat: Identifiable, Codable {
  let id: String
  let title: String?
  let avatar: String?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    title = try container.decodeIfPresent(String.self, forKey: .title)
    avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
  }
}
