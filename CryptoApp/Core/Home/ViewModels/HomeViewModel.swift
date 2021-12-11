//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    /// Até 6 itens!
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Carregando", value: ""),
        StatisticModel(title: "Carregando", value: ""),
        StatisticModel(title: "Carregando", value: "")
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var isLoaded: Bool = false
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    // Função que adiciona allCoins como subscriber de dataService.$allCoins (que é uma variável @Published)
    func addSubscribers() {
        // Atualiza allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
        // Aguarda 0.5 segundos antes de executar o .map
        //  .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
        // Faz o map seguindo o texto digitado pelo usuário
            .map(filterCoins)
        // Atribui o retorno do .map à variável publicada returnedCoins
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
        // Faz o cancelamento da chamada
            .store(in: &cancellables)
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = []
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    // Função privada que realiza o filtro seguindo o texto fornecido retornando um Array de CoinModel
    private func filterCoins(text: String, startingCoins: [CoinModel]) -> [CoinModel] {
        // Se o campo de texto estiver vazio, retorna todas as moedas
        guard !text.isEmpty else {
            return startingCoins
        }
        
        // Obtem o texto digitado convertendo para minúsculo
        let lowercasedText = text.lowercased()
        
        // Seta como true
        self.isLoaded = true
        
        // Faz o filtro utilizando o texto digitado verificando se existe no nome, simbolo ou id
        return startingCoins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
    // Função privada para mapear a API e retornar em um array de StatisticModel contendo as informações necessárias para as estatísticas
    private func mapGlobalMarketData(data: MarketDataModel?) -> [StatisticModel] {
        // Inicialização do array vazio
        var stats: [StatisticModel] = []
        
        // Tenta obter informações de marketDataModel, se não retorna array vazio
        guard let data = data else {
            return stats
        }
        
        // Constantes com as estatísticas desejas
        let marketCap = StatisticModel(title: "Valor Mercado", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "Volume 24h", value: data.volume)
        let btcDominance = StatisticModel(title: "Dominância BTC", value: data.btcDominance)
        let portfolio = StatisticModel(title: "Valor Carteira", value: "R$ 0,00", percentageChange: 0)
        
        // Adicionando as constantes ao array
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        // Retornando array
        return stats
    }
}
