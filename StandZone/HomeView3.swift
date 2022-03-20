//
//  HomeView3.swift
//  StandZone
//
//  Created by yifanlan on 3/20/22.
//

import SwiftUI

struct HomeView3: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        NavigationView {

        ZStack {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Image("head")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .scaledToFill()
                        .padding()
                    Text("Roxanne")
                    DailyGoalView(myController: myController)
                    ReminderView(myController: myController)
                }
            }
        }
        }
    }
}

struct ReminderView: View {
    @ObservedObject var myController: StandZoneController
    // TODO Update to true value
    @State private var isNotify = true
    @State private var isRepetitiveMode = true
    @State private var isAppleWatchOnly = true
    @State private var wakeUpTime = Date()
    @State private var sleepTime = Date()
    var body: some View {
        ZStack {
            let height = 340.0
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(.green2).frame(height: height)
            VStack {
                HStack{
                    Text("Reminder")
                    Spacer()
                }
                ZStack {
                    let shape2 = RoundedRectangle(cornerRadius: 10)
                    shape2.fill().foregroundColor(.white).frame(height: height - 60)
                    VStack {
                        Toggle("Notification", isOn: $isNotify)
                            .onChange(of: isNotify) { value in
                                myController.updateIsNotify(isNotify: isNotify)
                            }
                        Toggle("Repetitive Mode", isOn: $isRepetitiveMode)
                            .onChange(of: isRepetitiveMode) { value in
                                myController.updateIsRepetitiveMode(newMode: isRepetitiveMode)
                            }
                        Toggle("Apple Watch Only", isOn: $isAppleWatchOnly)
                            .onChange(of: isAppleWatchOnly) { value in
                                myController.updateIsAppleWatchOnly(isAppleWatch: isAppleWatchOnly)
                            }
                        DatePicker("Wake up time", selection: $wakeUpTime, displayedComponents: [.hourAndMinute])
                        .onChange(of: wakeUpTime) {newValue in
                            myController.updateWakeUpTime(newWakeUpTime: wakeUpTime)
                        }
                        DatePicker("Sleep time", selection: $sleepTime, displayedComponents: [.hourAndMinute])
                        .onChange(of: sleepTime) {newValue in
                            myController.updateSleepTime(newSleepTime: sleepTime)
                        }


                    }
                    .padding()

                }

            }
            .padding()

        }
        .padding()
    }
}

struct DailyGoalView: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {

            ZStack {
                    let shape = RoundedRectangle(cornerRadius: 10)
                    shape.fill().foregroundColor(.green2).frame(height: 160)
                VStack {
                    HStack {
                            Text("Daily Goal").foregroundColor(.black)
                            Spacer()
                    }
                    
                    NavigationLink(destination: DetailSettingView()) {
                        ZStack {
                            let shape = RoundedRectangle(cornerRadius: 10)
                            shape.fill().foregroundColor(.white).frame(height: 40)
                            HStack {
                                Text("Standing frequency")
                                Spacer()
                                Text("12  >")
                            }
                            .padding()
                        }
                    }

                    NavigationLink(destination: DetailSettingView()) {
                        ZStack {
                            let shape = RoundedRectangle(cornerRadius: 10)
                            shape.fill().foregroundColor(.white).frame(height: 40)
                            HStack {
                                Text("Standing time")
                                Spacer()
                                Text("120 min  >")
                            }
                            .padding()
                        }
                    }
                    
                }
                .padding()

            }
            .padding()
        }
}


struct HomeView3_Previews: PreviewProvider {
    static var previews: some View {
        HomeView3(myController: StandZoneController())
    }
}
