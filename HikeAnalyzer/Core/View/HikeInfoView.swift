//
//  HikeInfoView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 21.10.25.
//

import SwiftUI

struct HikeInfoView: View {
    @Binding var trailInfo: TrailInfo
    
    var body: some View {
        VStack {
            HikeInputView(iconName: "figure.hiking", label: "Distance") {
                TextField("Kilometers", value: $trailInfo.distance, format: .number)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
            }
            HikeInputView(iconName: "mountain.2.fill", label: "Elevation Change") {
                TextField("Meters", value: $trailInfo.elevation, format: .number)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)
            }
            HikeInputView(iconName: "shoe.fill", label: "Terrain") {
                Picker("Terrain", selection: $trailInfo.terrain) {
                    ForEach(Terrain.allCases) { terrain in
                        Text(terrain.rawValue.capitalized).tag(terrain)
                    }
                }
                .tint(.primary)
                .background(RoundedRectangle(cornerRadius: 12)                .fill(Color(.systemGray6)))
                
            }
            HikeInputView(iconName: "exclamationmark.triangle.fill", label: "Danger") {
                Picker("Danger", selection: $trailInfo.willifeDanger) {
                    ForEach(WildlifeDanger.allCases) { danger in
                        Text(danger.description.capitalized).tag(danger)
                    }
                }
                .frame(width: 140)
                .pickerStyle(.segmented)
            }
        }
        
        
    }
}

#Preview {
    @Previewable @State var trailInfo = TrailInfo()
    HikeInfoView(trailInfo: $trailInfo)
}
