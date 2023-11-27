//
//  WalletDetailView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/22/23.
//

import SwiftUI

struct WalletDetailView: View {
    
    @Binding var showDetail: Bool // 화면 dismiss (overlay false)
    
    let currentWallet: WalletModel // WalletView에서 선택한 카드 정보
    
    var animation: Namespace.ID // 동일한 그룹입을 인식
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(currentWallet.color)
                    .frame(height: 150)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        showDetail = false
                    }
                    .matchedGeometryEffect(id: currentWallet, in: animation)
                Text(currentWallet.name)
                Spacer()
            }
            
            
        }
    }
}

//#Preview {
//    WalletDetailView(showDetail: .constant(true), currentWallet: <#T##WalletModel#>)
//}
