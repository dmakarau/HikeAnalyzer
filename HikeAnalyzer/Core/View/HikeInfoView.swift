//
//  HikeInfoView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 21.10.25.
//

import SwiftUI

struct HikeInfoView: View {
    @State private var distance: String = ""
    @State private var elevationChange: String = ""
    @State private var terrain: Terrain = .dirt
    @State private var willifeDanger: WildlifeDanger = .low
    var body: some View {
        VStack {
            HikeInputView(iconName: "figure.hiking", label: "Distance") {
                TextField("Kilometers", text: $distance)
                    .multilineTextAlignment(.trailing)
            }
            HikeInputView(iconName: "mountain.2.fill", label: "Elevation Change") {
                TextField("Meters", text: $elevationChange)
                    .multilineTextAlignment(.trailing)
            }
            HikeInputView(iconName: "shoe.fill", label: "Terrain") {
                Picker("Terrain", selection: $terrain) {
                    ForEach(Terrain.allCases) { terrain in
                        Text(terrain.rawValue.capitalized).tag(terrain)
                    }
                }
                .tint(.primary)
                .background(RoundedRectangle(cornerRadius: 12)                .fill(Color(.systemGray6)))
                
            }
            HikeInputView(iconName: "exclamationmark.triangle.fill", label: "Danger") {
                Picker("Danger", selection: $willifeDanger) {
                    ForEach(WildlifeDanger.allCases) { danger in
                        Text(danger.rawValue.capitalized).tag(danger)
                    }
                }
                .frame(width: 140)
                .pickerStyle(.segmented)
            }
        }
        
        
    }
}

#Preview {
    HikeInfoView()
}
