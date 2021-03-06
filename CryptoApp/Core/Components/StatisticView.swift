//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Douglas Santos on 11/12/21.
//

import SwiftUI

/// Componente para mostrar estatísticas na HomeView
struct StatisticView: View {
    
    let stat: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundColor(.theme.accent)
            
            HStack(spacing: 4) {
                if (stat.percentageChange ?? 0) != 0 {
                    if (stat.percentageChange ?? 0) >= 0 {
                        Image(systemName: "arrow.up.forward")
                            .font(.caption2)
                    } else {
                        Image(systemName: "arrow.down.left")
                            .font(.caption2)
                    }
                } else {
                    Image(systemName: "minus")
                        .font(.caption)
                }
                
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                .bold()
            }
            // Muda a cor verificando se porcentagem é 0, positiva ou negativa
            .foregroundColor((stat.percentageChange ?? 0) == 0 ? .yellow : (stat.percentageChange ?? 0) >= 0 ? .theme.green : .theme.red)
            // Muda a opacidade de a porcentagem é nil, mantendo todos os elementos alinhados
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Porcentagem positiva
            StatisticView(stat: dev.stat1)
                .configurePreview(colorScheme: .light, previewLayout: .sizeThatFits)
            StatisticView(stat: dev.stat1)
                .configurePreview(colorScheme: .dark, previewLayout: .sizeThatFits)
            
            // Porcentagem negativa
            StatisticView(stat: dev.stat2)
                .configurePreview(colorScheme: .light, previewLayout: .sizeThatFits)
            StatisticView(stat: dev.stat2)
                .configurePreview(colorScheme: .dark, previewLayout: .sizeThatFits)
            
            // Porcentagem zerada
            StatisticView(stat: dev.stat3)
                .configurePreview(colorScheme: .light, previewLayout: .sizeThatFits)
            StatisticView(stat: dev.stat3)
                .configurePreview(colorScheme: .dark, previewLayout: .sizeThatFits)
            
            // Sem porcentagem
            StatisticView(stat: dev.stat4)
                .configurePreview(colorScheme: .light, previewLayout: .sizeThatFits)
            StatisticView(stat: dev.stat4)
                .configurePreview(colorScheme: .dark, previewLayout: .sizeThatFits)
        }
        .padding()
    }
}
