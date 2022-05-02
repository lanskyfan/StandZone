/*
 This code was adapted from Apple Developer Sample
 https://developer.apple.com/documentation/healthkit/creating_a_mobility_health_app
 (Source: https://docs-assets.developer.apple.com/published/ae09943a8b/CreatingAMobilityHealthApp.zip retrieved in April 2022)
*/

import Foundation
import HealthKit

// MARK: - Data Type Strings

/// Return a readable name for a HealthKit data type identifier.
func getDataTypeName(for identifier: String) -> String? {
    var description: String?
    let sampleType = getSampleType(for: identifier)
    
    if sampleType is HKQuantityType {
        let quantityTypeIdentifier = HKQuantityTypeIdentifier(rawValue: identifier)
        
        switch quantityTypeIdentifier {
        case .stepCount:
            description = "Step Count"
        case .distanceWalkingRunning:
            description = "Distance Walking + Running"
        case .sixMinuteWalkTestDistance:
            description = "Six-Minute Walk"
        default:
            break
        }
    }
    
    return description
}

// MARK: - Formatted Value Strings

/// Return a formatted readable value suitable for display for a health data value based on its type. Example: "10,000 steps"
func formattedValue(_ value: Double, typeIdentifier: String) -> String? {
    guard
        let unit = preferredUnit(for: typeIdentifier),
        let roundedValue = getRoundedValue(for: value, with: unit),
        let unitSuffix = getUnitSuffix(for: unit)
    else {
        return nil
    }
    
    let formattedString = String.localizedStringWithFormat("%@ %@", roundedValue, unitSuffix)
    
    return formattedString
}

private func getRoundedValue(for value: Double, with unit: HKUnit) -> String? {
    let numberFormatter = NumberFormatter()
    
    numberFormatter.numberStyle = .decimal
    
    switch unit {
    case .count(), .meter():
        let numberValue = NSNumber(value: round(value))
        
        return numberFormatter.string(from: numberValue)
    default:
        return nil
    }
}

// MARK: - Unit Strings

func getUnitDescription(for unit: HKUnit) -> String? {
    switch unit {
    case .count():
        return "steps"
    case .meter():
        return "meters"
    default:
        return nil
    }
}

private func getUnitSuffix(for unit: HKUnit) -> String? {
    switch unit {
    case .count():
        return "steps"
    case .meter():
        return "m"
    default:
        return nil
    }
}
