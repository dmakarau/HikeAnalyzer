//
//  RiskCardView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 22.10.25.
//

import SwiftUI

struct RiskCardView: View {
    let riskLevel: Risk
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(riskLevel.image)
                    .foregroundColor(.red)
                    .font(.title2)
                Text(riskLevel.rawValue)
                    .font(.title2)
            }
            Text(riskLevel.description)
        }
        .padding()
        .background(.white, in: RoundedRectangle(cornerRadius: 12))
            
    }
}

#Preview {
    RiskCardView(riskLevel: .easy)
}
