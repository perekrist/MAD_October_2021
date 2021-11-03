//
//  TinderViewModel.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import SwiftUI

class TinderViewModel: ObservableObject {
  @Published var cardsViewModels: [CardViewModel] = []
  
  private var users: [User] = []
  private let networkService = NetworkService()
  
  init() {
    getFeed()
  }
  
  func getCardWidth(_ geometry: GeometryProxy, id: String) -> CGFloat {
    let index = users.firstIndex { $0.userId == id } ?? 0
    let offset: CGFloat = CGFloat((users.count > 3 ? 3 : users.count) - 1 - index) * 30
    return geometry.size.width - offset
  }
  
  func getCardOffset(_ geometry: GeometryProxy, id: String) -> CGFloat {
    let index = users.firstIndex { $0.userId == id } ?? 0
    return CGFloat((users.count > 3 ? 3 : users.count) - 1 - index) * 30
  }
  
  private func getFeed() {
    networkService.getFeed { users in
      self.users = Array(users[0..<3])
      self.bindToViewModels()
    }
  }
  
  private func like(id: String) {
    guard let index = users.map { $0.userId }.firstIndex(of: id) else { return }
    networkService.like(userID: id) { _ in
      self.users.remove(at: index)
      self.cardsViewModels.remove(at: index)
    }
  }
  
  private func dislike(id: String) {
    guard let index = users.map { $0.userId }.firstIndex(of: id) else { return }
    networkService.dislike(userID: id) { _ in
      self.users.remove(at: index)
      self.cardsViewModels.remove(at: index)
    }
  }
  
  private func bindToViewModels() {
    cardsViewModels = users.map { CardViewModel(user: $0) }
    
    cardsViewModels.forEach { viewModel in
      viewModel.onLikeUser = { [weak self, weak viewModel] in
        guard let self = self, let viewModel = viewModel else { return }
        self.like(id: viewModel.user.userId)
      }
      viewModel.onDislikeUser = { [weak self, weak viewModel] in
        guard let self = self, let viewModel = viewModel else { return }
        self.dislike(id: viewModel.user.userId)
      }
    }
  }
}
