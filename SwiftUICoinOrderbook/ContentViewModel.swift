//
//  ContentViewModel.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/21/23.
//

import Foundation

final class ContentViewModel: ObservableObject {
    
    @Published var banner = Banner()
    @Published var market: [Market] = []
    
    func fetchBanner() {
        banner.total = Int.random(in: 1000...5000) * 150
    }
    
    func fetchAllMarket() {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) { data, resoonse, error in
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                DispatchQueue.main.async {
                    self.market = decodedData
                }
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
}
