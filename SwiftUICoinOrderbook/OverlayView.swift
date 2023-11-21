//
//  OverlayView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/21/23.
//

import SwiftUI

struct OverlayView: View {
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(.yellow)
                    .frame(width: 150, height: 150)
                Text("안녕하세요 반갑습니다아아아")
            }
            Circle()
                .fill(.yellow)
                .frame(width: 150, height: 150)
                .overlay {
                    Text("안녕하세요 반갑습니다아아아")
                }
                
        }
    }
}

#Preview {
    OverlayView()
}
