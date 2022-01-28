//
//  ShowBannerSingleton.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import Foundation
import NotificationBannerSwift

class ShowBannerSingleton {
  static let shared = ShowBannerSingleton()
  
  func showErrorBanner(_ text: String) {
    showBanner(text, style: .danger)
  }
  
  func showInfoBanner(_ text: String) {
    showBanner(text, style: .info)
  }
  
  private func showBanner(_ text: String, style: BannerStyle) {
    GrowingNotificationBanner(title: text,
                              style: style).show()
  }
}
