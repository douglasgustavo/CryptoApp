//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            Spacer()
            if showHoldingsColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .configurePreview(colorScheme: .light, previewLayout: .sizeThatFits)
            
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .configurePreview(colorScheme: .dark, previewLayout: .sizeThatFits)
        }
    }
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack (alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack (alignment: .trailing){
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundColor(.theme.accent)
                .lineLimit(1)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "0.0%")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? .theme.green : .theme.red
                )
                .lineLimit(1)
            
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
