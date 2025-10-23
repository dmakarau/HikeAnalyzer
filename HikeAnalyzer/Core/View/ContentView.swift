//
//  ContentView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 21.10.25.
//

import SwiftUI

struct ContentView: View {
    @State private var trailInfo  = TrailInfo()
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Enter the data about your upcoming hike ")
                    .font(.subheadline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                HikeInfoView(trailInfo: $trailInfo)
                
                NavigationLink {
                    let analyzer = TrailAnalyzer()
                    let risk = analyzer.predictRisk(trailInfo: trailInfo)
                    PredictionResultView(risk: risk)
                    Text("Results")
                } label: {
                    Text("Submit")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.tint, in: RoundedRectangle(cornerRadius: 12))
                        .foregroundColor(.white)
                }
            }
            .tint(.trailTheme)
            .navigationTitle("Trail Analyzer")
            .trailTheme()
        }
        
    }
}

#Preview {
    ContentView()
}
