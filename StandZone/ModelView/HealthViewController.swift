//
//  HealthViewController.swift
//  StandZone
//
//  Created by yifanlan on 3/27/22.
//

import SwiftUI
import HealthKit
import SwiftUICharts


class HealthViewController: ObservableObject {
    
    
//    var statisticsData: [(dataTypeIdentifier: String, values: [Double])] = []
    var statisticsData: [HealthDataTypeValue] = []
    var statisticsDisplay: [(label: String, value: Double)] = []
    
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
        self.performTodayStandHourQuery(dataTypeIdentifier: standHourIdentifier)
        print(self.todayStandTime)
        print(self.todayStandHour)
        self.performStatisticsQuery(type: StatisticsType.Day)
        print(self.statisticsDisplay)
    }
    
    func getHealthAuthorizationRequestStatus() {
        objectWillChange.send()
        print("Checking HealthKit authorization status...")
        
        if !HKHealthStore.isHealthDataAvailable() {
//            presentHealthDataNotAvailableError()
            print("get health data error")
            
            return
        }
        print("step1 complete")
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
        objectWillChange.send()
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
                    if !self.notRequestedHealthData {
                        status = "You've already requested access to health data. "
                    } else {
                        status = "HealthKit authorization request was successful! "
                    }
                    
                    status += self.createAuthorizationStatusDescription(for: self.shareTypes)
                    
                    self.notRequestedHealthData = false
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
        self.objectWillChange.send()
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
                var dataValue = HealthDataTypeValue(id: 0, startDate: sample.startDate,
                                                    endDate: sample.endDate,
                                                    value: .zero)
                if let quantitySample = sample as? HKQuantitySample,
                   let unit = preferredUnit(for: quantitySample) {
                    dataValue.value = quantitySample.quantity.doubleValue(for: unit)
                }
                
                return dataValue
            }
            
            for dataIndex in 0..<self.todayStandHour.count {
                self.todayStandHour[dataIndex].id = dataIndex
            }
            self.todayStandHourCount = self.todayStandHour.count
            
        }
        
        HealthData.healthStore.execute(anchoredObjectQuery)
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
    
    
    func performTodayStandTimeQuery(dataTypeIdentifier: String) {
        self.objectWillChange.send()
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
    
    func generateDataPoint(type: StatisticsType) -> [DataPoint]{
        //        let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
        //        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
//                let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
//                let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
        let low = Legend(color: .gray, label: "Low", order: 1)
        var points: [DataPoint] = []
        print("call function")
        let data = produceStatistics(type: type)
        for point in data {
            points.append(.init(value: point.value, label: LocalizedStringKey(point.label), legend: low))
        }
        return points
    }
    
    
    func produceStatistics(type: StatisticsType) ->  [(label: String, value: Double)] {
        print("produce statistics")
        print("statistics data len = ")
        print(statisticsData.count)
        statisticsDisplay = []
        let dateFormatter = DateFormatter()
        switch type {
        case .Day:
            for value in self.statisticsData {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: value.startDate)
                if hour % 4 == 0 {
                    statisticsDisplay.append((String(hour), value.value))
                } else {
                    statisticsDisplay.append(("", value.value))
                }
            }
        case .Week:
            dateFormatter.dateFormat = "E"
            for value in self.statisticsData {
                statisticsDisplay.append((dateFormatter.string(from: value.startDate), value.value))
            }
        case .Month:
            for value in self.statisticsData {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day], from: value.startDate)
                let dayOfMonth = components.day
                if dayOfMonth! % 5 == 0 {
                    statisticsDisplay.append((String(dayOfMonth!), value.value))
                } else {
                    statisticsDisplay.append(("", value.value))
                }
            }

        case .Year:
            for value in self.statisticsData {
                let calendar = Calendar.current
                let month = calendar.component(.month, from: value.startDate)
                if month % 2 == 0 {
                    statisticsDisplay.append((String(month), value.value))
                } else {
                    statisticsDisplay.append(("", value.value))
                }
            }
        }
        
        return statisticsDisplay

    }
    
    
    func performStatisticsQuery(type: StatisticsType) {
        self.objectWillChange.send()
        statisticsData = []
        print(" statistics query")
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
//            let statisticsOptions = getStatisticsOptions(for: item.dataTypeIdentifier)
            let statisticsOptions: HKStatisticsOptions = .cumulativeSum
            let initialResultsHandler: (HKStatisticsCollection) -> Void = { (statisticsCollection) in
                statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
                    let statisticsQuantity = getStatisticsQuantity(for: statistics, with: statisticsOptions)
                    if let unit = preferredUnit(for: self.standTimeIdentifier),
                        let value = statisticsQuantity?.doubleValue(for: unit) {
                        self.statisticsData.append(HealthDataTypeValue(id: 0, startDate: statistics.startDate, endDate: statistics.endDate, value: value))
                    } else {
                        self.statisticsData.append(HealthDataTypeValue(id: 0, startDate: statistics.startDate, endDate: statistics.endDate, value: 0))
                    }
                }
                for dataIndex in 0..<self.statisticsData.count {
                    print("yes")
                    self.statisticsData[dataIndex].id = dataIndex
                }
            }
            
            // Fetch statistics.
            HealthData.fetchStatistics(with: HKQuantityTypeIdentifier(rawValue: self.standTimeIdentifier),
                                       predicate: predicate,
                                       options: statisticsOptions,
                                       startDate: startDate,
                                       interval: dateInterval,
                                       completion: initialResultsHandler)

        // Results come back on a background thread. Dispatch UI updates to the main thread.
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
}

