//
//  Terrain.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 22.10.25.
//

import Foundation

enum Terrain: String , Identifiable, CaseIterable {
    case paved
    case dirt
    case rocky
    case sandy
    
    var id: String { rawValue }
}
