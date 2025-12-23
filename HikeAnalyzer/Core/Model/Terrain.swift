//
//  Terrain.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 20.06.25.
//

import Foundation

enum Terrain: String , Identifiable, CaseIterable {
    case paved
    case dirt
    case rocky
    case sandy
    
    var id: String { rawValue }
    
    var description: String {
        switch self {
        case .paved:
            return "Paved"
        case .dirt:
            return "Dirt Trail"
        case .rocky:
            return "Rocky Terrain"
        case .sandy:
            return "Sandy Path"
        }
    }
}
