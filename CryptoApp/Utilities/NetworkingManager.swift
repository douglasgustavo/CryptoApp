//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "Erro ao obter resposta da URL: \(url)"
            case .unknown: return "Um erro desconhecido aconteceu!"
            }
        }
    }
    
    // Função que realiza o request de uma URL utilizando Subscribers
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            // Realiza o subscribe na thread de background
            .subscribe(on: DispatchQueue.global(qos: .default))
            // Tenta obter o retorno
            .tryMap({ try handleURLResponse(output: $0, url: url) })
            // Recebe na thread principal
            .receive(on: DispatchQueue.main)
            // Define o retorno para o tipo AnyPublisher<Data, Error>
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        // Tenta obter o retorno, se a resposta HTTP estiver entre 200 e 300 (Sucesso HTTP), continua
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                  if let error = output.response as? HTTPURLResponse {
                      PrintConsole.printConsoleError(mensagem: "Erro HTTP \(error.statusCode) - Função: NetworkingManager.handleURLResponse", erro: nil)
                  }
                  throw NetworkingError.badURLResponse(url: url)
              }
        // Retorno do Data
        return output.data
    }
    
    // Função para validar o retorno sink de um subscriber
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
            // Caso finalizou com sucesso, para a execução deste trecho
        case .finished:
            break
            // Caso erro, imprime erro no console
        case .failure(let error):
            PrintConsole.printConsoleError(mensagem: "Erro ao validar retorno. - Função: NetworkingManager.handleCompletion", erro: error)
        }
    }
    
}
