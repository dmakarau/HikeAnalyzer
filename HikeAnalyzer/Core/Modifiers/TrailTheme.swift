//
//  TrailTheme.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 21.10.25.
//

import SwiftUI

struct TrailTheme: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            VStack {
                Image(.background3)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                
                Spacer()
            }
            
            content
                .padding(.horizontal)
        }
        .background(Color(white: 0.94))
    }
}

extension View {
    func trailTheme() -> some View {
        modifier(TrailTheme())
    }
}
