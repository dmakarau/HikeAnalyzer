//
//  WildlifeDanger.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 22.10.25.
//

import Foundation

enum WildlifeDanger: Int, Identifiable, CaseIterable {
    case low
    case high
    
    var description: String {
        switch self {
        case .low: return "Low Wildlife Risk"
        case .high: return "High Wildlife Risk"
        }
    }
    
    var id: Int { rawValue }
}
