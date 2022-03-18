//
//  StandZoneController.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

class StandZoneController: ObservableObject {
    @Published private var screen : Int = 0
    @Published private var user = UserModel()
    
    func getScreen() -> Int{
        return screen
    }
    
    func updateScreen(newScreen: Int) {
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
    
    func updateBasicInfo(newName: String, newGender: String) {
        user.updateName(newName: newName)
        user.updateGender(newGender: newGender)
    }
    
    func updateNotification(newWakeUpTime: Date, newSleepTime: Date) {
        user.updateWakeUpTime(newTime: newWakeUpTime)
        user.updateSleepTime(newTime: newSleepTime)
    }
    
    func updateGoal(newFrequency: Int, newTime: Int) {
        user.updateFrequencyGoal(newGoal: newFrequency)
        user.updateTimeGoal(newGoal: newTime)
    }
}
