//
//  UserModel.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import Foundation

struct UserModel {
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
            defaults.set(0, forKey: frequencyGoal)
        }
        return defaults.object(forKey:frequencyGoal) as! Int
    }
    
    mutating func updateFrequencyGoal(newGoal: Int) {
        defaults.set(newGoal, forKey: frequencyGoal)
    }
    
    func getTimeGoal() -> Int {
        if (defaults.object(forKey:timeGoal) == nil) {
            defaults.set(0, forKey: timeGoal)
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
}
