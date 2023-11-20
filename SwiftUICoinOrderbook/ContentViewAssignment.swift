//
//  ContentViewAssignment.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/20/23.
//

import SwiftUI

struct ContentViewAssignment: View {
    
    @State private var banner = Banner()
    @State private var data = dummy
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                bannerView()
                LazyVStack {
                    ForEach(data, id: \.id) { item in
                        listView(data: item)
                    }
                    
                }
            }
            .refreshable { // 당겨서 새로고침 (iOS15~)
                data = dummy.shuffled()
                banner = Banner()
            }
            .navigationTitle("My Wallet")
        }
    }
    
    func bannerView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(banner.color)
                .frame(maxWidth: .infinity)
            .frame(height: 200)
            
            VStack(alignment: .leading) {
                Spacer()
                Text("나의 소비내역")
                    .font(.title3)
                Text(banner.totalFormat)
                    .bold()
                    .font(.title)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
        }
        .padding()
    }
    
    // 값 전달을 할 때는 property보다 function을 사용하는 것이 더 좋음
    func listView(data: Money) -> some View {
        
        HStack {
            VStack(alignment: .leading) {
                
                Text("\(data.product)")
                    .fontWeight(.semibold)
                Text("\(data.category.rawValue)")
            
            }
            Spacer()
            Text(data.amountFormat)
                .bold()
                .font(.title3)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        
    }
}

#Preview {
    ContentViewAssignment()
}
