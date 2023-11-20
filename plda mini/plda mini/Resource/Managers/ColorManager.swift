//
//  ColorManager.swift
//  plda mini
//
//  Created by 최유경 on 11/15/23.
//

import Foundation
import SwiftUI

extension Color {
    //Green
    static let darkGreen = Color(hex: "427A5B")
    static let lightGreen = Color(hex: "9BCD93")
    //Gray
    static let gray80 = Color(hex: "666666")
    static let gray60 = Color(hex: "999999")
    static let gray40 = Color(hex: "CCCCCC")
    static let gray20 = Color(hex: "DEDEDE")
    static let gray10 = Color(hex: "#F3F3F3")
    static let gray0 = Color(hex: "FDFDFD")

    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
