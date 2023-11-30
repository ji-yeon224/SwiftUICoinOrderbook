//
//  HorizontalView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/27/23.
//

import SwiftUI
import WidgetKit

struct HorizontalView: View {
    
    @StateObject var viewmodel = HorizontalViewModel(market: Market(market: "krw-btc", koreanName: "비트코인", englishName: "Bitcoin"))
   
    
    
    var body: some View {
        ScrollView {
            Text("\(viewmodel.market.koreanName)")
                
            GeometryReader { proxy in
                
                let graphWidth = proxy.size.width * 0.7 // 차트 최대 너비
                
                VStack {
                    ForEach(viewmodel.askOrderBook, id: \.id) { item in
                        HStack {
                            Text(item.price.formatted())
                                .frame(width: proxy.size.width * 0.3)
                            ZStack(alignment: .leading) {
                                
                                let graphSize = CGFloat(item.size) / CGFloat(viewmodel.largestAskSize()) * graphWidth
                                
                                Rectangle()
                                    .foregroundStyle(Color.purple.opacity(0.4))
                                    .frame(maxWidth: graphSize, alignment: .leading)
                                    
                                Text(item.size.formatted())
                                    .frame(width: graphWidth)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.9))
                            
                            
                        }
                        .frame(height: 40)
                    }
                }
                .background(Color.blue.opacity(0.4))
                
                
                
            }
        }
        .onAppear {
            viewmodel.timer()
            // UserDefaults AppGroup
            
            UserDefaults.groupShared.set(viewmodel.market.koreanName, forKey: "Market")
            
            WidgetCenter.shared.reloadTimelines(ofKind: "OrderBook")
        }
        
    }
}

#Preview {
    HorizontalView()
}
