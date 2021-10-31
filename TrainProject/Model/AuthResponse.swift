//
//  AuthResponse.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation

struct AuthResponse: Codable {
  let accessToken: String
  let accessTokenExpiredAt: Date?
  let refreshToken: String
  let refreshTokenExpiredAt: Date?
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    accessToken = try container.decode(String.self, forKey: .accessToken)
    accessTokenExpiredAt = try container.decodeIfPresent(Date.self,
                                                         forKey: .accessTokenExpiredAt) ?? Date()
    refreshToken = try container.decode(String.self, forKey: .refreshToken)
    refreshTokenExpiredAt = try container.decodeIfPresent(Date.self,
                                                          forKey: .refreshTokenExpiredAt) ?? Date()
  }
}
