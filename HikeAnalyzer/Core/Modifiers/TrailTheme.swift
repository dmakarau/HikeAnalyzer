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
            .padding(.horizontal)
            .background {
                Image(.background2)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                    .opacity(0.7)
            }
            .background(Color(white: 0.94))
    }
}

extension View {
    func trailTheme() -> some View {
        modifier(TrailTheme())
    }
}

extension Color {
    static var trailTheme: Color {
        Color(red: 0.2, green: 0.6, blue: 0.8, opacity: 0.9)
    }
}
