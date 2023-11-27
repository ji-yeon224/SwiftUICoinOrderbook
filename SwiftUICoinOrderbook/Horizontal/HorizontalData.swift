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
    let point = Int.random(in: 10...3000)
    
}

let horizontalDummy = [
    HorizontalData(data: "사과"),
    HorizontalData(data: "바나나"),
    HorizontalData(data: "파인애플"),
    HorizontalData(data: "복숭아"),
    HorizontalData(data: "수박"),
    HorizontalData(data: "딸기"),
    HorizontalData(data: "메론"),
    HorizontalData(data: "귤")
    
    
]

func largest() -> Int {
    let data = horizontalDummy.sorted(by: {$0.point > $1.point})
    return data.first!.point
}
