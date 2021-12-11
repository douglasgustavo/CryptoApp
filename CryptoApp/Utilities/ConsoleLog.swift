//
//  ErrorPrint.swift
//  CryptoApp
//
//  Created by Douglas Santos on 04/12/21.
//

import Foundation

/** Classe que contém métodos estáticos para realizar log do aplicativo no console.

 1. Funções:

 - `printAppStart`: Função que imprime o início da execução do app
 - `printConsoleError`: Função estática utilizada para imprimir no console erros.
 - `printConsoleSuccess`: Função estática utilizada para imprimir no console informações.
 - `printConsoleInfo`: Função estática utilizada para imprimir no console informações.
 - `printConsoleAlert`: Função estática utilizada para imprimir no console alertas.
 */
class ConsoleLog {
    /**
     Função estática utilizada para imprimir o início da execução do aplicativo.
     */
    static func printAppStart() {
        switch DEBUG_MODE {
        case .completo:
            print("💬 Iniciada a execução do aplciativo em \(getCurrentTime(details: .complete))".uppercased())
            print("💬 Debug Completo Ativo".uppercased())
        case .errosEAlertas:
            print("💬 Iniciada a execução do aplciativo em \(getCurrentTime(details: .complete))".uppercased())
            print("💬 Debug Erros e Alertas Ativo".uppercased())
            print(" ")
        case .somenteErros:
            print("💬 Iniciada a execução do aplciativo em \(getCurrentTime(details: .complete))".uppercased())
            print("💬 Debug Somente Erros Ativo".uppercased())
            print(" ")
        }
    }
    
    /**
     Função estática utilizada para imprimir no console erros.
     
     - Parameter mensagem: Recebe uma String para informar a localização do erro;
     - Parameter fileID: Recebe o nome de #fileID.
     - Parameter function: Recebe o nome de #function.
     - Parameter erro: Recebe o erro gerado.
     */
    static func printConsoleError(mensagem: String, fileID: String? = nil, function: String? = nil, erro: Error? = nil) {
        print(" ")
        print("\(getCurrentTime(details: .short)) 🔴 OCORREU UM ERRO! 🔴".uppercased())
        if let fileID = fileID {
            print("\(getCurrentTime(details: .short)) 🔴 ARQV ERROR: \(fileID)")
        }
        if let function = function {
            print("\(getCurrentTime(details: .short)) 🔴 FUNC ERROR: \(function)")
        }
        
        print("\(getCurrentTime(details: .short)) 🔴 MSGN ERROR: \(mensagem)")
        if let error = erro {
            print("\(getCurrentTime(details: .short)) 🔴 DESC ERROR: \(error.localizedDescription)")
        }
        print(" ")
    }
    
    /**
     Função estática utilizada para imprimir no console informações.
     
     - Parameter message: Recebe a mensagem a ser imprimida.
     */
    static func printConsoleSuccess(message: String) {
        if DEBUG_MODE == .completo {
            print("\(getCurrentTime(details: .short)) 🟢 SUCS: \(message)")
        }
    }
    
    /**
     Função estática utilizada para imprimir no console informações.
     
     - Parameter message: Recebe a mensagem a ser imprimida.
     */
    static func printConsoleInfo(message: String) {
        if DEBUG_MODE == .completo {
            print("\(getCurrentTime(details: .short)) 🔵 INFO: \(message)")
        }
    }
    
    /**
     Função estática utilizada para imprimir no console alertas.
     
     - Parameter message: Recebe a mensagem do alerta a ser imprimida.
     - Parameter fileID: Recebe o nome de #fileID.
     - Parameter function: Recebe o nome de #function.
     */
    static func printConsoleAlert(message: String, fileID: String? = nil, function: String? = nil) {
        print("\(getCurrentTime(details: .short)) 🟡 ALRT: \(message)")
        if let fileID = fileID {
            print("\(getCurrentTime(details: .short)) 🟡 ARQV ALERTA: \(fileID)")
        }
        if let function = function {
            print("\(getCurrentTime(details: .short)) 🟡 FUNC ALERTA: \(function)")
        }
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

enum TipoDebug {
    case completo, somenteErros, errosEAlertas
}
