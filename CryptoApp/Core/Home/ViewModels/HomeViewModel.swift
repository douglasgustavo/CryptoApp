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
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    // Função que adiciona allCoins como subscriber de dataService.$allCoins (que é uma variável @Published)
    func addSubscribers() {
        // Atualiza allCoins
        $searchText
            .combineLatest(dataService.$allCoins)
            .map { (text, startingCoins) -> [CoinModel] in
                // Se o campo de texto estiver vazio, retorna todas as moedas
                guard !text.isEmpty else {
                    return startingCoins
                }
                
                // Obtem o texto digitado convertendo para minúsculo
                let lowercasedText = text.lowercased()
                
                // Faz o filtro utilizando o texto digitado verificando se existe no nome, simbolo ou id
                return startingCoins.filter { coin in
                    return coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText) ||
                    coin.id.lowercased().contains(lowercasedText)
                }
            }
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
            
    }
}
