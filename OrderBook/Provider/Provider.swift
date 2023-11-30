//
//  Provider.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/30/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    typealias Entry = SimpleEntry
    
    // 위젯 킷이 최초로 렌더링할 때 사용 > 스켈레톤 뷰로 렌더링
    func placeholder(in context: Context) -> Entry {
        SimpleEntry(date: Date(), test: "Jack", token: "토큰", price: 1233456)
    }
    
    // 위젯 갤러리 미리보기 화면
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        let entry = SimpleEntry(date: Date(), test: "Hue", token: "비트코인", price: 4795960)
        completion(entry)
    }

    // 위젯 상태 변경 시점
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, test: "SeSAC", token: "이더리움", price: .random(in: 100...10000))
            entries.append(entry)
        }

        // 타임라인 마지막 날짜가 지난 뒤, 위젯킷이 새로운 타임라인을 요청할 수 있도록 설정
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}



