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
                        SettingTopView(myController: myController)
                        DailyGoalView(myController: myController)
                        ReminderView(myController: myController)
                    }
                } .padding(.top, 50)
            }
        }
    }
}

struct SettingTopView: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        Image("head")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .scaledToFill()
            .padding()
        Text(myController.getUserInfo().getName())
    }
}
struct ReminderView: View {
    @ObservedObject var myController: StandZoneController
    @State private var isNotify: Bool
    @State private var isRepetitiveMode: Bool
    @State private var isAppleWatchOnly: Bool
    @State private var wakeUpTime: Date
    @State private var sleepTime: Date
    @State private var isImportCalendar: Bool
    
    init(myController: StandZoneController) {
        self.myController = myController
        _isNotify = State(initialValue: myController.getUserInfo().getIsNotify())
        _isRepetitiveMode = State(initialValue: myController.getUserInfo().getIsRepetitiveMode())
        _isAppleWatchOnly = State(initialValue: myController.getUserInfo().getIsAppleWatchOnly())
        _wakeUpTime = State(initialValue: myController.getUserInfo().getWakeUpTime())
        _sleepTime = State(initialValue: myController.getUserInfo().getSleepTime())
        _isImportCalendar = State(initialValue:myController.getUserInfo().getIsImportCalendar())
    }
    
    var body: some View {
        ZStack {
            let height = 400.0
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
                        Toggle("Import Calendar", isOn: $isImportCalendar)
                            .onChange(of: isImportCalendar) { value in
                                myController.updateIsImportCalendar(isImportCalendar: isImportCalendar)
                            }
                        Text("")
                        Text("")
                        Text("")
                        Text("")


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
                    
                    NavigationLink(destination: DetailSettingView(myController: myController)) {
                        ZStack {
                            let shape = RoundedRectangle(cornerRadius: 10)
                            shape.fill().foregroundColor(.white).frame(height: 40)
                            HStack {
                                Text("Standing frequency")
                                Spacer()
                                Text(String(myController.getUserInfo().getFrequencyGoal()) + "  >")
                            }
                            .padding()
                        }
                    }

                    NavigationLink(destination: DetailSettingView(myController: myController)) {
                        ZStack {
                            let shape = RoundedRectangle(cornerRadius: 10)
                            shape.fill().foregroundColor(.white).frame(height: 40)
                            HStack {
                                Text("Standing time")
                                Spacer()
                                Text(String(myController.getUserInfo().getTimeGoal() * 5) + "min  >")
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
