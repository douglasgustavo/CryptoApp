//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import SwiftUI

/// Botão circular recebendo uma string contendo um ícone SF.
struct CircleButtonView: View {
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.theme.background)
            )
            .shadow(color: .theme.accent.opacity(0.25),
                    radius: 10, x: 0, y: 0)
            .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircleButtonView(iconName: "info")
                .configurePreview(colorScheme: .light, previewLayout: .sizeThatFits)
            
            CircleButtonView(iconName: "plus")
                .configurePreview(colorScheme: .dark, previewLayout: .sizeThatFits)
        }
        
    }
}
