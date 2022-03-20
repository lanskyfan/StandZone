//
//  StandZoneController.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

class StandZoneController: ObservableObject {
    @Published private var screen = Screen.initialView
    @Published private var user = UserModel()
    
    func getScreen() -> Screen{
        return screen
    }
    
    func updateScreen(newScreen: Screen) {
//        objectWillChange.send()
        print("My new screen is \(newScreen)")
        screen = newScreen
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
    
    func updateGender(newGender: String) {
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
}
