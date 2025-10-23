//
//  TrailTheme.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 21.10.25.
//

import SwiftUI

struct TrailTheme: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .background {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.theme.backgroundPrimary,
                        Color.theme.backgroundSecondary
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea(.all)
            }
    }
}

extension View {
    func trailTheme() -> some View {
        modifier(TrailTheme())
    }
    
    func cardStyle() -> some View {
        self
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.theme.cardBackground)
                    .shadow(
                        color: Color.theme.shadowColor,
                        radius: 8,
                        x: 0,
                        y: 4
                    )
            )
    }
    
    func primaryButtonStyle() -> some View {
        self
            .font(.headline)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.theme.primary,
                        Color.theme.primaryDark
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(
                color: Color.theme.primary.opacity(0.3),
                radius: 8,
                x: 0,
                y: 4
            )
    }
}

// MARK: - Modern Color System
extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    // Primary Colors
    let primary = Color(red: 0.2, green: 0.7, blue: 0.9)
    let primaryDark = Color(red: 0.1, green: 0.5, blue: 0.8)
    let secondary = Color(red: 0.95, green: 0.7, blue: 0.3)
    let accent = Color(red: 0.3, green: 0.8, blue: 0.4)
    
    // Background Colors
    let backgroundPrimary = Color(red: 0.97, green: 0.98, blue: 1.0)
    let backgroundSecondary = Color(red: 0.92, green: 0.96, blue: 0.99)
    let cardBackground = Color.white
    
    // Text Colors
    let textPrimary = Color(red: 0.1, green: 0.1, blue: 0.1)
    let textSecondary = Color(red: 0.4, green: 0.4, blue: 0.4)
    let textTertiary = Color(red: 0.6, green: 0.6, blue: 0.6)
    
    // Risk Colors
    let riskHigh = Color(red: 0.9, green: 0.2, blue: 0.2)
    let riskDifficult = Color(red: 0.9, green: 0.5, blue: 0.1)
    let riskModerate = Color(red: 0.9, green: 0.8, blue: 0.1)
    let riskEasy = Color(red: 0.2, green: 0.8, blue: 0.3)
    
    // Utility Colors
    let shadowColor = Color.black.opacity(0.1)
    let separatorColor = Color.gray.opacity(0.2)
}

// MARK: - Typography System
extension Font {
    static let theme = FontTheme()
}

struct FontTheme {
    let largeTitle = Font.system(size: 34, weight: .bold, design: .rounded)
    let title = Font.system(size: 28, weight: .bold, design: .rounded)
    let title2 = Font.system(size: 22, weight: .semibold, design: .rounded)
    let headline = Font.system(size: 17, weight: .semibold, design: .rounded)
    let body = Font.system(size: 17, weight: .regular, design: .default)
    let callout = Font.system(size: 16, weight: .regular, design: .default)
    let subheadline = Font.system(size: 15, weight: .medium, design: .default)
    let footnote = Font.system(size: 13, weight: .regular, design: .default)
    let caption = Font.system(size: 12, weight: .regular, design: .default)
}

// MARK: - Spacing System
extension CGFloat {
    struct Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 40
    }
    
    static let spacing = Spacing.self
}
