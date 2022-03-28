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
                frequencyStepperView(frequency: $frequency)
                timeStepperView(time: $time)
                Spacer()
                    .frame(height: 40)
                ContinueButton(content: "Continue")
                    .onTapGesture {
                        myController.updateScreen(newScreen: Screen.mainView)
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
    var body: some View {
        HStack {
            Text("Stand Frequency")
            VStack {
                Stepper("\(frequency)", value: $frequency)
            }.padding()
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
