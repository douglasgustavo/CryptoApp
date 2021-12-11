//
//  DoubleExtension.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import Foundation

extension Double {
    
    /// Converte um Double em um tipo Currency com 2 a 6 digitos
    /// ```
    /// Converte 1234.56 para "R$ 1.234,56"
    /// Converte 12.3456 para "R$ 1.234,56"
    /// Converte 0.123456 para "R$ 0,123456"
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        
        // Altera o tipo de moeda
        formatter.locale = .current // <- Valor padrão
        formatter.currencyCode = "brl" // <- Muda moeda
        formatter.currencySymbol = "R$ " // <- Muda simbolo moeda
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        
        return formatter
    }
    
    /// Converte um Double em um tipo Currency com 2 a 6 digitos
    /// ```
    /// Converte 1234.56 para "R$ 1.234,56"
    /// Converte 12.3456 para "R$ 1.234,56"
    /// Converte 0.123456 para "R$ 0,123456"
    /// ```
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "R$ 0,00"
    }
    
    /// Converte um Double em um tipo Currency com 0 a 2 digitos
    /// ```
    /// Converte 1234.56 para "R$ 1,234"
    /// Converte 12.3456 para "R$ 12,345"
    /// Converte 0.123456 para "R$ 0,123"
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        
        // Altera o tipo de moeda
        formatter.locale = .current // <- Valor padrão
        formatter.currencyCode = "brl" // <- Muda moeda
        formatter.currencySymbol = "R$ " // <- Muda simbolo moeda
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
    
    /// Converte um Double em um tipo Currency com 0 a 2 digitos
    /// ```
    /// Converte 1234.56 para "R$ 1,234"
    /// Converte 12.3456 para "R$ 12,345"
    /// Converte 0.123456 para "R$ 0,123"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "R$ 0,00"
    }
    
    /// Converte um Double em uma representação de String
    /// ```
    /// Converte 1.2345 para "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converte um Double em uma representação de String com símbolo de porcentagem
    /// ```
    /// Converte 1.2345 para "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }

    /// Converte um Double em uma representação de String com abreviacao
    /// ```
    /// Converte 12 para "12.00"
    /// Converte 1234 para "1.23 K"
    /// Converte 123456 para "123.45 K"
    /// Converte 12345678 para "12.34 M"
    /// Converte 1234567890 para "1.23 Bi"
    /// Converte 123456789012 para "123.45 Bi"
    /// Converte 12345678901234 para "12.34 Tr"
    /// ```
    func formattedWithAbbreviations() -> String {
        let num = abs(Double(self))
        let sign = (self < 0) ? "-" : ""
        
        switch num {
        case 1_000_000_000_000...:
            let formatted = num / 1_000_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted) Tr"
        case 1_000_000_000...:
            let formatted = num / 1_000_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted) Bi"
        case 1_000_000...:
            let formatted = num / 1_000_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted) M"
        case 1_000...:
            let formatted = num / 1_000
            let stringFormatted = formatted.asNumberString()
            return "\(sign)\(stringFormatted) K"
        case 0:
            return self.asNumberString()
        default:
            return "\(self)\(self)"
        }
    }
    
}
