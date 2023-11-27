//
//  MyWebView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/27/23.
//

import SwiftUI
import WebKit
// SwiftUI 프로젝트에 UIKit 객체들을 활용하는 방법 => UIViewRepresentable

struct MyWebView: UIViewRepresentable {
    
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    // 데이터가 변경됨에 따라 뷰를 변경하고 싶다면 사용
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
}

