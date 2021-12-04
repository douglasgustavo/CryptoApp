//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Douglas Santos on 04/12/21.
//

import SwiftUI

/// Classe utilizada para gerenciar o armazenamento do aplicativo no aparleho do usuário.
class LocalFileManager {
    
    // Variável estática para criar uma instância Singleton da classe
    static let instance = LocalFileManager()
    
    private init() { }
    
    /**
     Função para salvar imagem no armazenamento interno do dispositivo
     
     - Parameter image: Recebe a UIImage;
     - Parameter imageName: Recebe o nome da imagem a ser salva;
     - Parameter folderName: Recebe o nome da pasta em que será salva a imagem.
     */
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        // Função que cria a pasta se não existir
        createFolderIfNeeded(folderName: folderName)
        
        // Validação das variáveis
        guard
            // Obtém as informações da imagem com formato .png
            let data = image.pngData(),
            // Obtém a URL para salvar a imagem
            let url = getURLForImage(imagemName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            PrintConsole.printConsoleError(mensagem: "Erro ao salvar imagem \(imageName)", erro: error)
        }
        
    }
    
    /**
     Função que obtem a imagem do armazenamento do aparelho do usuário retornando UIImage?
     
     - Parameter imageName: Nome da imagem a ser buscada,
     - Parameter folderName: Nome da pasta que a imagem está armazenada
    */
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            // Obtem a URL da imagem
            let url = getURLForImage(imagemName: imageName, folderName: folderName),
            // Verifica se a imagem existe no armazenamento
            FileManager.default.fileExists(atPath: url.path)
        else { return nil }
        
        // Retorna a imagem no formato UIImage
        return UIImage(contentsOfFile: url.path)
    }
    
    /// Função que cria a pasta no sistema se não existir.
    private func createFolderIfNeeded(folderName: String) {
        // Obtem o URL da pasta
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        //  Se o arquivo não existir
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                // Cria o diretório
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                // Erro
                PrintConsole.printConsoleError(mensagem: "Erro ao criar pasta \(folderName)", erro: error)
            }
        }
    }
    
    /// Função que obtém a URL da pasta
    private func getURLForFolder(folderName: String) -> URL? {
        // Criando a URL da pasta a ser obtida
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(folderName)
    }
    
    /// Função que obtém a URL da imagem
    private func getURLForImage(imagemName: String, folderName: String) -> URL? {
        // Criando a URL da imagem a ser obtida
        guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
        // Retorna a URL com a extensão .png no final
        return folderURL.appendingPathComponent(imagemName + ".png")
    }
    
}
