//
//  ContentView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ContentViewModel()
    @State var renderingTestNumber = 0
    
    
//    @State private var banner = "23,456,789,234원"
//    @State private var market: [Market] = []
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                Text("테스트: \(renderingTestNumber)")
                NavigationLink("배너테스트", value: renderingTestNumber)
                VStack {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(1..<5) { data in
                                bannerView()
                                    .containerRelativeFrame(.horizontal)
                                    .onTapGesture {
                                        viewModel.fetchBanner() 
                                    }
                            }
                            
                        }
                        // 스크롤 하고자 하는 대상에 대한 레이아웃 설정
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.visible)
                    .scrollTargetBehavior(.viewAligned)
//                    .safeAreaPadding([.horizontal], 40)
                    
                    ListView() // 하위뷰
                    
                }
                
            }
            .scrollIndicators(.hidden)
            .refreshable { // 당겨서 새로고침 (iOS15~)
                //viewModel.fetchBanner()
                renderingTestNumber = Int.random(in: 1...100)
            }
            .navigationTitle("My Wallet")
            .navigationDestination(for: Int.self) { _ in
                BannerTestView(testNumber: $renderingTestNumber)
            }
        }
        
        
    }
    
    func bannerView() -> some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [viewModel.banner.color, Color.blue]), startPoint: .bottomLeading, endPoint: .trailing)
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
                Text(viewModel.banner.totalFormat)
                    .bold()
                    .font(.title)
            }
            .padding(.leading, 15)
//            .visualEffect { content, geometryProxy in
//                content.offset(x: scrollOffset(geometryProxy))
//            }
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
    
    
}

#Preview {
    ContentView()
}
