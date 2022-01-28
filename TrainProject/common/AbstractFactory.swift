//
//  AbstractFactory.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import Foundation
import UIKit

protocol IPhoneFactory {
  func getSmallButton() -> SmallButton
  func getNormalButton() -> NormalButton
}

class SmallButton {
  var image: UIImage?
}

class NormalButton {
  var image: UIImage?
  var title: String?
}

class Small15: SmallButton {
  override init() {
    super.init()
    self.image = UIImage(named: "small15")
  }
}
class Normal15: NormalButton {
  override init() {
    super.init()
    self.image = UIImage(named: "normal15")
    self.title = "Normal15"
  }
}

class Small14: SmallButton {
  override init() {
    super.init()
    self.image = UIImage(named: "small14")
  }
}
class Normal14: NormalButton {
  override init() {
    super.init()
    self.image = UIImage(named: "normal14")
    self.title = "Normal14"
  }
}

class iOS15Factory: IPhoneFactory {
  func getSmallButton() -> SmallButton {
    return Small15()
  }
  
  func getNormalButton() -> NormalButton {
    return Normal15()
  }
}

class iOS14Factory: IPhoneFactory {
  func getSmallButton() -> SmallButton {
    return Small14()
  }
  
  func getNormalButton() -> NormalButton {
    return Normal14()
  }
}

class CurrenClass {
  init() {
    let factory = getFactory()
    let smallButton = factory.getSmallButton()
    let normalButton = factory.getNormalButton()
    
    // do smth with buttons
  }
  
  func getFactory() -> IPhoneFactory {
    if UIDevice.current.systemVersion == "15.0" {
      return iOS15Factory()
    }
    return iOS14Factory()
  }
}
