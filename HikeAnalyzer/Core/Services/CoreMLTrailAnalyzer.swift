//
//  CoreMLTrailAnalyzer.swift
//  HikeAnalyzer
//
//  Created by Denis Makarau on 23.10.25.
//

import CoreML
import Foundation

/// Shared service for Core ML trail risk prediction
struct CoreMLTrailAnalyzer {
    
    /// Predicts risk level using the Core ML model
    static func predictRisk(for trailInfo: TrailInfo) -> Risk {
        do {
            let model = try TrailAnalyzerModel(configuration: MLModelConfiguration())
            
            guard let distance = trailInfo.distance,
                  let elevation = trailInfo.elevation else { 
                return .highRisk 
            }
            
            let input = TrailAnalyzerModelInput(
                distance: Int64(distance),
                elevation: Int64(elevation),
                terrain: trailInfo.terrain.rawValue,
                dangerous: Int64(trailInfo.willifeDanger.rawValue)
            )
            
            let prediction = try model.prediction(input: input).risk
            
            return mapPredictionToRisk(prediction)
        } catch {
            print("Error loading Core ML model: \(error)")
            return .highRisk
        }
    }
    
    /// Maps numeric prediction to Risk enum
    private static func mapPredictionToRisk(_ prediction: Double) -> Risk {
        switch prediction {
        case 0 ..< 20: return .easy
        case 20 ..< 50: return .moderate
        case 50 ... 100: return .difficult
        default: return .highRisk
        }
    }
}