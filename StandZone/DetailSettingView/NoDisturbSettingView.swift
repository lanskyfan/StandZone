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
    
    init(myController: StandZoneController) {
        let mode = myController.getUserInfo().getNoDisturbMode()
        self.myController = myController
        _selectDefault = State(initialValue: mode == NoDisturbMode.SystemMode)
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
                    NoDisturbDefaultView(myController: myController, selectDefault: $selectDefault)
                } else {
                    NoDisturbCustomView(myController: myController)
                }
                Spacer()
            }

        }
        .navigationBarTitle("No Disturb Mode", displayMode: .inline)
        .onDisappear() {
            if selectDefault == true {
                myController.updateNoDisturbMode(newMode: NoDisturbMode.SystemMode)
            } else {
                myController.updateNoDisturbMode(newMode: NoDisturbMode.CustomMode)
            }
        }
    }
    
}

struct NoDisturbDefaultView: View {
    @ObservedObject var myController: StandZoneController
    @Binding var selectDefault: Bool
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            shape.fill().foregroundColor(.white).frame(height: 120)
            VStack {
                Toggle("Default", isOn: $selectDefault)
                Text("When you choose \"No Disturb Mode\" on your Apple Watch, you won't receive standing notification")
            }
            .padding()
            Spacer()
        }
    }
}

struct NoDisturbCustomView: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        VStack {
            Text("Edit common undisturbed mode and duration, when you choose custom mode on your Apple Watch, you won't receive standing notification in preset duration")
                .padding()
            ScrollView {
                ForEach(myController.getUserInfo().getCustomFull(),id: \.self) {data in
                    lineView(myController: myController, newName: data)

                }
                newLineView(myController: myController)

            }

            
        }
        
    }
}

struct lineView: View {
    @ObservedObject var myController: StandZoneController
    @State var name: String
    @State var value: Int
    
    init(myController: StandZoneController, newName: String) {
        self.myController = myController
        _name = State(initialValue: newName)
        _value = State(initialValue: myController.getUserInfo().getCustomTime(name: newName))
    }
    
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
//            shape.fill().foregroundColor(customModes == 0 ? .green1 : .white)
            shape.fill().foregroundColor(.white)
                .frame(width: 300, height: 40)
            HStack {
                Image(systemName: "minus.circle").font(.system(size: 20))
                    .onTapGesture {
                        if name != "Work" && name != "Study" {
                            myController.deleteCustomTime(name: name)
                        }
                    }
                Text(name)
                Spacer()
                Picker("", selection: $value){
                    ForEach(1...24, id:\.self){ i in
                        Text(String(i * 5) + " min")
                    }
                }
                .onChange(of: value) { tag in
                    myController.updateCustomTime(name: name, value: tag)
                }
                
            }
            .frame(width: 260)

        }
        

    }
}


struct newLineView: View {
    @ObservedObject var myController: StandZoneController
    @State var name: String
    @State var value: Int = 0
    init(myController: StandZoneController) {
        self.myController = myController
        _name = State(initialValue: "Custom" + String(myController.getUserInfo().getCustomFull().count - 1))
    }
    
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
//            shape.fill().foregroundColor(customModes == 0 ? .green1 : .white)
            shape.fill().foregroundColor(.white)
                .frame(width: 300, height: 40)
            HStack {
                Image(systemName: "plus.circle").font(.system(size: 20))
                    .onTapGesture {
                        name = "Custom" + String(myController.getUserInfo().getCustomFull().count - 1)
                        myController.updateCustomTime(name: name, value: value)
                        name = "Custom" + String(myController.getUserInfo().getCustomFull().count - 1)
                    }
                Text("new custom mode")
                Spacer()
                Picker("", selection: $value){
                    ForEach(1...24, id:\.self){ i in
                        Text(String(i * 5) + " min")
                    }
                }
                
            }
            .frame(width: 260)

        }
        

    }
}
struct NoDesturbSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NoDisturbSettingView(myController: StandZoneController())
    }
}
