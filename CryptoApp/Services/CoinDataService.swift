//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    // Função para obter as moedas
    private func getCoins() {
        ConsoleLog.printConsoleInfo(message: "CoinDataService.getCoins - Obtendo informações de moedas da API.")
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=brl&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
        
        // Atribuindo a um cancelável o retorno da função de request
        // Obtem as informações da URL
        coinSubscription = NetworkingManager.download(url: url)
        // Realiza a decodificação com JSONDecoder() informando o tipo array de CoinModel [CoinModel]
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
        // Se ocorrer algum erro, imprime no console o erro, se não, continua a execução
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  // Recebe o valor já decodificado e retorna para a variável @Published
                  receiveValue: { [weak self] returnedCoins in
                // Associa o valor a variável allCoins
                self?.allCoins = returnedCoins
                // Realiza o cancelamento da requisição após obter as informações com sucesso.
                self?.coinSubscription?.cancel()
                ConsoleLog.printConsoleSuccess(message: "CoinDataService.getCoins - Informações das moedas obtidas com sucesso!")
            })
    }
}
