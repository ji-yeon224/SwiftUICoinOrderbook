//
//  ContentView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var banner = "23,456,789,234원"
    var body: some View {
        
        NavigationStack {
            ScrollView {
                bannerView()
                LazyVStack {
                    ForEach(1..<50) { data in
                        listView(data: data)
                        
                    }
                    
                }
            }
            .refreshable { // 당겨서 새로고침 (iOS15~)
                banner = "987,456,732원"
            }
            .navigationTitle("My Wallet")
        }
    }
    
    func bannerView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.brown)
                .frame(maxWidth: .infinity)
            .frame(height: 200)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                    .font(.title3)
                Text(banner)
                    .bold()
                    .font(.title)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
        }
        .padding()
    }
    
    // 값 전달을 할 때는 property보다 function을 사용하는 것이 더 좋음
    func listView(data: Int) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("비트코인 \(data)")
                Text("Bitcoin \(data)")
            }
            Spacer()
            Text("KRW-BTC")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        
    }
}

#Preview {
    ContentView()
}
