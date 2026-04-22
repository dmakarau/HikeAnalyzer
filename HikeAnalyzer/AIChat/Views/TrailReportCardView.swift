import SwiftUI

struct TrailReportCardView: View {
    let report: TrailAnalysisReportData

    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.md) {
            riskHeader

            if !report.topHazards.isEmpty {
                Divider()
                ReportSection(title: "Hazards", systemImage: "exclamationmark.triangle.fill", tint: Color.theme.riskDifficult) {
                    ForEach(Array(report.topHazards.enumerated()), id: \.offset) { _, hazard in
                        HazardRow(hazard: hazard)
                    }
                }
            }

            if !report.gearItems.isEmpty {
                Divider()
                ReportSection(title: "Gear Checklist", systemImage: "backpack.fill", tint: Color.theme.primary) {
                    ForEach(Array(report.gearItems.enumerated()), id: \.offset) { _, item in
                        GearRow(item: item)
                    }
                }
            }

            if !report.safetySteps.isEmpty {
                Divider()
                ReportSection(title: "Safety Steps", systemImage: "shield.checkered", tint: Color.theme.accent) {
                    ForEach(Array(report.safetySteps.enumerated()), id: \.offset) { index, step in
                        SafetyStepRow(index: index + 1, step: step)
                    }
                }
            }
        }
        .padding(.spacing.md)
        .background(Color.theme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.theme.shadowColor, radius: 8, x: 0, y: 2)
        .frame(maxWidth: 300)
    }

    private var riskHeader: some View {
        VStack(alignment: .leading, spacing: .spacing.sm) {
            HStack(spacing: .spacing.sm) {
                Image(systemName: "mountain.2.fill")
                    .foregroundStyle(riskColor)
                    .font(.theme.headline)

                Text("Trail Analysis")
                    .font(.theme.headline)
                    .foregroundStyle(Color.theme.textPrimary)

                Spacer()

                RiskBadge(level: report.riskLevel, color: riskColor)
            }

            Text(report.explanation)
                .font(.theme.subheadline)
                .foregroundStyle(Color.theme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var riskColor: Color {
        switch report.riskLevel.lowercased() {
        case "easy":     return Color.theme.riskEasy
        case "moderate": return Color.theme.riskModerate
        case "difficult": return Color.theme.riskDifficult
        default:         return Color.theme.riskHigh
        }
    }
}

// MARK: - Subviews

private struct RiskBadge: View {
    let level: String
    let color: Color

    var body: some View {
        Text(level.capitalized)
            .font(.theme.caption)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, .spacing.sm)
            .padding(.vertical, 4)
            .background(color)
            .clipShape(Capsule())
    }
}

private struct ReportSection<Content: View>: View {
    let title: String
    let systemImage: String
    let tint: Color
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: .spacing.sm) {
            HStack(spacing: .spacing.xs) {
                Image(systemName: systemImage)
                    .font(.subheadline)
                    .foregroundStyle(tint)
                Text(title)
                    .font(.theme.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.textPrimary)
            }
            content()
        }
    }
}

private struct HazardRow: View {
    let hazard: TrailHazardData

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(hazard.name)
                .font(.theme.footnote)
                .fontWeight(.medium)
                .foregroundStyle(Color.theme.textPrimary)
            Text(hazard.detail)
                .font(.theme.caption)
                .foregroundStyle(Color.theme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.leading, .spacing.sm)
    }
}

private struct GearRow: View {
    let item: GearItemData

    var body: some View {
        HStack(alignment: .top, spacing: .spacing.sm) {
            Image(systemName: "checkmark.circle.fill")
                .font(.caption)
                .foregroundStyle(Color.theme.primary)
                .padding(.top, 1)
            VStack(alignment: .leading, spacing: 2) {
                Text(item.name)
                    .font(.theme.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.textPrimary)
                Text(item.reason)
                    .font(.theme.caption)
                    .foregroundStyle(Color.theme.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

private struct SafetyStepRow: View {
    let index: Int
    let step: SafetyStepData

    var body: some View {
        HStack(alignment: .top, spacing: .spacing.sm) {
            Text("\(index)")
                .font(.theme.caption)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(width: 20, height: 20)
                .background(Color.theme.accent)
                .clipShape(Circle())
            Text(step.action)
                .font(.theme.footnote)
                .foregroundStyle(Color.theme.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    let report = TrailAnalysisReportData(
        riskLevel: "difficult",
        explanation: "This 12km rocky trail with 900m elevation gain presents significant challenges due to technical terrain and limited water sources.",
        topHazards: [
            TrailHazardData(name: "Loose rocks", detail: "Rocky terrain increases ankle twist risk on descents."),
            TrailHazardData(name: "Sun exposure", detail: "Open ridgeline sections have no shade above 800m.")
        ],
        gearItems: [
            GearItemData(name: "Trekking poles", reason: "Essential for stability on steep rocky descents."),
            GearItemData(name: "3L water capacity", reason: "No water sources above 600m on this route.")
        ],
        safetySteps: [
            SafetyStepData(action: "Start before 7am to avoid afternoon heat on the exposed ridge."),
            SafetyStepData(action: "File a trip plan with a contact before departing.")
        ]
    )
    TrailReportCardView(report: report)
        .padding()
}
