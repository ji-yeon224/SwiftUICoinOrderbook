//
//  EntryView.swift
//  OrderBookExtension
//
//  Created by 김지연 on 11/30/23.
//

import WidgetKit
import SwiftUI

struct OrderBookEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.test)
            Text(entry.date, style: .time)
//            Text(entry.token)
            Text(UserDefaults.groupShared.string(forKey: "Market") ?? "잭코인")
            Text(entry.price.formatted())
        }
    }
}
