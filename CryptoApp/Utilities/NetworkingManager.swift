//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import Foundation
import Combine

class NetworkingManager {
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            // Realiza o subscribe na thread de background
            .subscribe(on: DispatchQueue.global(qos: .default))
            // Tenta obter o retorno, se a resposta HTTP estiver entre 200 e 300 (Sucesso HTTP), continua
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                          throw URLError(.badServerResponse)
                      }
                // Retorno do Data
                return output.data
            }
            // Recebe na thread principal
            .receive(on: DispatchQueue.main)
            // Define o retorno para o tipo AnyPublisher<Data, Error>
            .eraseToAnyPublisher()
    }
    
    
    
}
