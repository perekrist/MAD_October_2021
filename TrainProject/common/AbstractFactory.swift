//
//  AbstractFactory.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import Foundation

protocol SuperHero {
  static func make(name: String, power: String) -> (SuperHero)
  func resolve(problem: String) -> Bool
}

typealias SuperHeroFactory = (String, String) -> SuperHero

struct MarvelSuperHero: SuperHero {
  static func make(name: String, power: String) -> SuperHero {
    return MarvelSuperHero()
  }
  
  func resolve(problem: String) -> Bool {
    return true
  }
}

struct DCSuperHero: SuperHero {
  static func make(name: String, power: String) -> (SuperHero) {
    return DCSuperHero()
  }
  
  func resolve(problem: String) -> Bool {
    return false
  }
}

enum SuperHeroType {
  case marvel, dc
}

enum SuperHeroHelper {
  static func factoryFor(type : SuperHeroType) -> SuperHeroFactory {
    switch type {
    case .marvel:
      return MarvelSuperHero.make
    case .dc:
      return DCSuperHero.make
    }
  }
}


let superHeroFactoryMarvel = SuperHeroHelper.factoryFor(type: .marvel)
let superHeroMarvel = superHeroFactoryMarvel("Spiderman", "Spider Powers")
//superHeroMarvel.resolve(problem: "Disturbs on the street")

let superHeroFactoryDC = SuperHeroHelper.factoryFor(type: .dc)
let superHeroDC = superHeroFactoryDC("Batman", "Bat Powers")
//superHeroDC.resolve(problem: "Bank robbery")
