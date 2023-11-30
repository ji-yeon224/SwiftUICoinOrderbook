//
//  WidgetTabView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/30/23.
//

import SwiftUI

struct WidgetTapView: View {
    
    @State private var selectedTab = "book"
    var body: some View {
        TabView(selection: $selectedTab) {
            Button("1111", action: {
                selectedTab = "star"
                print("tap")
            }).tabItem { Image(systemName: "book") }
                .tag("book")
            Text("2")
                .tabItem { Image(systemName: "star") }
                .tag("star")
            Text("3")
                .tabItem { Image(systemName: "pencil") }
                .tag("pencil")
        }
        .onOpenURL(perform: { url in
            switch url.absoluteString {
                case "History": selectedTab = "book"
                case "Favorite": selectedTab = "star"
                default: selectedTab = "pencil"
            }
        })
    }
}

#Preview {
    WidgetTapView()
}
