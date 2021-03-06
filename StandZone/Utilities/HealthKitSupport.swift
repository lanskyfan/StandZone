/*
 This code was adapted from Apple Developer Sample
 https://developer.apple.com/documentation/healthkit/creating_a_mobility_health_app
 (Source: https://docs-assets.developer.apple.com/published/ae09943a8b/CreatingAMobilityHealthApp.zip retrieved in April 2022)
*/

import Foundation
import HealthKit

// MARK: Sample Type Identifier Support

/// Return an HKSampleType based on the input identifier that corresponds to an HKQuantityTypeIdentifier, HKCategoryTypeIdentifier
/// or other valid HealthKit identifier. Returns nil otherwise.
func getSampleType(for identifier: String) -> HKSampleType? {
    if let quantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier(rawValue: identifier)) {
        return quantityType
    }
    
    if let categoryType = HKCategoryType.categoryType(forIdentifier: HKCategoryTypeIdentifier(rawValue: identifier)) {
        return categoryType
    }
    
    return nil
}

// MARK: - Unit Support

/// Return the appropriate unit to use with an HKSample based on the identifier. Asserts for compatible units.
func preferredUnit(for sample: HKSample) -> HKUnit? {
    let unit = preferredUnit(for: sample.sampleType.identifier, sampleType: sample.sampleType)
    
    if let quantitySample = sample as? HKQuantitySample, let unit = unit {
        assert(quantitySample.quantity.is(compatibleWith: unit),
               "The preferred unit is not compatiable with this sample.")
    }
    
    return unit
}

/// Returns the appropriate unit to use with an identifier corresponding to a HealthKit data type.
func preferredUnit(for sampleIdentifier: String) -> HKUnit? {
    return preferredUnit(for: sampleIdentifier, sampleType: nil)
}

private func preferredUnit(for identifier: String, sampleType: HKSampleType? = nil) -> HKUnit? {
    var unit: HKUnit?
    let sampleType = sampleType ?? getSampleType(for: identifier)
    
    if sampleType is HKQuantityType {
        let quantityTypeIdentifier = HKQuantityTypeIdentifier(rawValue: identifier)
        
        switch quantityTypeIdentifier {
        case .stepCount:
            unit = .count()
        case .distanceWalkingRunning, .sixMinuteWalkTestDistance:
            unit = .meter()
        case .appleStandTime:
            unit = .minute()
        default:
            break
        }
    } else {
        unit = .hour()
    }
    
    return unit
}

// MARK: - Query Support

/// Return an anchor date for a statistics collection query.
func createAnchorDate() -> Date {
    // Set the arbitrary anchor date to Monday at 3:00 a.m.
    let calendar: Calendar = .current
    var anchorComponents = calendar.dateComponents([.day, .month, .year, .weekday], from: Date())
    let offset = (7 + (anchorComponents.weekday ?? 0) - 2) % 7
    
    anchorComponents.day! -= offset
    anchorComponents.hour = 3
    
    let anchorDate = calendar.date(from: anchorComponents)!
    
    return anchorDate
}

/// This is commonly used for date intervals so that we get the last seven days worth of data,
/// because we assume today (`Date()`) is providing data as well.

func getStartingDate(from date: Date = Date(), type: StatisticsType) -> Date{
    var result: Date = Date()
    var calendar = Calendar.current
    calendar.timeZone =  NSTimeZone(name: "GMT-4")! as TimeZone
    switch type {
    case .Day:
        result = calendar.startOfDay(for: date)
    case .Week:
        let prev = Calendar.current.date(byAdding: .day, value: -6, to: date)!
        result = calendar.startOfDay(for: prev)
    case .Month:
        let prev = Calendar.current.date(byAdding: .month, value: -1, to: date)!
        result = calendar.startOfDay(for: prev)
    case .Year:
        let prev = Calendar.current.date(byAdding: .year, value: -1, to: date)!
        result = calendar.startOfDay(for: prev)
    }
    return result
}

func getEndDate() -> Date {
    let today: Date = Date()
    var calendar = Calendar.current
    calendar.timeZone =  NSTimeZone(name: "GMT-4")! as TimeZone
    return calendar.date(bySettingHour: 23, minute: 59, second: 59, of: today)!
}


/// Return the most preferred `HKStatisticsOptions` for a data type identifier. Defaults to `.discreteAverage`.
func getStatisticsOptions(for dataTypeIdentifier: String) -> HKStatisticsOptions {
    var options: HKStatisticsOptions = .cumulativeSum
    let sampleType = getSampleType(for: dataTypeIdentifier)
    
    if sampleType is HKQuantityType {
        let quantityTypeIdentifier = HKQuantityTypeIdentifier(rawValue: dataTypeIdentifier)
        
        switch quantityTypeIdentifier {
        case .stepCount, .distanceWalkingRunning:
            options = .cumulativeSum
        default:
            break
        }
    } else {
        let categoryTypeIdentifier = HKCategoryTypeIdentifier(rawValue: dataTypeIdentifier)
        switch categoryTypeIdentifier {
        case .appleStandHour:
            options = .cumulativeSum
        default:
            break
        }
    }
    
    return options
}

/// Return the statistics value in `statistics` based on the desired `statisticsOption`.
func getStatisticsQuantity(for statistics: HKStatistics, with statisticsOptions: HKStatisticsOptions) -> HKQuantity? {
    var statisticsQuantity: HKQuantity?
    
    switch statisticsOptions {
    case .cumulativeSum:
        statisticsQuantity = statistics.sumQuantity()
    case .discreteAverage:
        statisticsQuantity = statistics.averageQuantity()
    default:
        break
    }
    
    return statisticsQuantity
}
