//
//  ListViewModel.swift
//  SwiftUICoinOrderbook
//
//  Created by 김지연 on 11/21/23.
//

import Foundation

final class ListViewModel: ObservableObject {
    
    @Published var market: [Market] = [Market(market: "a", koreanName: "d", englishName: "j")]
    
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
