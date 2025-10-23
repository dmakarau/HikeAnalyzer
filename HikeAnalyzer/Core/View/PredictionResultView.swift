//
//  HikeAnalyzer
//
//  Created by Denis Makarau on 22.10.25.
//

import SwiftUI

struct PredictionResultView: View {
    @State private var showInfo: Bool = false
    let risk: Risk
    var body: some View {
        VStack {
            RiskCardView(riskLevel: risk)
            Spacer()
        }
        .navigationTitle("Result")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showInfo) {
            RiskSummaryView()
        }
        .trailTheme()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showInfo.toggle()
                
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PredictionResultView(risk: .difficult)
    }
}
