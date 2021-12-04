//
//  WaftersView.swift
//  
//
//  Created by MacBook Pro on 2021/12/04.
//

import SwiftUI

// MARK: - Bar
public struct BarView: View {
    var value: CGFloat
    var maxValue: CGFloat = 120
    var color = Color(.sRGB, red: 0.2, green: 0.5, blue: 0.8)
    
    public var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: maxValue)
                    .foregroundColor(.secondary.opacity(0.2))
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: value)
                    .foregroundColor(color)
            }
        }
    }
}

// MARK: - Color extension
public extension Color {
    static let iris = Color(.sRGB, red: 0.6, green: 0.5, blue: 0.8)
    static let peacockGreen = Color(.sRGB, red: 0.2, green: 0.6, blue: 0.7)
}
