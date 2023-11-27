//
//  SeSACView.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/27/23.
//

import SwiftUI

struct SeSACView: View {
    
    @State private var textfieldText = "SwiftUI text"
    @State private var uikitTextFieldText = "UIKit text"
    
    var body: some View {
        Text(textfieldText)
        TextField("SwiftUI 텍스트필드", text: $textfieldText)
        
        VStack {
            Text(uikitTextFieldText)
            MyTextField(text: $uikitTextFieldText)
        }
        .background(Color.brown)
        .padding()
        
        MyWebView(url: "https://www.apple.com")
    }
}

#Preview {
    SeSACView()
}
