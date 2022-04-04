//
//  MainView.swift
//  StandZone
//
//  Created by yifanlan on 3/19/22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var myController: StandZoneController
    @ObservedObject var healthController: HealthViewController
    init(newController: StandZoneController, newHealthController: HealthViewController) {
        UITabBar.appearance().backgroundColor = UIColor(Color.green1)
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor(Color.green1)
        myController = newController
        healthController = newHealthController
    }
    var body: some View {
        TabView {
            HomeView(myController: myController, healthController: healthController)
                .tabItem {
                        Label("Overview", systemImage: "person.badge.clock")
                        .foregroundColor(Color.white)
                    }

            HomeView1(myController: myController, healthController: healthController)
                .tabItem {
                    Label("Data", systemImage: "waveform.path.ecg.rectangle")
                }
        
            HomeView2(newController: myController)
                .badge(10)
                .tabItem {
                    Label("Friends", systemImage: "gamecontroller")
                }
    
            HomeView3(myController: myController)
                .tabItem {
                    Label("Setting", systemImage: "gearshape")
                }
        }
        .onAppear{
            print("enter main view")
            healthController.updateHealthData()
            print("success")

        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(newController: StandZoneController(), newHealthController: HealthViewController())
    }
}
