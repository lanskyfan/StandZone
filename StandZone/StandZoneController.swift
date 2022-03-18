//
//  StandZoneController.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

class StandZoneController: ObservableObject {
    @Published private var screen : Int = 0
    @Published private var user = UserModel(password: "", email: "", name: "", gender: "", frequencyGoal: 0, timeGoal: 0, wakeUpTime: Date(), sleepTime: Date())
    
    func getScreen() -> Int{
        return screen
    }
    
    func updateScreen(newScreen: Int) {
//        objectWillChange.send()
        print("My new screen is \(newScreen)")
        screen = newScreen
    }
    
    func getEmail() -> String {
        return user.email
    }
    
    func updateEmail(newEmail: String) {
        user.email = newEmail
    }
    
    
    func getName() -> String {
        return user.name
    }
    
    func updateName(newName: String) {
        user.name = newName
    }
    
    func getGender() -> String {
        return user.gender
    }
    
    func updateGender(newGender: String) {
        user.gender = newGender
    }
    
    func getPassword() -> String {
        return user.password
    }
    
    func updatePassword(newPassword: String) {
        user.password = newPassword
    }
    
    func getFrequencyGoal() -> Int{
        return user.frequencyGoal
    }
    
    func updateFrequencyGoal(newGoal: Int) {
        user.frequencyGoal = newGoal
    }
    
    func getTimeGoal() -> Int {
        return user.timeGoal
    }
    
    func updateTimeGoal(newGoal: Int) {
        user.timeGoal = newGoal
    }
    
    func getWakeUpTime() -> Date {
        return user.wakeUpTime
    }
    
    func updateWakeUpTime(newTime: Date) {
        print("update wake up time")
        user.wakeUpTime = newTime
    }
    
    func getSleepTime() -> Date {
        return user.sleepTime
    }
    
    func updateSleepTime(newTime: Date) {
        print("update sleep time")
        user.sleepTime = newTime
    }
}
