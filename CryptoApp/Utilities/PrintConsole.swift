//
//  ErrorPrint.swift
//  CryptoApp
//
//  Created by Douglas Santos on 04/12/21.
//

import Foundation

class PrintConsole {
    /**
     Função estática utilizada para imprimir o início da execução do aplicativo.
     
     */
    static func printAppStart() {
        print("⚪️⚪️⚪️ Iniciada a execução do aplciativo em \(getCurrentTime(details: .complete)) ⚪️⚪️⚪️".uppercased())
    }
    
    /**
     Função estática utilizada para imprimir no console erros.
     
     - Parameter mensagem: Recebe uma String para informar a localização do erro;
     - Parameter erro: Recebe o erro gerado.
     */
    static func printConsoleError(mensagem: String, erro: Error?) {
        print("\(getCurrentTime(details: .short)) 🔴🔴🔴 MSGN ERRO: \(mensagem)")
        if let error = erro {
            print("\(getCurrentTime(details: .short)) 🔴🔴🔴 DESC ERRO: \(error.localizedDescription)")
        }
    }
    
    /**
     Função estática utilizada para imprimir no console informações.
     
     - Parameter message: Recebe a mensagem a ser imprimida.
     */
    static func printConsoleSuccess(message: String) {
        print("\(getCurrentTime(details: .short)) 🟢🟢🟢 SUCESSO: \(message)")
    }
    
    /**
     Função estática utilizada para imprimir no console informações.
     
     - Parameter message: Recebe a mensagem a ser imprimida.
     */
    static func printConsoleInfo(message: String) {
        print("\(getCurrentTime(details: .short)) 🔵🔵🔵 INFORMAÇÃO: \(message)")
    }
    
    /**
     Função estática utilizada para imprimir no console alertas.
     
     - Parameter message: Recebe a mensagem do alerta a ser imprimida.
     */
    static func printConsoleAlert(message: String) {
        print("\(getCurrentTime(details: .short)) 🟡🟡🟡 ALERTA: \(message)")
    }
    
    /**
     Função para retornar o a hora atual como String
     - Parameters details: Define se deseja a detalhado (ex.: 00/00/0000 00:00:00.0000 0000000000000.000) ou simplificado (ex.: 00/00/00 00:00:00.0000)
     */
    private static func getCurrentTime(details: QtdNanoseconds) -> String {
        let d = Date()
        let df = DateFormatter()
        
        switch details {
        case .short:
            df.dateFormat = "dd/MM/yy HH:mm:ss.SSSS"
            return df.string(from: d)
        case .complete:
            df.dateFormat = "dd/MM/yyyy HH:mm:ss"
            return df.string(from: d) + " \(Date().timeIntervalSince1970 * 1000)"
        }
    }
}

enum QtdNanoseconds {
    case short, complete
}
