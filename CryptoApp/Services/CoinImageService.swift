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
    private let fileManager = LocalFileManager.instance
    private let folderName = "coinsImageStorage"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
        // Se ocorrer algum erro, imprime no console o erro, se não, continua a execução
            .sink(receiveCompletion: NetworkingManager.handleCompletion,
                  // Recebe o valor já decodificado e retorna para a variável @Published
                  receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImagem = returnedImage else { return }
                // Associa o valor a variável allCoins
                self.image = downloadedImagem
                // Realiza o cancelamento da requisição após obter as informações com sucesso.
                self.imageSubscription?.cancel()
                // Salva a imagem no armazenamento do aparelho do usuário.
                self.fileManager.saveImage(image: downloadedImagem, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
