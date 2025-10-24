//
//  Risk.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 18.06.25.
//

import Foundation

enum Risk: String, Identifiable, CaseIterable {
    case highRisk = "HighRisk"
    case difficult = "Difficult"
    case moderate = "Moderate"
    case easy = "Easy"
    
    var id: String { rawValue }
    
    var image: String {
        rawValue
    }
    
    var description: String {
        switch self {
        case .highRisk:
            return "This hike presents significant challenges and potential dangers. It is recommended only for experienced hikers with proper equipment."
        case .difficult:
            return "This hike is challenging and requires a good level of fitness and experience. Hikers should be prepared for steep inclines and rough terrain."
        case .moderate:
            return "This hike is suitable for hikers with some experience. It may include some steep sections and uneven terrain, but is generally manageable."
        case .easy:
            return "This hike is suitable for all skill levels, including beginners. The terrain is generally flat and well-maintained."
        }
    }
}
