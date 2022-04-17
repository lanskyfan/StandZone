//
//  RegisterView4.swift
//  StandZone
//
//  Created by yifanlan on 3/17/22.
//

import SwiftUI

struct RegisterView4: View {
    @ObservedObject var myController: StandZoneController
    @State private var frequency: Int = 0;
    @State private var time: Int = 0;
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
                Text("Set Daily Goal").bold().font(.title)
                Spacer()
                    .frame(height: 40)
                frequencyStepperView(frequency: $frequency, time: $time)
//                timeStepperView(time: $time)
                Spacer()
                    .frame(height: 40)
                ContinueButton(content: "Continue")
                    .onTapGesture {
                        myController.updateGoal(newFrequency: frequency, newTime: time * 5)
                        myController.updateScreen(newScreen: Screen.mainView)
                        myController.updateSetting(newSetting: true)
                    }
                Spacer()
                    .frame(height: 60)
            }
            .padding()
            
            
        }
    }
}

struct RegisterView4_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView4(myController: StandZoneController())
    }
}

struct frequencyStepperView: View {
    @Binding var frequency: Int
    @Binding var time: Int
    var body: some View {
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
                Text("Standing time (minutes)")
                Spacer()
                Picker("", selection: $time){
                    ForEach(1...24, id:\.self){ i in
                        Text(String(i * 5))
                    }
                }.labelsHidden()
                
            }
            .padding()
        }

    }
}

struct timeStepperView: View {
    @Binding var time: Int
    var body: some View {
        HStack {
            Text("Standing time (min)")
            VStack {
                Stepper("\(time)", value: $time)
            }.padding()
        }
    }
}
