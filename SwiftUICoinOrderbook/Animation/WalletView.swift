//
//  WalletView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/22/23.
//

import SwiftUI

struct WalletView: View {
    
    @State private var isExpandable = false
    @State private var showDetail = false
    
    let wallet = walletList // wallet model list
    
    // 사용자가 탭한 카드가 무엇인지 알기 위함
    @State private var currentWallet = WalletModel(name: "", index: 0)
    
    @Namespace var animation
    
    var body: some View {
        VStack {
            topTitle()
            cardSpace()
            Button("AnimationOn") {
                print("on")
                withAnimation(.smooth) { // 타이틀 이동 애니메이션
                    isExpandable = false
                }
                
                
            }
            Button("AnimationOff") {
                print("off")
                withAnimation(.spring(duration: 0.5)) {
                    isExpandable = true
                }
            }
        }
        .overlay {
            if showDetail {
                WalletDetailView(
                    showDetail: $showDetail,
                    currentWallet: currentWallet,
                    animation: animation
                )
                
            }
        }
        
        
    }
    
    func cardSpace() -> some View {
        ScrollView {
            
            ForEach(wallet, id: \.self) { item in
                cardView(item)
            }
        }
        .overlay {
            Rectangle()
                .fill(.black.opacity(isExpandable ? 0 : 0.01))
                .onTapGesture {
                    withAnimation {
                        isExpandable = true
                    }
                } 
        }
    }
    
    func cardView(_ data: WalletModel) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(data.color)
            .frame(height: 150)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .offset(
                y: CGFloat(data.index) * (isExpandable ? 0 : -120)
            )
            .onTapGesture { 
                withAnimation(.spring(duration: 0.5)) {
                    // 카드 탭 시 다음 화면 전환
                    showDetail = true
                    currentWallet = data
                    
                }
            }
            .matchedGeometryEffect(id: data, in: animation)
            
    }
    
    func topTitle() -> some View {
        Text("My Wallet")
            .font(.largeTitle)
            .bold()
            
            .frame(
                maxWidth: .infinity,
                alignment: isExpandable ? .leading : .center
            )
            .overlay(alignment: .trailing) {
                topOverlayButton()
                    .padding()
            }
            .padding()
    }
    
    func topOverlayButton() -> some View {
        Button {
            withAnimation {
                withAnimation(.smooth) {
                    isExpandable = false
                }
            }
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding(10)
                .background(Color.black, in: Circle())
        }
        .rotationEffect(.degrees(isExpandable ? 225 : 45)) // 회전
        .opacity(isExpandable ? 1 : 0) // 사라졌다가 등장 투명도 조절
    }
    
}

#Preview {
    WalletView()
}
