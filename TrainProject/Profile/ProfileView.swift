//
//  ProfileView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI

struct Topic: Codable, Identifiable {
  let id: String
  let title: String
  var isSelected: Bool = false
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decode(String.self, forKey: .id)
    title = try container.decode(String.self, forKey: .title)
  }
}

struct ProfileView: View {
  @ObservedObject var viewModel = ProfileViewModel()
  
  @State var name: String = ""
  @State var about: String = ""
  
  var body: some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    ZStack {
      Color.dark.edgesIgnoringSafeArea(.all)
      VStack {
        Text("Why are you scary?")
          .foregroundColor(.white)
          .font(.regular(24))
          .padding(.top, 40)
        TextField("Name",
                  text: $name)
          .accentColor(.white)
          .autocapitalization(.none)
          .padding(.vertical, 18)
          .padding(.horizontal, 24)
          .font(.regular(16))
          .frame(maxWidth: .infinity)
          .background(Color.accentDark)
          .cornerRadius(16)
          .padding(.horizontal, 16)
          .foregroundColor(.white)
        TextField("About",
                  text: $about)
          .accentColor(.white)
          .autocapitalization(.none)
          .padding(.vertical, 18)
          .padding(.horizontal, 24)
          .font(.regular(16))
          .frame(maxWidth: .infinity, minHeight: 128)
          .background(Color.accentDark)
          .cornerRadius(16)
          .padding(.horizontal, 16)
          .foregroundColor(.white)
        
        Text("Party Topics")
          .foregroundColor(.white)
          .font(.regular(24))
          .padding(.top, 24)
        
        GeometryReader { geo in
          ZStack(alignment: .topLeading, content: {
            ForEach(viewModel.topics) { topic in
              Text(topic.title)
                .padding(.horizontal)
                .foregroundColor(topic.isSelected ? .dark : .orangeLight)
                .font(.regular(14))
                .background(!topic.isSelected ? Color.dark : Color.orangeLight)
                .clipShape(Capsule())
                .overlay(
                  Capsule()
                    .stroke(Color.orangeLight, lineWidth: 1)
                )
                .alignmentGuide(.leading) { dimension in
                  if (abs(width - dimension.width) > geo.size.width) {
                    width = 0
                    height -= dimension.height
                  }
                  let result = width
                  if topic.id == viewModel.topics.last!.id {
                    width = 0
                  } else {
                    width -= dimension.width
                  }
                  return result
                }
                .alignmentGuide(.top) { dimension in
                  let result = height
                  if topic.id == viewModel.topics.last!.id {
                    height = 0
                  }
                  return result
                }
                .padding(7)
            }
          })
        }.padding()
        
        Spacer()
        
        NavigationLink {
          MainView()
        } label: {
          Text("Save")
            .padding(.horizontal)
            .font(.regular(16))
            .foregroundColor(.dark)
            .frame(maxWidth: .infinity, maxHeight: 56,
                   alignment: .center)
            .background(Color.orangeLight)
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .shadow(color: .orangeLight,
                    radius: 10,
                    x: 0, y: 0)
        }
      }
    }.onAppear {
      viewModel.getTopics()
    }
    .navigationBarHidden(true)
  }
}
