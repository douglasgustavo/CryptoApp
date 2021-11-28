//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    @Published var image: UIImage? = nil
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            // Se ocorrer algum erro, imprime no console o erro, se não, continua a execução
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
              // Recebe o valor já decodificado e retorna para a variável @Published
              receiveValue: { [weak self] returnedImage in
                // Associa o valor a variável allCoins
                self?.image = returnedImage
                // Realiza o cancelamento da requisição após obter as informações com sucesso.
                self?.imageSubscription?.cancel()
            })
    }
}
