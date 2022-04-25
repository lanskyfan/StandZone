//
//  StandZoneController.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI
import HealthKit
import SwiftUICharts
import EventKit
import UserNotifications

@MainActor class StandZoneController: ObservableObject {
    @Published private var screen = Screen.initialView
    @Published private var user = UserModel()
    var healthController = HealthViewController()
    var eventStore = EKEventStore()
    var statisticsDisplay: [(label: String, value: Double)] = []

    init() {
        // For testing purpose
//        user.updateIsSetting(newSetting: false)
    }
    func getScreen() -> Screen{
        if (user.getIsSetting() == true) {
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
    
    func updateSetting(newSetting: Bool) {
        user.updateIsSetting(newSetting: newSetting)
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
    // Notification
    func updateIsNotify(isNotify: Bool) {
        user.updateIsNotify(newNotify: isNotify)
        if (isNotify) {
            requestNotificationAuthorization();
        } else {
            print("User denies the notification authorization")
        }
        sendNotification()
    }
    
    // Notification center property
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            } else {
                print("Success request notification authorization!")
            }
        }
    }
    
    class NotificationHandler : NSObject, UNUserNotificationCenterDelegate{
        static let shared = NotificationHandler()
       
        /** Handle notification when app is in background */
        func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response:
            UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
            
            let notiName = Notification.Name(response.notification.request.identifier)
            NotificationCenter.default.post(name:notiName , object: response.notification.request.content)
            completionHandler()
        }
        
        /** Handle notification when the app is in foreground */
        func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
                 withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            
            let notiName = Notification.Name( notification.request.identifier )
            NotificationCenter.default.post(name:notiName , object: notification.request.content)
            completionHandler(.sound)
        }
    }
    
    // Send Notification
    func sendNotification() {
        print("notficatioon")
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Stand Up!"
        notificationContent.body = "Hey, it's time to stand up and move around!"
        notificationContent.sound = UNNotificationSound.default
        notificationContent.badge = NSNumber(value: 3)
        
        // Add attachment
//        if let url = Bundle.main.url(forResource: "dune",
//                                    withExtension: "png") {
//            if let attachment = try? UNNotificationAttachment(identifier: "dune",
//                                                            url: url,
//                                                            options: nil) {
//                notificationContent.attachments = [attachment]
//            }
//        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3,
                                                        repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    
    func updateIsRepetitiveMode(newMode: Bool) {
        user.updateIsRepetitiveMode(newMode: newMode)
    }
    
    func updateIsAppleWatchOnly(isAppleWatch: Bool) {
        user.updateIsAppleWatchOnly(isAppleWatch: isAppleWatch)
    }
    
    func updateNoDisturbMode(newMode: NoDisturbMode) {
        user.updateNoDisturbMode(newMode: newMode)
    }
    
    func updateCustomMode(newMode: Int) {
        user.updateCustomMode(newMode: newMode)
    }
    
    func getNoDisturbModeText() -> String {
        if user.getNoDisturbMode() == NoDisturbMode.NoMode {
            return "Off"
        }
        if user.getNoDisturbMode() == NoDisturbMode.SystemMode {
            return "Default"
        }
        if user.getCustomMode() == 0 {
            return "Study"
        }
        if user.getCustomMode() == 1 {
            return "Work"
        }
        return "Default"
    }
    
    func updateCustomTime(name: String, value: Int) {
        user.updateCustomTime(name: name, value: value)
    }
    
    func updateIsImportCalendar(isImportCalendar: Bool) {
        self.objectWillChange.send()
        var isPermitted: Bool = false
        if (isImportCalendar) {
            let accessResult = AccessCalendar()
            isPermitted = accessResult.success
            eventStore = accessResult.store
            if (isPermitted) {
                user.updateIsImportCalendar(importCalendar: isImportCalendar)
            } else {
                user.updateIsImportCalendar(importCalendar: false)
            }
        }
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
    
    func generateDataPoint(type: StatisticsType, category: Category) -> [DataPoint]{
        //        let highIntensity = Legend(color: .orange, label: "High Intensity", order: 5)
        //        let buildFitness = Legend(color: .yellow, label: "Build Fitness", order: 4)
                let fatBurning = Legend(color: .green, label: "Achieve goal", order: 3)
//                let warmUp = Legend(color: .blue, label: "Warm Up", order: 2)
        let low = Legend(color: .gray, label: "Below goal", order: 1)
        var points: [DataPoint] = []
        
        if category == Category.Time {
            print("generateTimeDataPoint")
            let data = getTimeStatisticsData(type: type)
            for point in data {
                if (point.value >= Double(getUserInfo().getTimeGoal() * 5)) {
                    points.append(.init(value: point.value, label: LocalizedStringKey(point.label), legend: fatBurning))
                } else {
                    points.append(.init(value: point.value, label: LocalizedStringKey(point.label), legend: low))
                }
            }
        }


        return points
    }
    
    func getTimeStatisticsData(type: StatisticsType) ->  [(label: String, value: Double)] {
        print("produce statistics")
        print("statistics data len = ")
        let statistics = healthController.standTimeStatisticsData
        print(statistics.count)
        statisticsDisplay = []
        let dateFormatter = DateFormatter()
        switch type {
        case .Day:
            for value in statistics {
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
            for value in statistics {
                statisticsDisplay.append((dateFormatter.string(from: value.startDate), value.value))
            }
        case .Month:
            for value in statistics {
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
            for value in statistics {
                let calendar = Calendar.current
                let month = calendar.component(.month, from: value.startDate)
                
                let dateComponents = DateComponents(year: 2022, month: month)
                let date = calendar.date(from: dateComponents)!
                let range = calendar.range(of: .day, in: .month, for: date)!
                let numDays = range.count
                
                
                if month % 2 == 0 {
                    statisticsDisplay.append((String(month), value.value / Double(numDays)))
                } else {
                    statisticsDisplay.append(("", value.value / Double(numDays)))
                }
            }
        }
        
        return statisticsDisplay

    }
    
    
    func AccessCalendar () -> (success: Bool, store: EKEventStore){
        // Initialize the store.
        let eventStore = EKEventStore()
        var success: Bool = false
        
        let handler: (Bool, Error?) -> Void = {
            (granted, error) in
                // Handle the response to the request.
                if (granted) && (error == nil) {
                    print("Permission allowed")
                    success = true
                    
                } else{
                    print("failed to save event with error : \(String(describing: error)) or access not granted")
                    success = false
                }
        }

        // Request access to reminders.
        eventStore.requestAccess(to: .event, completion: handler)
        return (success, eventStore)
    }
    
    func hasEvent(store: EKEventStore) -> Bool {
        // Get the appropriate calendar.
        let calendar = Calendar.current
        
        // Create the start date components
        var thisMinuteComponents = DateComponents()
        thisMinuteComponents.minute = 0
        let thisMinute = calendar.date(byAdding: thisMinuteComponents, to: Date())
        
        // Create the end date components
        var tenMinuteLaterComponents = DateComponents()
        tenMinuteLaterComponents.minute = 10
        let tenMinuteLater = calendar.date(byAdding: tenMinuteLaterComponents, to: Date())
        
        // Create the predicate from the event store's instance method.
        var predicate: NSPredicate? = nil
        if let aNow = thisMinute, let aLater = tenMinuteLater {
            predicate = store.predicateForEvents(withStart: aNow, end: aLater, calendars: nil)
        }

        // Fetch all events that match the predicate.
        var events: [EKEvent]? = nil
        if let aPredicate = predicate {
            events = store.events(matching: aPredicate)
        }
        
        return events != nil
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

enum Category: String {
    case Time = "Time"
    case Frequency = "Frequency"
}

enum StatisticsType: String {
    case Day = "Day"
    case Week = "Week"
    case Month = "Month"
    case Year = "Year"
}

enum NoDisturbMode: String {
    case SystemMode = "System Mode"
    case CustomMode = "Custom Mode"
    case NoMode = "No Mode"
}
