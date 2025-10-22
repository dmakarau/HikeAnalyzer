//
//  RiskSummaryView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 22.10.25.
//

import SwiftUI

struct RiskSummaryView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(Risk.allCases) { factor in
                    RiskCardView(riskLevel: factor)
                    
                }
            }
            .navigationTitle("Risk Summary")
            .trailTheme()
        }
    }
}

#Preview {
    RiskSummaryView()
}
