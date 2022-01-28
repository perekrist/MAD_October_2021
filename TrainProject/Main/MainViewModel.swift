//
//  MainViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
  @Published var last: [User] = []
  @Published var chatsItemViewModels: [ChatsItemViewModel] = []
  
  private var chats: [ChatsResponse] = [] {
    didSet {
      chatsItemViewModels = chats.map { ChatsItemViewModel(response: $0) }
    }
  }
  
  private var names: [String] = ["Mary", "Kristine", "Meggy", "Lilit"]
  private let networkService = NetworkService()
  
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
