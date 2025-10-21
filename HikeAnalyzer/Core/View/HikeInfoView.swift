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
                TextField("Kilometers", text: $distance)
                    .multilineTextAlignment(.trailing)
            }
            HikeInputView(iconName: "exclamationmark.triangle.fill", label: "Terrain") {
                TextField("Kilometers", text: $distance)
                    .multilineTextAlignment(.trailing)
            }
            
        }
    }
}

#Preview {
    HikeInfoView()
}
