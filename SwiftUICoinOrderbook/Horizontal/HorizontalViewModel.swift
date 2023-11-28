//
//  HorizontalViewModel.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/27/23.
//

import SwiftUI

class HorizontalViewModel: ObservableObject {
    
    @Published var value = 0.0
    @Published var dummy: [HorizontalData] = []
    
    @Published var askOrderBook: [OrderBookItem] = []
    @Published var bidOrderBook: [OrderBookItem] = []
    
    let market: Market
    init(market: Market) {
        self.market = market
    }
    
    func fetchAllMarket() {
        let url = URL(string: "https://api.upbit.com/v1/orderbook?markets=\(market.market)")!
        print("ss")
        URLSession.shared.dataTask(with: url) { data, resoonse, error in
            
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([OrderBookModel].self, from: data)
                print(decodedData)
                DispatchQueue.main.async {
                    let result = decodedData.first?.orderbook_units ?? [OrderBookUnit(ask_price: 0, bid_price: 0, ask_size: 0, bid_size: 0)]
                    let ask = result.map {
                        OrderBookItem(price: $0.ask_price, size: $0.ask_size)
                    }.sorted(by: { $0.price > $1.price })
                    
                    let bid = result.map {
                        OrderBookItem(price: $0.bid_price, size: $0.bid_size)
                    }.sorted(by: { $0.price > $1.price })
                    self.askOrderBook = ask
                    self.bidOrderBook = bid
                    
                }
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
    func largestAskSize() -> Double {
        return askOrderBook.sorted(by: {$0.size > $1.size }).first!.size
    }
    
    func largestBidSize() -> Double {
        return bidOrderBook.sorted(by: {$0.size > $1.size }).first!.size
    }
    
    func timer() {
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { timer in
            self.value += 1.5
            //self.fetchDummyData()
            self.fetchAllMarket()
            print("dd")
            // DunmmyData 달라지도록 구성
        }
    }
    
    func fetchDummyData() {
        
        dummy = [
            HorizontalData(data: "사과"),
            HorizontalData(data: "바나나"),
            HorizontalData(data: "파인애플"),
            HorizontalData(data: "복숭아"),
            HorizontalData(data: "수박"),
            HorizontalData(data: "딸기"),
            HorizontalData(data: "메론"),
            HorizontalData(data: "귤")
            
            
        ]

        
    }
    func largest() -> Int {
        let data = dummy.sorted(by: {$0.point > $1.point})
        return data.first!.point
    }
    
    
}
