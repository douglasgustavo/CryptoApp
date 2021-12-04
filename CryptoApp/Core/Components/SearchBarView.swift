//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Douglas Santos on 04/12/21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? .theme.secondaryText : .theme.accent
                )
            
            TextField("Procurar moeda...", text: $searchText)
                .disableAutocorrection(true)
                .foregroundColor(.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            self.searchText = ""
                        }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: .theme.accent.opacity(0.20), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .configurePreview(colorScheme: .light, previewLayout: .sizeThatFits)
            
            SearchBarView(searchText: .constant(""))
                .configurePreview(colorScheme: .dark, previewLayout: .sizeThatFits)
        }
    }
}
