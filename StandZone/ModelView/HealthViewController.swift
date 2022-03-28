//
//  HealthViewController.swift
//  StandZone
//
//  Created by yifanlan on 3/27/22.
//

import SwiftUI
import HealthKit


class HealthViewController: ObservableObject {
    var dataValues: [HealthDataTypeValue] = []
    var dataTypeIdentifier = HKQuantityTypeIdentifier.appleStandTime.rawValue
    // MARK: - Button Selectors
    
    let healthStore = HealthData.healthStore

    /// The HealthKit data types we will request to read.
    let readTypes = Set(HealthData.readDataTypes)
    /// The HealthKit data types we will request to share and have write access.
    let shareTypes = Set(HealthData.shareDataTypes)
    
    var notRequestedHealthData: Bool = false
    
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
    
    
    

    
    
    private func didSelectDataTypeIdentifier(_ dataTypeIdentifier: String) {
        self.dataTypeIdentifier = dataTypeIdentifier
        
        HealthData.requestHealthDataAccessIfNeeded(dataTypes: [self.dataTypeIdentifier]) { [weak self] (success) in
            if success {
                DispatchQueue.main.async {
                    // do something
                }
  
                self?.performQuery()
//                if let healthQueryDataSourceProvider = self as? HealthQueryDataSource {
//                    healthQueryDataSourceProvider.performQuery()
//                } else {
//                    DispatchQueue.main.async { [weak self] in
//                        self?.reloadData()
//                    }
//                }
            }
        }
        
    }
    
    
    
    
    var queryPredicate: NSPredicate? = nil
    var queryAnchor: HKQueryAnchor? = nil
    var queryLimit: Int = HKObjectQueryNoLimit


    // MARK: - HealthQueryDataSource

    /// Perform a query and reload the data upon completion.
//    func loadData() {
//        performQuery {
//            DispatchQueue.main.async { [weak self] in
//                self?.reloadData()
//            }
//        }
//    }
    
    func performQuery() {
        self.objectWillChange.send()
        guard let sampleType = getSampleType(for: dataTypeIdentifier) else { return }
        
        let anchoredObjectQuery = HKAnchoredObjectQuery(type: sampleType,
                                                        predicate: queryPredicate,
                                                        anchor: queryAnchor,
                                                        limit: queryLimit) {
            (query, samplesOrNil, deletedObjectsOrNil, anchor, errorOrNil) in
            
            guard let samples = samplesOrNil else { return }
            
            self.dataValues = samples.map { (sample) -> HealthDataTypeValue in
                var dataValue = HealthDataTypeValue(startDate: sample.startDate,
                                                    endDate: sample.endDate,
                                                    value: .zero)
                if let quantitySample = sample as? HKQuantitySample,
                   let unit = preferredUnit(for: quantitySample) {
                    dataValue.value = quantitySample.quantity.doubleValue(for: unit)
                }
                
                return dataValue
            }
            print("In query")
            print(self.dataValues)
            
        }
        
        HealthData.healthStore.execute(anchoredObjectQuery)
    }
}

