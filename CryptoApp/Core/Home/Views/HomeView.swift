//
//  HomeView.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false // Anima para direita
    @State private var showPortfolioView: Bool = false // Nova aba
    
    var body: some View {
        ZStack {
            // Camada de background
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                        .environmentObject(vm)
                })
            
            // Camada de conteúdo
            VStack{
                homeHeader
                
                HomeStatsView(showPortfolio: $showPortfolio)
                
                SearchBarView(searchText: $vm.searchText)
                
                columnTitles
                
                // Se showPortifolio == false então mostra View
                if !showPortfolio {
                    allCoinList
                    // MARK: Animação
                        .transition(.move(edge: .leading))
                }
                
                // Se showPortifolio == true então mostra View
                if showPortfolio {
                    portfolioCoinList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeVM)
    }
}

extension HomeView {
    // Header da View
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Carteira" : "Valores Agora")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    // Lista com todas as moedas
    private var allCoinList: some View {
        List {
            if vm.allCoins.count > 0 {
                ForEach(vm.allCoins) { coin in
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            } else {
                loadingMessage
            }
        }
        .listStyle(PlainListStyle())
    }
    
    // Lista com todas as moedas da carteira
    private var portfolioCoinList: some View {
        List {
            if vm.portfolioCoins.count > 0 {
                ForEach(vm.portfolioCoins) { coin in
                    CoinRowView(coin: coin, showHoldingsColumn: true)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            } else {
                loadingMessage
            }
        }
        .listStyle(PlainListStyle())
    }
    
    // Títulos das colúnas
    private var columnTitles: some View {
        HStack {
            Text("Moeda")
                .padding(.leading)
            Spacer()
            if showPortfolio {
                Text("Carteira / Qtd.")
            }
            
            Text("Preço")
                .frame(width: UIScreen.main.bounds.width / 3.5)
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }
    
    // Se isLoaded == false então apresenta mensagem de carregando se não houver nenhuma moeda sendo exibida.
    private var loadingMessage: some View {
        HStack{
            Spacer()
            if !self.vm.isLoaded {
                Text("Carregando...")
                    .font(.caption)
                    .foregroundColor(.theme.secondaryText)
                    .frame(minWidth: 30)
            } else {
                if !showPortfolio {
                    Text("Nenhuma Moeda Localizada")
                        .font(.caption)
                        .foregroundColor(.theme.secondaryText)
                        .frame(minWidth: 30)
                } else {
                    Text("Nada por aqui...")
                        .font(.caption)
                        .foregroundColor(.theme.secondaryText)
                        .frame(minWidth: 30)
                }
            }
            
            Spacer()
        }
    }
}
