//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Douglas Santos on 11/12/21.
//

import Foundation

/*
 Informações da API
 
 Documentação: https://www.coingecko.com/pt/api/documentation?
 URL [GET]: https://api.coingecko.com/api/v3/global
 
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    // Variáveis computadas:
    
    var marketCap: String {
        /* Forma de filtrar um valor com .first, filtrando a chave do array como brl e retornando o valor
        if let item = totalMarketCap.first(where: { key, value in
            return key == "brl"
        }) {
            return "\(item.value)"
        }
        */
        
        // Forma encurtada do if let acima
        if let item = totalMarketCap.first(where: {$0.key == "brl"}) {
            return "\(item.value)"
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: {$0.key == "brl"}) {
            return "\(item.value)"
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
}
