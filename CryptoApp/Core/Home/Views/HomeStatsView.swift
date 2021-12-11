//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Douglas Santos on 11/12/21.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: getRect().width / 3)
            }
        }
        // Movimenta a View conforme status de showPortfolio, para esquerda ou direita
        .frame(width: getRect().width,
               alignment: showPortfolio ? .trailing : .leading
        )
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeVM)
    }
}
