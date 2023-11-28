//
//  HorizontalData.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/27/23.
//

import Foundation

struct HorizontalData: Identifiable {
    let id = UUID()
    let data: String
    let point = Int.random(in: 10...5000)
    
}


