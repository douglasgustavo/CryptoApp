//
//  UIApplicationExtension.swift
//  CryptoApp
//
//  Created by Douglas Santos on 04/12/21.
//

import SwiftUI

extension UIApplication {
    /// Função para fechar o teclado quando acionada.
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
