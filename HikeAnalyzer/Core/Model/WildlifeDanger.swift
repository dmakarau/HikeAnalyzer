//
//  WildlifeDanger.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 22.10.25.
//

import Foundation

enum WildlifeDanger: String, Identifiable, CaseIterable {
    case low
    case high
    
    var id: String { rawValue }
}
