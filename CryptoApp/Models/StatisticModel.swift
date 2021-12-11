//
//  StatisticModel.swift
//  CryptoApp
//
//  Created by Douglas Santos on 11/12/21.
//

import SwiftUI

/// Model a ser utilizado para exibir estatísticas na HomeView
struct StatisticModel: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String) {
        self.title = title
        self.value = value
        self.percentageChange = nil
    }
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
