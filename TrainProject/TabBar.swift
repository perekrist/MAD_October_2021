//
//  TabBar.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 03.11.2021.
//

import SwiftUI

struct TabBar: View {
  var body: some View {
    TabView {
      MainView()
        .tabItem {
          Label("Main", systemImage: "list.dash")
        }.navigationBarHidden(true)
      
      TinderView()
        .tabItem {
          Label("Tinder", systemImage: "square.and.pencil")
        }.navigationBarHidden(true)
    }.navigationBarHidden(true)
  }
}
