//
//  ListView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/21/23.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel = ListViewModel()
    
    var body: some View {
        
        LazyVStack {
            Button("서버 통신") {
                print("==================")
                
                viewModel.fetchAllMarket()
            }
            ForEach(viewModel.market, id: \.self) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.koreanName)
                            .bold()
                        Text(item.englishName)
                            .foregroundStyle(Color.gray)
                            .font(.caption)
                    }
                    Spacer()
                    Text(item.market)
                        .bold()
                    
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }
        }
        .onAppear {
            
        }
        
        
    }
    
    
}

#Preview {
    ListView()
}
