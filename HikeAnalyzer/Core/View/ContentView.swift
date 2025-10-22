//
//  ContentView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 21.10.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Enter the data about your upcoming hike ")
                    .font(.subheadline.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                
                HikeInfoView()
                
                NavigationLink {
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
