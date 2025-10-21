//
//  HikeInputView.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 21.10.25.
//

import SwiftUI

struct HikeInputView<Content: View>: View {
    let iconName: String
    let label: String
    @ViewBuilder var content: Content
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.tint)
                .frame(width: 32, height: 32)
                .padding(.trailing, 8)
            
            Text(label)
            
            Spacer()
            
            content
            
           
        }
        .padding(.vertical, 24)
        .padding(.horizontal)
        .background(.white, in: RoundedRectangle(cornerRadius: 12))    }
}

#Preview {
    HikeInputView(iconName: "figure.hiking", label: "Distance") {
       Text("Content goes here...")
    }
}
