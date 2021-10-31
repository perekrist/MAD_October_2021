//
//  ProfileView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI
import SwiftUIX

struct Topic {
  let id: String = UUID().uuidString
  let name: String
  var isSelected: Bool = Bool.random()
}

struct ProfileView: View {
  var formatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM YYYY - hh:mm"
    return dateFormatter
  }
  @State var date: Date = Date()
  @State var isPresented: Bool = false
  @State var name: String = ""
  @State var about: String = ""
  @State var topics: [Topic] = [Topic(name: "Pumpkins"),
                                Topic(name: "Marvel Heroes"),
                                Topic(name: "Ghosts")]
  
  var body: some View {
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
        
        LazyHGrid(rows: [GridItem(.flexible(minimum: 0, maximum: 400),
                                  spacing: 9,
                                  alignment: .leading)]) {
          ForEach(topics, id: \.id) { topic in
            Text(topic.name)
              .foregroundColor(topic.isSelected ? .dark : .orangeLight)
              .font(.regular(14))
              .background(!topic.isSelected ? Color.dark : Color.orangeLight)
              .clipShape(Capsule())
//              .onTapGesture {
//                let index = topics.firstIndex(of: $0.id == topic.id)
//                topics[index].isSelected.toggle()
//              }
            
          }
        }
        
        Text("Party Date")
          .foregroundColor(.white)
          .font(.regular(24))
          .padding(.top, 24)
        
        HStack {
          Text(isPresented ? "\(formatter.string(from: Date()))" : "Select Date and Time")
            .foregroundColor(.orangeLight)
            .font(.regular(24))
            .underline()
            .onTapGesture {
              isPresented.toggle()
            }
          Spacer()
        }.padding(.horizontal, 16)
          .padding(.top, 8)
        
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
    }.navigationBarHidden(true)

  }
}
