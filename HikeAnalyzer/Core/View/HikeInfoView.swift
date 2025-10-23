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
        VStack(spacing: .spacing.sm) {
            HikeInputView(iconName: "figure.hiking", label: "Distance") {
                ModernTextField(
                    value: $trailInfo.distance,
                    placeholder: "km"
                )
            }
            
            HikeInputView(iconName: "mountain.2.fill", label: "Elevation Change") {
                ModernTextField(
                    value: $trailInfo.elevation,
                    placeholder: "m"
                )
            }
            
            HikeInputView(iconName: "shoe.fill", label: "Terrain Type") {
                ModernPicker(
                    selection: $trailInfo.terrain,
                    options: Terrain.allCases,
                    displayText: { $0.rawValue.capitalized }
                )
            }
            
            HikeInputView(iconName: "exclamationmark.triangle.fill", label: "Wildlife Danger") {
                ModernSegmentedPicker(
                    selection: $trailInfo.willifeDanger,
                    options: WildlifeDanger.allCases,
                    displayText: { $0.description.capitalized }
                )
            }
        }
    }
}

struct ModernTextField: View {
    @Binding var value: Int?
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, value: $value, format: .number)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.trailing)
            .font(.theme.callout)
            .foregroundColor(Color.theme.textPrimary)
            .padding(.horizontal, .spacing.sm)
            .padding(.vertical, .spacing.xs)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.backgroundPrimary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.theme.separatorColor, lineWidth: 1)
                    )
            )
    }
}

struct ModernPicker<T: Hashable & CaseIterable & Identifiable>: View {
    @Binding var selection: T
    let options: [T]
    let displayText: (T) -> String
    
    var body: some View {
        Menu {
            ForEach(options, id: \.id) { option in
                Button(displayText(option)) {
                    selection = option
                }
            }
        } label: {
            HStack(spacing: .spacing.xs) {
                Text(displayText(selection))
                    .font(.theme.callout)
                    .foregroundColor(Color.theme.textPrimary)
                
                Image(systemName: "chevron.down")
                    .font(.caption2)
                    .foregroundColor(Color.theme.textSecondary)
            }
            .padding(.horizontal, .spacing.sm)
            .padding(.vertical, .spacing.xs)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.theme.backgroundPrimary)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.theme.separatorColor, lineWidth: 1)
                    )
            )
        }
    }
}

struct ModernSegmentedPicker<T: Hashable & CaseIterable & Identifiable>: View {
    @Binding var selection: T
    let options: [T]
    let displayText: (T) -> String
    
    var body: some View {
        VStack(spacing: .spacing.xs) {
            Picker("Selection", selection: $selection) {
                ForEach(options, id: \.id) { option in
                    Text(displayText(option))
                        .font(.theme.footnote)
                        .tag(option)
                }
            }
            .pickerStyle(.segmented)
            .background(Color.theme.backgroundPrimary)
            .cornerRadius(8)
        }
    }
}

#Preview {
    @Previewable @State var trailInfo = TrailInfo()
    ScrollView {
        HikeInfoView(trailInfo: $trailInfo)
            .padding()
    }
    .trailTheme()
}

#Preview {
    @Previewable @State var trailInfo = TrailInfo()
    HikeInfoView(trailInfo: $trailInfo)
}
