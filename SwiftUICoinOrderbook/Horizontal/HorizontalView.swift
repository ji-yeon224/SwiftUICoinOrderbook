//
//  HorizontalView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/27/23.
//

import SwiftUI

struct HorizontalView: View {
    
    @StateObject var viewModel = HorizontalViewModel()
    
    var body: some View {
        ScrollView {
            Text("\(viewModel.value)")
            GeometryReader { proxy in
                
                let graphWidth = proxy.size.width
                
                VStack {
                    ForEach(horizontalDummy, id: \.id) { item in
                        HStack {
                            Text(item.data)
                                .frame(width: proxy.size.width * 0.2)
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .foregroundStyle(Color.purple.opacity(0.4))
                                    .frame(width: CGFloat(item.point) / 10)
                                    .frame(maxWidth: graphWidth * 0.7)
                                    
                                Text(item.point.formatted())
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            
                            
                        }
                        .frame(height: 40)
                    }
                }
                .background(Color.blue.opacity(0.4))
                .onTapGesture {
                    print(proxy)
                    print(proxy.size)
                    viewModel.timer() 
                }
            }
        }
        
    }
}

#Preview {
    HorizontalView()
}
