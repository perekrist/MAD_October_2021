//
//  WidgetProject.swift
//  WidgetProject
//
//  Created by Кристина Перегудова on 31.10.2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), hoursLeft: 0)
  }
  
  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), hoursLeft: 0)
    completion(entry)
  }
  
  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []
    
    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
    let currentDate = Date()
    for hourOffset in 0 ..< 24 {
      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
      let entry = SimpleEntry(date: entryDate, hoursLeft: Bool.random() ? 0 : ((1..<5).randomElement() ?? 1))
      entries.append(entry)
    }
    
    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let hoursLeft: Int
}

struct WidgetProjectEntryView : View {
  var entry: Provider.Entry
  @Environment(\.widgetFamily) var widgetFamily
  
  var body: some View {
    switch widgetFamily {
    case .systemSmall:
      ZStack {
        LinearGradient(colors: [.dark, .accentDark],
                       startPoint: .top, endPoint: .bottom)
        if entry.hoursLeft > 0 {
          VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading) {
              Image("logo")
                .resizable()
                .frame(width: 107, height: 107)
              Text("Before the Party")
                .foregroundColor(.white.opacity(0.7))
                .font(.regular(12))
                .padding(.bottom, -5)
            }
            Text("\(entry.hoursLeft) hours")
              .foregroundColor(.white)
              .font(.regular(24))
              .padding(.top, -10)
          }
        } else {
          VStack(alignment: .center) {
              Image("jack")
                .resizable()
                .frame(width: 100, height: 100)
            Text("No Party No Gain")
              .foregroundColor(.white.opacity(0.7))
              .font(.regular(12))
          }
        }
      }
    case .systemExtraLarge:
      Text(entry.date, style: .time)
    case .systemMedium:
      Text(entry.date, style: .time)
    case .systemLarge:
      Text(entry.date, style: .time)
    @unknown default:
      Text(entry.date, style: .time)
    }
  }
}

@main
struct WidgetProject: Widget {
  let kind: String = "WidgetProject"
  
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: Provider()) { entry in
      WidgetProjectEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
  }
}
