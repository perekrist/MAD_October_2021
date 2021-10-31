//
//  TrainProjectApp.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI
import NavigationStack

@main
struct TrainProjectApp: App {
//  @State var navigationStack = NavigationStack()
    var body: some Scene {
        WindowGroup {
          StartScreen()
//            .environmentObject(navigationStack)
        }
    }
}
