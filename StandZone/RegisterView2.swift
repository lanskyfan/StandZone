//
//  RegisterView2.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct RegisterView2: View {
    @ObservedObject var myController: StandZoneController
    @State private var wakeUpTime: Date = Date()
    @State private var sleepTime: Date = Date()
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
                TimeView(wakeUpTime: $wakeUpTime, sleepTime: $sleepTime)
                Spacer()
                    .frame(height: 40)
                ContinueButton(content: "Continue")
                    .onTapGesture {
                        myController.updateNotification(newWakeUpTime: wakeUpTime, newSleepTime: sleepTime)
                        myController.updateScreen(newScreen: Screen.registerView3)
                    }
                Spacer()
                    .frame(height: 60)
            }
            .padding()
            
            
        }
    }
}


struct TimeView: View {
    
    @Binding var wakeUpTime: Date
    @Binding var sleepTime: Date
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
                }.padding()
                Text("To")
                VStack {
                    DatePicker("", selection: $sleepTime, displayedComponents: [.hourAndMinute])
                    .labelsHidden()
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
