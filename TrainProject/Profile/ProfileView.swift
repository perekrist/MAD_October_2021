//
//  ProfileView.swift
//  TrainProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import SwiftUI
import SwiftUIX

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
  
  var formatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM YYYY - hh:mm"
    return dateFormatter
  }
  @State var date: Date = Date()
  @State var isPresented: Bool = false
  @State var name: String = ""
  @State var about: String = ""
  
  var body: some View {
    var width = CGFloat.zero
    var height = CGFloat.zero
    ZStack {
      Color.dark.edgesIgnoringSafeArea(.all)
      ScrollView(.vertical) {
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
        
        VStack {
          Text("Party Topics")
            .foregroundColor(.white)
            .font(.regular(24))
          
          GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
              ForEach(viewModel.topics) { topic in
                Text(topic.title)
                  .padding(.horizontal, 8)
                  .foregroundColor(topic.isSelected ? .dark : .orangeLight)
                  .font(.regular(14))
                  .background(!topic.isSelected ? Color.dark : Color.orangeLight)
                  .clipShape(Capsule())
                  .overlay(
                    Capsule()
                      .stroke(Color.orangeLight, lineWidth: 1)
                  )
                  .padding(.top, 7)
                  .padding(.trailing, 9)
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
                  .onTapGesture {
                    if let index = viewModel.topics.firstIndex(where: { $0.id == topic.id }) {
                      viewModel.topics[index].isSelected.toggle()
                    }
                  }
              }
            })
          }
          .padding(.top, -30)
        }.padding()
        
        VStack {
          Text("Party Date")
            .foregroundColor(.white)
            .font(.regular(24))
          
          HStack {
            Text(isPresented ? "\(formatter.string(from: date))" : "Select Date and Time")
              .foregroundColor(.orangeLight)
              .font(.regular(24))
              .underline()
              .onTapGesture {
                isPresented.toggle()
              }
            Spacer()
          }.padding(.horizontal, 16)
            .padding(.top, -20)
          
          if isPresented {
            DatePicker("", selection: $date)
              .datePickerStyle(CompactDatePickerStyle())
              .accentColor(.orangeLight)
              .padding()
          }
          
        }.padding(.top, 120)
        
        NavigationLink {
          TabBar()
        } label: {
          Text("Save")
            .padding(.horizontal)
            .font(.regular(16))
            .foregroundColor(.dark)
            .frame(maxWidth: .infinity, minHeight: 56,
                   alignment: .center)
            .background(Color.orangeLight)
            .cornerRadius(16)
            .padding(.horizontal, 16)
            .shadow(color: .orangeLight,
                    radius: 10,
                    x: 0, y: 0)
        }.padding(.top, 36)
      }
    }.onAppear {
      viewModel.getTopics()
    }
    .navigationBarHidden(true)
  }
}

extension View {
  @ViewBuilder func applyTextColor(_ color: Color) -> some View {
    if UITraitCollection.current.userInterfaceStyle == .light {
      self.colorInvert().colorMultiply(color)
    } else {
      self.colorMultiply(color)
    }
  }
}
