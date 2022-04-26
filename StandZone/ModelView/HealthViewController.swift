//
//  HealthViewController.swift
//  StandZone
//
//  Created by yifanlan on 3/27/22.
//

import SwiftUI
import HealthKit


class HealthViewController: ObservableObject {
    
    
//    var statisticsData: [(dataTypeIdentifier: String, values: [Double])] = []
    var standTimeStatisticsData: [HealthDataTypeValue] = []
    var standFrequencyStatisticsData: [HealthDataTypeValue] = []
    var todayStandTime: [HealthDataTypeValue] = []
    var todayStandHour: [HealthDataTypeValue] = []
    var todayStandHourCount: Int = 0
    var todayStandTimeTotal: Double = 0.0
    let standTimeIdentifier = HKQuantityTypeIdentifier.appleStandTime.rawValue
    let standHourIdentifier = HKCategoryTypeIdentifier.appleStandHour.rawValue

    // MARK: - Button Selectors
    
    let healthStore = HealthData.healthStore

    /// The HealthKit data types we will request to read.
    let readTypes = Set(HealthData.readDataTypes)
    /// The HealthKit data types we will request to share and have write access.
    let shareTypes = Set(HealthData.shareDataTypes)
    
    var notRequestedHealthData: Bool = false
    
    func updateHealthData() {
        print("updateHealthDate")
        self.performTodayStandTimeQuery(dataTypeIdentifier: standTimeIdentifier)
        self.performTodayStandHourQueryV2()
        print(self.todayStandTime)
        print(self.todayStandHour)
        self.performTimeStatisticsQuery(type: StatisticsType.Day)
        self.performFrequencyStatisticsQuery(type: StatisticsType.Day)
    }
    
    func getHealthAuthorizationRequestStatus() {
        objectWillChange.send()
        print("Checking HealthKit authorization status...")
        
        if !HKHealthStore.isHealthDataAvailable() {
//            presentHealthDataNotAvailableError()
            print("get health data error")
            
            return
        }
        healthStore.getRequestStatusForAuthorization(toShare: shareTypes, read: readTypes) { (authorizationRequestStatus, error) in
            
            var status: String = ""
            if let error = error {
                status = "HealthKit Authorization Error: \(error.localizedDescription)"
            } else {
                switch authorizationRequestStatus {
                case .shouldRequest:
                    self.notRequestedHealthData = true
                    status = "The application has not yet requested authorization for all of the specified data types."
                case .unknown:
                    self.notRequestedHealthData = true
                    status = "The authorization request status could not be determined because an error occurred."
                case .unnecessary:
                    self.notRequestedHealthData = false
                    status = "The application has already requested authorization for the specified data types. "
                    status += self.createAuthorizationStatusDescription(for: self.shareTypes)
                default:
                    break
                }
            }
            
            print(status)
            
//             Results come back on a background thread. Dispatch UI updates to the main thread.
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    
    // MARK: - Helper Functions
    
    private func createAuthorizationStatusDescription(for types: Set<HKObjectType>) -> String {
        var dictionary = [HKAuthorizationStatus: Int]()
        
        for type in types {
            let status = healthStore.authorizationStatus(for: type)
            
            if let existingValue = dictionary[status] {
                dictionary[status] = existingValue + 1
            } else {
                dictionary[status] = 1
            }
        }
        
        var descriptionArray: [String] = []
        
        if let numberOfAuthorizedTypes = dictionary[.sharingAuthorized] {
            let format = NSLocalizedString("AUTHORIZED_NUMBER_OF_TYPES", comment: "")
            let formattedString = String(format: format, locale: .current, arguments: [numberOfAuthorizedTypes])
            
            descriptionArray.append(formattedString)
        }
        if let numberOfDeniedTypes = dictionary[.sharingDenied] {
            let format = NSLocalizedString("DENIED_NUMBER_OF_TYPES", comment: "")
            let formattedString = String(format: format, locale: .current, arguments: [numberOfDeniedTypes])
            
            descriptionArray.append(formattedString)
        }
        if let numberOfUndeterminedTypes = dictionary[.notDetermined] {
            let format = NSLocalizedString("UNDETERMINED_NUMBER_OF_TYPES", comment: "")
            let formattedString = String(format: format, locale: .current, arguments: [numberOfUndeterminedTypes])
            
            descriptionArray.append(formattedString)
        }
        
        // Format the sentence for grammar if there are multiple clauses.
        if let lastDescription = descriptionArray.last, descriptionArray.count > 1 {
            descriptionArray[descriptionArray.count - 1] = "and \(lastDescription)"
        }
        
        let description = "Sharing is " + descriptionArray.joined(separator: ", ") + "."
        
        return description
    }
    
    
    func requestHealthAuthorization() {
        print("Requesting HealthKit authorization...")
        
        if !HKHealthStore.isHealthDataAvailable() {
//            presentHealthDataNotAvailableError()
            print("health data not available")
            return
        }
        
        healthStore.requestAuthorization(toShare: shareTypes, read: readTypes) { (success, error) in
            var status: String = ""
            
            if let error = error {
                status = "HealthKit Authorization Error: \(error.localizedDescription)"
            } else {
                if success {
                    status = "HealthKit authorization request was successful! "
                    status += self.createAuthorizationStatusDescription(for: self.shareTypes)
                } else {
                    status = "HealthKit authorization did not complete successfully."
                }
            }
            
            print(status)
            
            // Results come back on a background thread. Dispatch UI updates to the main thread.
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    
    

    
    
//    private func didSelectDataTypeIdentifier(_ dataTypeIdentifier: String) {
////        self.standTimeIdentifier = dataTypeIdentifier
//
//        HealthData.requestHealthDataAccessIfNeeded(dataTypes: [self.standTimeIdentifier]) { [weak self] (success) in
//            if success {
//                DispatchQueue.main.async {
//                    // do something
//                }
//
//                self?.performQuery(dataTypeIdentifier: standTimeIdentifier)
////                if let healthQueryDataSourceProvider = self as? HealthQueryDataSource {
////                    healthQueryDataSourceProvider.performQuery()
////                } else {
////                    DispatchQueue.main.async { [weak self] in
////                        self?.reloadData()
////                    }
////                }
//            }
//        }
//
//    }
    
    
    
    


    // MARK: - HealthQueryDataSource

    /// Perform a query and reload the data upon completion.
//    func loadData() {
//        performQuery {
//            DispatchQueue.main.async { [weak self] in
//                self?.reloadData()
//            }
//        }
//    }
    
    func performTodayStandHourQuery(dataTypeIdentifier: String) {
        let startDate: Date = getStartingDate(type: StatisticsType.Day)
        let endDate = getEndDate()
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let queryAnchor: HKQueryAnchor? = nil
        let queryLimit: Int = HKObjectQueryNoLimit

        guard let sampleType = getSampleType(for: dataTypeIdentifier) else { return }
        
        let anchoredObjectQuery = HKAnchoredObjectQuery(type: sampleType,
                                                        predicate: queryPredicate,
                                                        anchor: queryAnchor,
                                                        limit: queryLimit) {
            (query, samplesOrNil, deletedObjectsOrNil, anchor, errorOrNil) in
            
            guard let samples = samplesOrNil else { return }
            
            self.todayStandHour = samples.map { (sample) -> HealthDataTypeValue in
                let realSample: HKCategorySample = sample as! HKCategorySample
                let dataValue = HealthDataTypeValue(id: 0, startDate: realSample.startDate,
                                                    endDate: realSample.endDate,
                                                    value: Double(realSample.value))
                
                return dataValue
            }
            
            for dataIndex in 0..<self.todayStandHour.count {
                self.todayStandHour[dataIndex].id = dataIndex
            }
            print(startDate)
            print(endDate)
            print(self.todayStandHour)
            self.todayStandHourCount = self.todayStandHour.count
            
        }
        
        HealthData.healthStore.execute(anchoredObjectQuery)
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    
    func performTodayStandTimeQuery(dataTypeIdentifier: String) {
        let startDate: Date = getStartingDate(type: StatisticsType.Day)
        let endDate = getEndDate()
        let queryPredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let queryAnchor: HKQueryAnchor? = nil
        let queryLimit: Int = HKObjectQueryNoLimit

        guard let sampleType = getSampleType(for: dataTypeIdentifier) else { return }
        
        let anchoredObjectQuery = HKAnchoredObjectQuery(type: sampleType,
                                                        predicate: queryPredicate,
                                                        anchor: queryAnchor,
                                                        limit: queryLimit) {
            (query, samplesOrNil, deletedObjectsOrNil, anchor, errorOrNil) in
            
            guard let samples = samplesOrNil else { return }
            
            self.todayStandTime = samples.map { (sample) -> HealthDataTypeValue in
                var dataValue = HealthDataTypeValue(id: 0, startDate: sample.startDate,
                                                    endDate: sample.endDate,
                                                    value: .zero)
                if let quantitySample = sample as? HKQuantitySample,
                   let unit = preferredUnit(for: quantitySample) {
                    dataValue.value = quantitySample.quantity.doubleValue(for: unit)
                }
                
                return dataValue
            }
            
            for dataIndex in 0..<self.todayStandTime.count {
                self.todayStandTime[dataIndex].id = dataIndex
                self.todayStandTimeTotal += self.todayStandTime[dataIndex].value
            }
            
        }
        
        HealthData.healthStore.execute(anchoredObjectQuery)
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    
    
    
    func performTimeStatisticsQuery(type: StatisticsType) {
        self.objectWillChange.send()

        print(" time statistics query")
        // Create a query for each data type.
        let startDate: Date = getStartingDate(type: type)
            // Set dates
        let endDate = getEndDate()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let dateInterval: DateComponents
        switch type {
        case .Day:
            dateInterval = DateComponents(hour: 1)
        case .Week:
            dateInterval = DateComponents(day: 1)
        case .Month:
            dateInterval = DateComponents(day: 1)
        case .Year:
            dateInterval = DateComponents(month: 1)
        }
        

            // Process data.
//            let statisticsOptions = getStatisticsOptions(for: standTimeIdentifier)
            let statisticsOptions: HKStatisticsOptions = .cumulativeSum
            let initialResultsHandler: (HKStatisticsCollection) -> Void = { (statisticsCollection) in
                self.standTimeStatisticsData = []
                statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                    let statisticsQuantity = getStatisticsQuantity(for: statistics, with: statisticsOptions)
                    if let unit = preferredUnit(for: self.standTimeIdentifier),
                        let value = statisticsQuantity?.doubleValue(for: unit) {
                            self.standTimeStatisticsData.append(HealthDataTypeValue(id: 0, startDate: statistics.startDate, endDate: statistics.endDate, value: value))
                    } else {
                            self.standTimeStatisticsData.append(HealthDataTypeValue(id: 0, startDate: statistics.startDate, endDate: statistics.endDate, value: 0))
                        }

                    }
                for dataIndex in 0..<self.standTimeStatisticsData.count {
                    self.standTimeStatisticsData[dataIndex].id = dataIndex
                }
                // Results come back on a background thread. Dispatch UI updates to the main thread.
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }

            }
            
            // Fetch statistics.
            HealthData.fetchStatistics(with: HKQuantityTypeIdentifier(rawValue: standTimeIdentifier),
                                       predicate: predicate,
                                       options: statisticsOptions,
                                       startDate: startDate,
                                       interval: dateInterval,
                                       completion: initialResultsHandler)

    }

    func performTodayStandHourQueryV2 () {
        self.objectWillChange.send()
        // Create a query for each data type.
        let startDate: Date = getStartingDate(type: .Day)
            // Set dates
        let endDate = getEndDate()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let dateInterval = DateComponents(hour: 1)
        

        // Process data.
        let statisticsOptions: HKStatisticsOptions = .cumulativeSum
        let initialResultsHandler: (HKStatisticsCollection) -> Void = { (statisticsCollection) in
            self.todayStandHour = []
            statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                let statisticsQuantity = getStatisticsQuantity(for: statistics, with: statisticsOptions)
                if let unit = preferredUnit(for: self.standTimeIdentifier),
                    let value = statisticsQuantity?.doubleValue(for: unit) {
                        self.todayStandHour.append(HealthDataTypeValue(id: 0, startDate: statistics.startDate, endDate: statistics.endDate, value: value))
                }

            }
            for dataIndex in 0..<self.todayStandHour.count {
                self.todayStandHour[dataIndex].id = dataIndex
            }
            self.todayStandHourCount = self.todayStandHour.count

            // Results come back on a background thread. Dispatch UI updates to the main thread.
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }

        }
        
        // Fetch statistics.
        HealthData.fetchStatistics(with: HKQuantityTypeIdentifier(rawValue: standTimeIdentifier),
                                   predicate: predicate,
                                   options: statisticsOptions,
                                   startDate: startDate,
                                   interval: dateInterval,
                                   completion: initialResultsHandler)
    }
    
    func performFrequencyStatisticsQuery(type: StatisticsType) {
        self.objectWillChange.send()

        print(" time statistics query")
        // Create a query for each data type.
        let startDate: Date = getStartingDate(type: type)
            // Set dates
        let endDate = getEndDate()
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let dateInterval: DateComponents
        switch type {
        case .Day:
            dateInterval = DateComponents(hour: 1)
        case .Week:
            dateInterval = DateComponents(hour: 1)
        case .Month:
            dateInterval = DateComponents(hour: 1)
        case .Year:
            dateInterval = DateComponents(hour: 1)
        }
        

            // Process data.
//            let statisticsOptions = getStatisticsOptions(for: standTimeIdentifier)
            let statisticsOptions: HKStatisticsOptions = .cumulativeSum
            let initialResultsHandler: (HKStatisticsCollection) -> Void = { (statisticsCollection) in
                self.standFrequencyStatisticsData = []

                if type == .Day {
                    statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                        let statisticsQuantity = getStatisticsQuantity(for: statistics, with: statisticsOptions)
                        if let unit = preferredUnit(for: self.standTimeIdentifier),
                           let _ = statisticsQuantity?.doubleValue(for: unit) {
                                self.standFrequencyStatisticsData.append(HealthDataTypeValue(id: 0, startDate: statistics.startDate, endDate: statistics.endDate, value: 1))
                        } else {
                                self.standFrequencyStatisticsData.append(HealthDataTypeValue(id: 0, startDate: statistics.startDate, endDate: statistics.endDate, value: 0))
                            }

                        }
                } else if type == .Week || type == .Month {
                    var count = 0
                    statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                        let statisticsQuantity = getStatisticsQuantity(for: statistics, with: statisticsOptions)
                        count += 1
                        var realValue = 0.0
                        if let unit = preferredUnit(for: self.standTimeIdentifier),
                           let _ = statisticsQuantity?.doubleValue(for: unit) {
                            realValue += 1.0
                        } else {
                            realValue += 0
                        }
                        
                        if count % 24 == 1 {
                            self.standFrequencyStatisticsData.append(HealthDataTypeValue(id: 0, startDate: statistics.startDate, endDate: statistics.endDate, value: realValue))
                        } else {
                            self.standFrequencyStatisticsData[self.standFrequencyStatisticsData.count - 1].endDate = statistics.endDate
                            self.standFrequencyStatisticsData[self.standFrequencyStatisticsData.count - 1].value += realValue
                        }

                        }
                } else {
                    var byDay: [HealthDataTypeValue] = []
                    var count = 0
                    statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                        let statisticsQuantity = getStatisticsQuantity(for: statistics, with: statisticsOptions)
                        count += 1
                        var realValue = 0.0
                        if let unit = preferredUnit(for: self.standTimeIdentifier),
                           let _ = statisticsQuantity?.doubleValue(for: unit) {
                            realValue += 1.0
                        } else {
                            realValue += 0
                        }
                        
                        if count % 24 == 1 {
                            byDay.append(HealthDataTypeValue(id: 0, startDate: statistics.startDate, endDate: statistics.endDate, value: realValue))
                        } else {
                            byDay[byDay.count - 1].endDate = statistics.endDate
                            byDay[byDay.count - 1].value += realValue
                        }
                        }
                    
                    var currentMonth = 0
                    let calendar = Calendar.current
                    for data in byDay {
                        let month = calendar.component(.month, from: data.startDate)
                        if month != currentMonth {
                            self.standFrequencyStatisticsData.append(data)
                            currentMonth = month
                        } else {
                            self.standFrequencyStatisticsData[self.standFrequencyStatisticsData.count - 1].value += data.value
                        }
                    }
                    
                }

                for dataIndex in 0..<self.standFrequencyStatisticsData.count {
                    self.standFrequencyStatisticsData[dataIndex].id = dataIndex
                }
                // Results come back on a background thread. Dispatch UI updates to the main thread.
                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }

            }
            
            // Fetch statistics.
            HealthData.fetchStatistics(with: HKQuantityTypeIdentifier(rawValue: standTimeIdentifier),
                                       predicate: predicate,
                                       options: statisticsOptions,
                                       startDate: startDate,
                                       interval: dateInterval,
                                       completion: initialResultsHandler)
    }

}
