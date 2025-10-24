//
//  TrailInfo.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 25.06.25.
//

import Foundation

struct TrailInfo: Equatable {
    var distance: Int?
    var elevation: Int?
    var terrain: Terrain = .dirt
    var willifeDanger: WildlifeDanger = .low
}
