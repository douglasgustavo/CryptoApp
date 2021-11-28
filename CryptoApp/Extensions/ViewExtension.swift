//
//  ViewExtension.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import SwiftUI

extension View {
    /**
     Extensão para configurar preview com título customizado ou pré definido.
        - Parameter title: Título do preview (opcional)
        - Parameter colorScheme: .dark ou .light
        - Parameter previewLayout: .sizeThatFits, .device ou fixed()
     */
    func configurePreview(title: String? = nil, colorScheme: ColorScheme, previewLayout: PreviewLayout) -> some View {
        
        var titleModel: String {
            if colorScheme == .light {
                return "Light Mode"
            } else {
                return "Dark Mode"
            }
        }
        
        if let titleValidated = title {
            return self
                .previewDisplayName(titleValidated)
                .preferredColorScheme(colorScheme)
                .previewLayout(previewLayout)
        } else {
            return self
                .previewDisplayName(titleModel)
                .preferredColorScheme(colorScheme)
                .previewLayout(previewLayout)
        }
    }
}
