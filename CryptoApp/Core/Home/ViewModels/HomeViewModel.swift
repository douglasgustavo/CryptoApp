//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    // Função que adiciona allCoins como subscriber de dataService.$allCoins (que é uma variável @Published)
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] returnedCoins in
                // Associa o valor de returnedCoins a variável  allCoins
                self?.allCoins = returnedCoins
            }
            // Cancela a execução.
            .store(in: &cancellables)
    }
}
