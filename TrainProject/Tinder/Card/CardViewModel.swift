//
//  CardViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import SwiftUI

class CardViewModel: ObservableObject {
  @Published var user: User
  @Published var onLikeUser: (() -> ())?
  @Published var onDislikeUser: (() -> ())?
  
  init(user: User) {
    self.user = user
  }
  
  func like() {
    onLikeUser?()
  }
  
  func dislike() {
    onDislikeUser?()
  }
}


