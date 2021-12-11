//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Douglas Santos on 11/12/21.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    // Função para obter as moedas
    private func getData() {
        ConsoleLog.printConsoleInfo(message: "MarketDataService.getData - Obtendo informações globais da API.")
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        // Atribuindo a um cancelável o retorno da função de request
        // Obtem as informações da URL
        marketDataSubscription = NetworkingManager.download(url: url)
        // Realiza a decodificação com JSONDecoder() informando o tipo array de CoinModel [CoinModel]
            .decode(type: GlobalData.self, decoder: JSONDecoder())
        // Se ocorrer algum erro, imprime no console o erro, se não, continua a execução
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  // Recebe o valor já decodificado e retorna para a variável @Published
                  receiveValue: { [weak self] returnedGlobalData in
                // Associa o valor a variável allCoins
                self?.marketData = returnedGlobalData.data
                // Realiza o cancelamento da requisição após obter as informações com sucesso.
                self?.marketDataSubscription?.cancel()
                ConsoleLog.printConsoleSuccess(message: "MarketDataService.getData - Informações do mercado obtidas com sucesso!")
            })
    }
}
