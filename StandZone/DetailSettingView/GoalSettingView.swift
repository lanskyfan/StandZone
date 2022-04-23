//
//  GoalSettingView.swift
//  StandZone
//
//  Created by yifanlan on 3/20/22.
//

import SwiftUI

struct GoalSettingView: View {
    @ObservedObject var myController: StandZoneController
    @State private var name: String
    @State private var gender: Gender
    @State private var frequency: Int
    @State private var time: Int
    
    init(myController: StandZoneController) {
        self.myController = myController
        _name = State(initialValue: myController.getUserInfo().getName())
        _gender = State(initialValue: myController.getUserInfo().getGender())
        _frequency = State(initialValue: myController.getUserInfo().getFrequencyGoal())
        _time = State(initialValue: myController.getUserInfo().getTimeGoal())
    }
    
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                SettingTopView(myController: myController)
                BasicInfoView(myController: myController, name: $name, gender: $gender)
                DailyGoalNoLinkView(myController: myController, frequency: $frequency, time: $time)
            }
        }
        .onDisappear {
            myController.updateName(newName: name)
            myController.updateGender(newGender: gender)
            myController.updateGoal(newFrequency: frequency, newTime: time)
            print(gender)
        }
    }
}

struct BasicInfoView: View {
    @ObservedObject var myController: StandZoneController
    @Binding var name: String
    @Binding var gender: Gender
    var body: some View {

            ZStack {
                    let shape = RoundedRectangle(cornerRadius: 10)
                    shape.fill().foregroundColor(.green2).frame(height: 160)
                VStack {
                    HStack {
                            Text("Basic Information").foregroundColor(.white)
                            Spacer()
                    }
                    
                    ZStack {
                        let shape = RoundedRectangle(cornerRadius: 10)
                        shape.fill().foregroundColor(.white).frame(height: 40)
                        HStack {
                            Text("Nickname")
                            Spacer()
                            TextField(text: $name, prompt: Text("Required")) {
                                Text("Username")
                            }.disableAutocorrection(true)
                                .multilineTextAlignment(.trailing)
                                .frame(width: 100)
                            
                        }
                        .padding()
                    }

                    ZStack {
                        let shape = RoundedRectangle(cornerRadius: 10)
                        shape.fill().foregroundColor(.white).frame(height: 40)
                        HStack {
                            Text("Gender")
                            Spacer()
                            Picker("Gender", selection: $gender) {
                                Text("Male").tag(Gender.Male)
                                Text("Female").tag(Gender.Female)
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

struct DailyGoalNoLinkView: View {
    @ObservedObject var myController: StandZoneController
    @Binding var frequency: Int
    @Binding var time: Int
    var body: some View {

            ZStack {
                    let shape = RoundedRectangle(cornerRadius: 10)
                    shape.fill().foregroundColor(.green2).frame(height: 180)
                VStack {
                    HStack {
                            Text("Daily Goal").foregroundColor(.white)
                            Spacer()
                    }
                    
                    ZStack {
                        let shape = RoundedRectangle(cornerRadius: 10)
                        shape.fill().foregroundColor(.white).frame(height: 40)
                        HStack {
                            Text("Standing frequency")
                            Spacer()
                            Picker("", selection: $frequency){
                                ForEach(1...12, id:\.self){ i in
                                    Text(String(i))
                                }
                            }.labelsHidden()
                            
                        }
                        .padding()
                    }

                    ZStack {
                        let shape = RoundedRectangle(cornerRadius: 10)
                        shape.fill().foregroundColor(.white).frame(height: 40)
                        HStack {
                            Text("Standing time")
                            Spacer()
                            Picker("", selection: $time){
                                ForEach(1...24, id:\.self){ i in
                                    Text(String(i * 5) + " min")
                                }
                            }.labelsHidden()
                            
                        }
                        .padding()
                    }
                    
                }
                .padding()

            }
            .padding()
        }
}

struct DetailSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GoalSettingView(myController: StandZoneController())
    }
}
