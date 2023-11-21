//
//  ContentView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var banner = "23,456,789,234원"
    @State private var money: [Money] = []
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(1..<5) { data in
                                bannerView()
                                    .containerRelativeFrame(.horizontal)
                            }
                            
                        }
                        // 스크롤 하고자 하는 대상에 대한 레이아웃 설정
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.visible)
                    .scrollTargetBehavior(.viewAligned)
//                    .safeAreaPadding([.horizontal], 40)
                    LazyVStack {
                        ForEach(money, id: \.id) { data in
                            listView(data: data)
                            
                        }
                        
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            .refreshable { // 당겨서 새로고침 (iOS15~)
                banner = "987,456,732원"
                money = dummy.shuffled()
            }
            .onAppear {
                money = dummy.shuffled()
            }
            .navigationTitle("My Wallet")
        }
    }
    
    func bannerView() -> some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .bottomLeading, endPoint: .trailing)
              )
                .overlay {
                    Circle()
                        .fill(.white.opacity(0.2))
                        .offset(x: -40, y: 80)
                        .scaleEffect(1.8, anchor: .center)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
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
            .visualEffect { content, geometryProxy in
                content.offset(x: scrollOffset(geometryProxy))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 10)
            
        }
        .padding()
    }
    
    // GeometryProxy: 컨테이너 뷰에 대한 좌표나 크기에 접근할 수 있음
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let result = proxy.bounds(of: .scrollView)?.minX ?? 0
        return -result
    }
    
    // 값 전달을 할 때는 property보다 function을 사용하는 것이 더 좋음
    func listView(data: Money) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(data.product)
                    .bold()
                Text(data.category.rawValue)
                    .font(.subheadline)
            }
            Spacer()
            Text(data.amountFormat)
                .bold()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
        
    }
}

#Preview {
    ContentView()
}
