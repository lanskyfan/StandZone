//
//  NoDesturbSettingView.swift
//  StandZone
//
//  Created by yifanlan on 4/20/22.
//

import SwiftUI

struct NoDisturbSettingView: View {
    @ObservedObject var myController: StandZoneController
    @State var page = true
    @State var selectDefault: Bool
    @State var customModes: Int
    @State var studyTime: Int
    @State var workTime: Int
    
    init(myController: StandZoneController) {
        let mode = myController.getUserInfo().getNoDisturbMode()
        self.myController = myController
        _selectDefault = State(initialValue: mode == NoDisturbMode.SystemMode)
        if mode == NoDisturbMode.CustomMode {
            customModes = myController.getUserInfo().getCustomMode()
        } else {
            customModes = -1
        }
        studyTime = myController.getUserInfo().getCustomTime(name: "study")
        workTime = myController.getUserInfo().getCustomTime(name: "work")
    }
    
    
    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Picker("Mode", selection: $page) {
                    Text("System Mode").tag(true).foregroundColor(Color.white)
                    Text("Custom Mode").tag(false)
                }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.top, 90.0)
                    .onAppear {
                        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.green1)
                    }
                if page == true {
                    NoDisturbDefaultView(myController: myController, selectDefault: $selectDefault, customModes: $customModes)
                } else {
                    NoDisturbCustomView(myController: myController, customModes: $customModes, mode: $selectDefault, studyTime: $studyTime, workTime: $workTime)
                }
                Spacer()
            }

        }
        .navigationBarTitle("No Disturb Mode", displayMode: .inline)
        .onDisappear() {
            if selectDefault == true {
                myController.updateNoDisturbMode(newMode: NoDisturbMode.SystemMode)
            } else if customModes == -1 {
                myController.updateNoDisturbMode(newMode: NoDisturbMode.NoMode)
            } else {
                myController.updateNoDisturbMode(newMode: NoDisturbMode.CustomMode)
                myController.updateCustomMode(newMode: customModes)
            }
            myController.updateCustomTime(name: "study", value: studyTime)
            myController.updateCustomTime(name: "work", value: workTime)
        }
    }
    
}

struct NoDisturbDefaultView: View {
    @ObservedObject var myController: StandZoneController
    @Binding var selectDefault: Bool
    @Binding var customModes: Int
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(.white).frame(height: 120)
            VStack {
                Toggle("Default", isOn: $selectDefault)
                    .onChange(of: selectDefault) { value in
                        if value == true {
                            customModes = -1
                        }
                    }
                Text("When you choose \"No Disturb Mode\" on your Apple Watch, you won't receive standing notification")
            }
            .padding()
            Spacer()
        }
    }
}

struct NoDisturbCustomView: View {
    @ObservedObject var myController: StandZoneController
    @Binding var customModes: Int
    @Binding var mode: Bool
    @Binding var studyTime: Int
    @Binding var workTime: Int
    var body: some View {
        VStack {
            Text("Edit common undisturbed mode and duration, when you choose custom mode on your Apple Watch, you won't receive standing notification in preset duration")
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill().foregroundColor(customModes == 0 ? .green1 : .white)
                    .frame(width: 300, height: 40)
                HStack {
                    Text("Study")
                    Spacer()
                    Picker("", selection: $studyTime){
                        ForEach(1...24, id:\.self){ i in
                            Text(String(i * 5) + " min")
                        }
                    }
                }
                .frame(width: 260)

            }
            .onTapGesture {
                if (customModes == 0) {
                    customModes = -1
                } else {
                    customModes = 0
                    mode = false
                }

            }
            
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                shape.fill().foregroundColor(customModes == 1 ? .green1 : .white)
                    .frame(width: 300, height: 40)
                HStack {
                    Text("Work")
                    Spacer()
                    Picker("", selection: $workTime){
                        ForEach(1...24, id:\.self){ i in
                            Text(String(i * 5) + " min")
                        }
                    }
                }
                .frame(width: 260)
            }
            .onTapGesture {
                if (customModes == 1) {
                    customModes = -1
                } else {
                    customModes = 1
                    mode = false
                }

            }
        }
        
    }
}

struct NoDesturbSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NoDisturbSettingView(myController: StandZoneController())
    }
}
