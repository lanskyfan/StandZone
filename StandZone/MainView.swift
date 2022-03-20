//
//  MainView.swift
//  StandZone
//
//  Created by yifanlan on 3/19/22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var myController: StandZoneController
    init(newController: StandZoneController) {
        UITabBar.appearance().backgroundColor = UIColor(Color.green1)
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().unselectedItemTintColor = UIColor.white

//        UITabBar.appearance().barTintColor = UIColor(Color("tab_background"))
        myController = newController
    }
    var body: some View {
        TabView {
            HomeView(myController: myController)
                .tabItem {
                        Label("Overview", systemImage: "person.badge.clock")
                        .foregroundColor(Color.white)

                    }
                .navigationBarTitle("4")
                .navigationBarHidden(true)

            HomeView1(myController: myController)
                .tabItem {
                    Label("Data", systemImage: "waveform.path.ecg.rectangle")
                }
                .navigationBarTitle("2")
                .navigationBarHidden(true)
        
            Text("Hello there")
                .badge(10)
                .tabItem {
                    Label("Friends", systemImage: "gamecontroller")
                }
                .navigationBarTitle("3")
                .navigationBarHidden(true)
    
            Text("Hello there")
                .tabItem {
                    Label("Setting", systemImage: "gearshape")
                }
                .navigationBarTitle("4")
                .navigationBarHidden(true)
        }

    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(newController: StandZoneController())
    }
}
