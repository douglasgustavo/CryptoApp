//
//  ColorExtension.swift
//  CryptoApp
//
//  Created by Douglas Santos on 28/11/21.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
    static let launch = LaunchColors()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct LaunchColors {
    let accent = Color("LaunchAccentColor")
    let launch = Color("LaunchBackgroundColor")
}
