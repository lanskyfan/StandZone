//
//  UserModel.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import Foundation

struct UserModel {
    private var isSetting = "IsSetting"
    private var isLogin = "IslogIn"
    private var password: String = "Password"
    private var email: String = "Email"
    private var name: String = "Name"
    private var gender: String = "Gender"
    private var frequencyGoal: String = "FrequencyGoal"
    private var timeGoal: String = "TimeGoal"
    private var wakeUpTime: String = "WakeUpTime"
    private var sleepTime: String = "SleepTime"
    private var isNotify: String = "IsNotify"
    private var isRepetitiveMode: String = "IsRepetitiveMode"
    private var isAppleWatchOnly: String = "IsAppleWatchOnly"
    private var isImportCalendar: String = "IsImportCalendar"
    private var isTest: String = "IsTest"
    private var noDisturbMode: String = "NoDisturbMode"
    private var customModes: String = "CustomModes"
    private var calendarMode: String = "CalendarMode"
    private var motivationMode: String = "MotivationMode"
    private var reminderSount: String = "ReminderSound"
    private var message: String = "Message"
    private var isShowRank: String = "IsShowRank"
    private var customTime: String = "CustomTime"
    
    let defaults = UserDefaults.standard

    func getIsLogIn() -> Bool {
        if (defaults.object(forKey:isLogin) == nil) {
            defaults.set(false, forKey: isLogin)
        }
        return defaults.object(forKey:isLogin) as! Bool
    }
    
    func updateLogIn(newLogin: Bool) {
        defaults.set(newLogin, forKey: isLogin)
    }
    
    func getIsSetting() -> Bool {
        if (defaults.object(forKey:isSetting) == nil) {
            defaults.set(false, forKey: isSetting)
        }
        return defaults.object(forKey:isSetting) as! Bool
    }
    
    func updateIsSetting(newSetting: Bool) {
        defaults.set(newSetting, forKey: isSetting)
    }
    
    func getEmail() -> String {
        if (defaults.object(forKey:email) == nil) {
            defaults.set("", forKey: email)
        }
        return defaults.object(forKey:email) as! String
    }
    
    mutating func updateEmail(newEmail: String) {
        defaults.set(newEmail, forKey: email)
    }
    
    
    func getName() -> String {
        
        if (defaults.object(forKey:name) == nil) {
            defaults.set("", forKey: name)
        }
        return defaults.object(forKey:name) as! String
    }
    
    mutating func updateName(newName: String) {
        defaults.set(newName, forKey: name)
    }
    
    func getGender() -> Gender {
//        do {
//            if (defaults.object(forKey:gender) == nil) {
//                let encodedData = try NSKeyedArchiver.archivedData(withRootObject: Gender.Male, requiringSecureCoding: false)
//                defaults.set(encodedData, forKey: gender)
//            }
//            let decoded = defaults.object(forKey:gender) as! Data
//            let decodedGender = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as! Gender
//            return decodedGender
//        } catch {
//            // Do nothing
//        }
//        return Gender.Male
        if (defaults.object(forKey:gender) == nil) {
            defaults.set(Gender.Male.rawValue, forKey: gender)
        }
        let rawValue = defaults.object(forKey:gender) as! String
        return Gender(rawValue: rawValue)!
    }
    
    mutating func updateGender(newGender: Gender) {
//        do {
//            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: newGender, requiringSecureCoding: false)
//            defaults.set(encodedData, forKey: gender)
//        } catch {
//            // Do nothing
//            print("Unexpected error: \(error).")
//        }
        defaults.set(newGender.rawValue, forKey: gender)
    }
    
    func getPassword() -> String {
        if (defaults.object(forKey:password) == nil) {
            defaults.set("", forKey: password)
        }
        return defaults.object(forKey:password) as! String
    }
    
    mutating func updatePassword(newPassword: String) {
        defaults.set(newPassword, forKey: password)
    }
    
    func getFrequencyGoal() -> Int{
        if (defaults.object(forKey:frequencyGoal) == nil) {
            defaults.set(12, forKey: frequencyGoal)
        }
        return defaults.object(forKey:frequencyGoal) as! Int
    }
    
    mutating func updateFrequencyGoal(newGoal: Int) {
        defaults.set(newGoal, forKey: frequencyGoal)
    }
    
    func getTimeGoal() -> Int {
        if (defaults.object(forKey:timeGoal) == nil) {
            defaults.set(24, forKey: timeGoal)
        }
        return defaults.object(forKey:timeGoal) as! Int
    }
    
    mutating func updateTimeGoal(newGoal: Int) {
        defaults.set(newGoal, forKey: timeGoal)
    }
    
    func getWakeUpTime() -> Date {
        if (defaults.object(forKey:wakeUpTime) == nil) {
            defaults.set(0, forKey: wakeUpTime)
        }
        return defaults.object(forKey:wakeUpTime) as! Date
    }
    
    mutating func updateWakeUpTime(newTime: Date) {
        print("update wake up time")
        defaults.set(newTime, forKey: wakeUpTime)
    }
    
    func getSleepTime() -> Date {
        if (defaults.object(forKey:sleepTime) == nil) {
            defaults.set(0, forKey: sleepTime)
        }
        return defaults.object(forKey:sleepTime) as! Date
    }
    
    mutating func updateSleepTime(newTime: Date) {
        print("update sleep time")
        defaults.set(newTime, forKey: sleepTime)
    }
    
    func getIsNotify() -> Bool {
        if (defaults.object(forKey:isNotify) == nil) {
            defaults.set(true, forKey: isNotify)
        }
        return defaults.object(forKey:isNotify) as! Bool
        
    }
    
    mutating func updateIsNotify(newNotify: Bool) {
        defaults.set(newNotify, forKey: isNotify)
    }
    
    func getIsRepetitiveMode() -> Bool {
        if (defaults.object(forKey:isRepetitiveMode) == nil) {
            defaults.set(true, forKey: isRepetitiveMode)
        }
        return defaults.object(forKey:isRepetitiveMode) as! Bool
        
    }
    
    mutating func updateIsRepetitiveMode(newMode: Bool) {
        defaults.set(newMode, forKey: isRepetitiveMode)
    }
    
    func getIsAppleWatchOnly() -> Bool {
        if (defaults.object(forKey:isAppleWatchOnly) == nil) {
            defaults.set(true, forKey: isAppleWatchOnly)
        }
        return defaults.object(forKey:isAppleWatchOnly) as! Bool
        
    }
    
    mutating func updateIsAppleWatchOnly(isAppleWatch: Bool) {
        defaults.set(isAppleWatch, forKey: isAppleWatchOnly)
    }
    
    func getIsImportCalendar() -> Bool {
        if (defaults.object(forKey:isImportCalendar) == nil) {
            defaults.set(false, forKey: isImportCalendar)
        }
        return defaults.object(forKey:isImportCalendar) as! Bool
        
    }
    
    mutating func updateIsImportCalendar(importCalendar: Bool) {
        defaults.set(importCalendar, forKey: isImportCalendar)
    }
    
    func getIsTest() -> Bool {
        if (defaults.object(forKey: isTest) == nil) {
            defaults.set(false, forKey: isTest)
        }
        return defaults.object(forKey: isTest) as! Bool
    }
    
    mutating func updateIsTest(Test: Bool) {
        defaults.set(Test, forKey: isTest)
    }
    
    func getNoDisturbMode() -> NoDisturbMode {
        if (defaults.object(forKey:noDisturbMode) == nil) {
            defaults.set(NoDisturbMode.SystemMode.rawValue, forKey: noDisturbMode)
        }
        let rawValue = defaults.object(forKey:noDisturbMode) as! String
        return NoDisturbMode(rawValue: rawValue)!
    }

    mutating func updateNoDisturbMode(newMode: NoDisturbMode) {
        defaults.set(newMode.rawValue, forKey: noDisturbMode)
    }
    
    func getCustomMode() -> Int {
        if (defaults.object(forKey: customModes) == nil) {
            defaults.set(0, forKey: customModes)
        }
        return defaults.object(forKey:customModes) as! Int
    }
    
    mutating func updateCustomMode(newMode: Int) {
        defaults.set(newMode, forKey: customModes)
    }
    
    func getCustomTime(name: String) -> Int {
        if (defaults.object(forKey: customTime) == nil) {
            defaults.set([:], forKey: customTime)
            return 1
        }
        let times = defaults.object(forKey:customTime) as! [String: Int]
        if times[name] == nil {
            return 1
        }
        return times[name]!
    }
    
    mutating func deleteCustomTime(name: String) {
        if (defaults.object(forKey: customTime) == nil) {
            defaults.set([:], forKey: customTime)
        }
        var times = defaults.object(forKey:customTime) as! [String: Int]
        times[name] = nil
        defaults.set(times, forKey: customTime)
    }
    
    func getCustomFull() -> [String] {
        if (defaults.object(forKey: customTime) == nil) {
            var times: [String: Int] = [:]
            times["Work"] = 12
            times["Study"] = 18
            defaults.set(times, forKey: customTime)
        }
        let times = defaults.object(forKey:customTime) as! [String: Int]
        let partialResult = times.sorted( by: { $0.0 < $1.0 })
        var result : [String] = []
        for (key, _) in partialResult {
            result.append(key)
        }
        return result
    }
    
    mutating func updateCustomTime(name: String, value: Int) {
        if (defaults.object(forKey: customTime) == nil) {
            defaults.set([:], forKey: customTime)
        }
        var times = defaults.object(forKey:customTime) as! [String: Int]
        times[name] = value
        defaults.set(times, forKey: customTime)
    }
    
    func getIsShowRank() -> Bool {
        if (defaults.object(forKey:isShowRank) == nil) {
            defaults.set(false, forKey: isShowRank)
        }
        return defaults.object(forKey:isShowRank) as! Bool
    }
    
    func updateIsShowRank(newRank: Bool) {
        defaults.set(newRank, forKey: isShowRank)
    }
    
    
    mutating func clearData() {
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
