//
//  UIFont+Custom.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import Foundation
import UIKit
import SwiftUI

extension Font {
  static func bold(_ size: CGFloat) -> Font {
    return Font.custom("BalooPaaji2-Bold", size: size).bold()
  }
  static func extraBold(_ size: CGFloat) -> Font {
    return Font.custom("BalooPaaji2-ExtraBold", size: size).bold()
  }
  static func medium(_ size: CGFloat) -> Font {
    return Font.custom("BalooPaaji2-Medium", size: size).bold()
  }
  static func regular(_ size: CGFloat) -> Font {
    return Font.custom("BalooPaaji2-Regular", size: size).bold()
  }
  static func semiBold(_ size: CGFloat) -> Font {
    return Font.custom("BalooPaaji2-SemiBold", size: size).bold()
  }
  static func jRegular(_ size: CGFloat) -> Font {
    return Font.custom("JollyLodger-Regular", size: size).bold()
  }
}
