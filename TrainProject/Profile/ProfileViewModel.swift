//
//  ProfileViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
  @Published var topics: [Topic] = []
  let networkService = NetworkService()
  
  func getTopics() {
    networkService.getTopics { topics in
      self.topics = topics
    }
  }
}
