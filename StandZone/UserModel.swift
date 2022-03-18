//
//  UserModel.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import Foundation

struct UserModel {
    private var password: String?
    private var email: String?
    private var name: String?
    private var gender: String?
    private var frequencyGoal: Int?
    private var timeGoal: Int?
    private var wakeUpTime: Date?
    private var sleepTime: Date?
    
    func getEmail() -> String {
        return email!
    }
    
    mutating func updateEmail(newEmail: String) {
        email = newEmail
    }
    
    
    func getName() -> String {
        return name!
    }
    
    mutating func updateName(newName: String) {
        name = newName
    }
    
    func getGender() -> String {
        return gender!
    }
    
    mutating func updateGender(newGender: String) {
        gender = newGender
    }
    
    func getPassword() -> String {
        return password!
    }
    
    mutating func updatePassword(newPassword: String) {
        password = newPassword
    }
    
    func getFrequencyGoal() -> Int{
        return frequencyGoal!
    }
    
    mutating func updateFrequencyGoal(newGoal: Int) {
        frequencyGoal = newGoal
    }
    
    func getTimeGoal() -> Int {
        return timeGoal!
    }
    
    mutating func updateTimeGoal(newGoal: Int) {
        timeGoal = newGoal
    }
    
    func getWakeUpTime() -> Date {
        return wakeUpTime!
    }
    
    mutating func updateWakeUpTime(newTime: Date) {
        print("update wake up time")
        wakeUpTime = newTime
    }
    
    func getSleepTime() -> Date {
        return sleepTime!
    }
    
    mutating func updateSleepTime(newTime: Date) {
        print("update sleep time")
        sleepTime = newTime
    }
}
