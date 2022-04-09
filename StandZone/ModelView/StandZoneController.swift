//
//  StandZoneController.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI
import HealthKit
import SwiftUICharts

@MainActor class StandZoneController: ObservableObject {
    @Published private var screen = Screen.initialView
    @Published private var user = UserModel()
    var healthController = HealthViewController()
    
    init() {
        // For testing purpose
//        user.updateLogIn(newLogin: false)
    }
    func getScreen() -> Screen{
        if (user.getIsLogIn() == true) {
            return Screen.mainView
        }
        return Screen.initialView
    }
    
    func updateScreen(newScreen: Screen) {
//        objectWillChange.send()
        print("My new screen is \(newScreen)")
        screen = newScreen
    }
    
    func updateLogIn(newLogIn: Bool) {
        user.updateLogIn(newLogin: newLogIn)
    }
    
    func getUserInfo() -> UserModel {
        return user
    }
    
    func updateAccountInfo(newEmail: String, newPassword: String) {
        user.updateEmail(newEmail: newEmail)
        user.updatePassword(newPassword: newPassword)
    }
    
    func updateName(newName: String) {
        user.updateName(newName: newName)
    }
    
    func updateGender(newGender: Gender) {
        user.updateGender(newGender: newGender)
    }
    
    func updateWakeUpTime(newWakeUpTime: Date) {
        print("update wake up time")
        user.updateWakeUpTime(newTime: newWakeUpTime)
    }
    
    func updateSleepTime(newSleepTime: Date) {
        print("update sleep time")
        user.updateSleepTime(newTime: newSleepTime)
    }
    
    func updateGoal(newFrequency: Int, newTime: Int) {
        user.updateFrequencyGoal(newGoal: newFrequency)
        user.updateTimeGoal(newGoal: newTime)
    }
    
    func updateIsNotify(isNotify: Bool) {
        user.updateIsNotify(newNotify: isNotify)
    }
    
    
    func updateIsNotify(newNotify: Bool) {
        user.updateIsNotify(newNotify: newNotify)
    }
    
    func updateIsRepetitiveMode(newMode: Bool) {
        user.updateIsRepetitiveMode(newMode: newMode)
    }
    
    func updateIsAppleWatchOnly(isAppleWatch: Bool) {
        user.updateIsAppleWatchOnly(isAppleWatch: isAppleWatch)
    }
    
    func updateIsImportCalendar(isImportCalendar: Bool) {
        user.updateIsImportCalendar(importCalendar: isImportCalendar)
    }
    
    var dataTypeIdentifier = "example"
    
    private func presentDataTypeSelectionView() {
        let title = "Select Health Data Type"
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        for dataType in HealthData.readDataTypes {
            let actionTitle = getDataTypeName(for: dataType.identifier)
            let action = UIAlertAction(title: actionTitle, style: .default) { [weak self] (action) in
                self?.didSelectDataTypeIdentifier(dataType.identifier)
            }
            
            alertController.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(cancel)
        
//        present(alertController, animated: true)
    }
    
    private func didSelectDataTypeIdentifier(_ dataTypeIdentifier: String) {
        self.dataTypeIdentifier = dataTypeIdentifier
        
        HealthData.requestHealthDataAccessIfNeeded(dataTypes: [self.dataTypeIdentifier]) { [weak self] (success) in
//            if success {
//                DispatchQueue.main.async {
//                    self?.updateNavigationItem()
//                }
//
//                if let healthQueryDataSourceProvider = self as? HealthQueryDataSource {
//                    healthQueryDataSourceProvider.performQuery() { [weak self] in
//                        DispatchQueue.main.async {
//                            self?.reloadData()
//                        }
//                    }
//                } else {
//                    DispatchQueue.main.async { [weak self] in
//                        self?.reloadData()
//                    }
//                }
//            }
        }
        
    }
    
    
    func generateDataPoint(type: StatisticsType) -> [DataPoint]{
        //        let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
        //        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
                let fatBurning = Legend(color: .green, label: "Fat Burning", order: 3)
//                let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
        let low = Legend(color: .gray, label: "Low", order: 1)
        var points: [DataPoint] = []
        print("generateDataPoint")
        let data = healthController.produceStatistics(type: type)
        for point in data {
            if (point.value >= Double(getUserInfo().getTimeGoal() * 5)) {
                points.append(.init(value: point.value, label: LocalizedStringKey(point.label), legend: fatBurning))
            } else {
                points.append(.init(value: point.value, label: LocalizedStringKey(point.label), legend: low))
            }
        }
        return points
    }
    

}

enum Screen {
    case initialView
    case registerView
    case registerView1
    case registerView2
    case registerView3
    case registerView4
    case logInView
    case homeView
    case homeView1
    case mainView
    case homeView2
}

enum Gender: String {
    case Male = "Male"
    case Female = "Female"
}

enum StatisticsType: String {
    case Day = "Day"
    case Week = "Week"
    case Month = "Month"
    case Year = "Year"
}
