//
//  StandZoneApp.swift
//  StandZone
//
//  Created by yifanlan on 3/16/22.
//

import SwiftUI

@main
struct StandZoneApp: App {
    @ObservedObject var myController: StandZoneController
    init() {
        myController = StandZoneController()
        myController.register()
        myController.scheduleAppRefresh()
    }
    var body: some Scene {
        WindowGroup {
            SwitchView(myController: myController)
        }
    }
}
