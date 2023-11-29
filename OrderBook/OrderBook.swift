//
//  OrderBook.swift
//  OrderBook
//
//  Created by 김지연 on 11/29/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    // 위젯 킷이 최초로 렌더링할 때 사용 > 스켈레톤 뷰로 렌더링
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }
    
    // 위젯 갤러리 미리보기 화면
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    // 위젯 상태 변경 시점
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        // 타임라인 마지막 날짜가 지난 뒤, 위젯킷이 새로운 타임라인을 요청할 수 있도록 설정
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct OrderBookEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("시간:")
            Text(entry.date, style: .time)

            Text("Emoji:")
            Text(entry.emoji)
        }
    }
}

struct OrderBook: Widget {
    let kind: String = "OrderBook"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                OrderBookEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                OrderBookEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("보유 코인")
        .description("실시간 시세를 확인하세요.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

#Preview(as: .systemSmall) {
    OrderBook()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
