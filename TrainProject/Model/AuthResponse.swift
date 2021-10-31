//
//  AuthResponse.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation

struct AuthResponse: Codable {
  let accessToken: String
  let accessTokenExpiredAt: String
  let refreshToken: String
  let refreshTokenExpiredAt: String
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    accessToken = try container.decode(String.self,
                                                forKey: .accessToken)
    accessTokenExpiredAt = try container.decode(String.self,
                                                         forKey: .accessTokenExpiredAt)
    refreshToken = try container.decode(String.self,
                                                 forKey: .refreshToken)
    refreshTokenExpiredAt = try container.decode(String.self,
                                                          forKey: .refreshTokenExpiredAt)
  }
}
