//
//  WidgetTapView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/30/23.
//

import SwiftUI

struct WidgetTapView: View {
    
    @State private var selectedTab = "book"
    
    var body: some View {
        TabView {
            Button("1111", action: {
                selectedTab = "star"
            })
                .tabItem { Image(systemName: "book") }
                .tag("book")
            Text("2")
                .tabItem { Image(systemName: "star") }
                .tag("star")
            Text("3")
                .tabItem { Image(systemName: "pencil") }
                .tag("pencil")
        }
        .onOpenURL {
            switch $0.absoluteString {
                case "History": selectedTab = "book"
                case "Favorite": selectedTab = "star"
                default: selectedTab = "pencil"
            }
        }
    }
}

#Preview {
    WidgetTapView()
}
