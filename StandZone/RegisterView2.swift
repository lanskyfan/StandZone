//
//  RegisterView2.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct RegisterView2: View {
    @ObservedObject var myController: StandZoneController
    var body: some View {
        ZStack (alignment: .top) {
            Image("background1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 20){
//                MyShape()
                ProgressCircle()
                Spacer()
                    .frame(height: 40)
                Text("Notification Schedule").bold().font(.title)
                Spacer()
                    .frame(height: 40)
                TimeView(myController: myController)
                Spacer()
                    .frame(height: 40)
                NavigationLink(destination: RegisterView3(myController: myController)) {
                    ContinueButton(content: "Continue")
                }
                .buttonStyle(PlainButtonStyle())
                Spacer()
                    .frame(height: 60)
            }
            .padding()
            
            
        }
    }
}


struct TimeView: View {
    var myController: StandZoneController
    @State var wakeUpTime = Date()
    @State var sleepTime = Date()
    var body: some View {
        VStack {
            HStack {
                Text("Wake up time").bold()
                Spacer().frame(width: 40)
                Text("Sleeping time").bold()
            }
            HStack {
                VStack {
                    DatePicker("", selection: $wakeUpTime, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                    .onChange(of: wakeUpTime) {newValue in
                        myController.updateWakeUpTime(newWakeUpTime: wakeUpTime)
                    }
                }.padding()
                Text("To")
                VStack {
                    DatePicker("", selection: $sleepTime, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
                    .onChange(of: sleepTime) {newValue in
                        myController.updateSleepTime(newSleepTime: sleepTime)
                    }
                }.padding()
            }
        }


    }
}

struct RegisterView2_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView2(myController: StandZoneController())
    }
}
