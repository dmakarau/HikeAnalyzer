//
//  TrailInfo.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import Foundation

struct TrailInfo {
    var distance: Int?
    var elevation: Int?
    var terrain: Terrain = .dirt
    var willifeDanger: WildlifeDanger = .low
}
